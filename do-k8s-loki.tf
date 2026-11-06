locals {
  do-loki = {
    release_name = "loki"
    # In-cluster URL, used by Alloy (push) and the Grafana datasource (query).
    url = "http://loki.${kubernetes_namespace_v1.do-monitoring.metadata[0].name}.svc:3100"

    # Start of the tsdb/v13 schema period.
    # Logs before this date were written with boltdb-shipper/v11 (by Loki 2.x), which Loki 3 can still read.
    # It must be a date (UTC) in the future when the schema period is first deployed.
    tsdb_from = "2026-11-09"
  }
}

resource "random_string" "do-loki-bucket-suffix" {
  length  = 8
  lower   = true
  upper   = false
  special = false
}

resource "digitalocean_spaces_bucket" "loki" {
  name          = "loki-${random_string.do-loki-bucket-suffix.result}"
  region        = "fra1"
  acl           = "private"
  force_destroy = true
}

# kubectl -n monitoring create secret generic loki-do-spaces --from-literal=SPACES_KEY=FIXME --from-literal=SPACES_SECRET=FIXME
data "kubernetes_secret_v1" "loki-do-spaces" {
  provider = kubernetes.do
  metadata {
    namespace = kubernetes_namespace_v1.do-monitoring.metadata[0].name
    name      = "loki-do-spaces"
  }
}

# https://github.com/grafana/loki/tree/main/production/helm/loki
resource "helm_release" "do-loki" {
  provider = helm.do

  namespace  = kubernetes_namespace_v1.do-monitoring.metadata[0].name
  name       = local.do-loki.release_name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = "7.5.0"
  values = [
    yamlencode({
      "deploymentMode" : "SingleBinary",
      "loki" : {
        # Single tenant. Existing data (from loki-stack) is stored under the implicit tenant "fake".
        "auth_enabled" : false,
        "commonConfig" : {
          "replication_factor" : 1,
        },
        "storage" : {
          "type" : "s3",
          "bucketNames" : {
            "chunks" : digitalocean_spaces_bucket.loki.name,
            "ruler" : digitalocean_spaces_bucket.loki.name,
            "admin" : digitalocean_spaces_bucket.loki.name,
          },
          "s3" : {
            "endpoint" : "${digitalocean_spaces_bucket.loki.region}.digitaloceanspaces.com",
            "region" : digitalocean_spaces_bucket.loki.region,
            # Expanded by Loki (-config.expand-env) from the loki-do-spaces secret.
            "accessKeyId" : "$${SPACES_KEY}",
            "secretAccessKey" : "$${SPACES_SECRET}",
            "s3ForcePathStyle" : true,
          },
        },
        "schemaConfig" : {
          "configs" : [
            {
              "from" : "2021-01-01",
              "store" : "boltdb-shipper",
              "object_store" : "aws",
              "schema" : "v11",
              "index" : {
                "prefix" : "loki_",
                "period" : "24h",
              },
            },
            {
              "from" : local.do-loki.tsdb_from,
              "store" : "tsdb",
              "object_store" : "aws",
              "schema" : "v13",
              "index" : {
                "prefix" : "loki_tsdb_",
                "period" : "24h",
              },
            },
          ],
        },
        "limits_config" : {
          "retention_period" : "1440h", # 60 days
          # Structured metadata requires schema v13, which only becomes active at local.do-loki.tsdb_from.
          # TODO: remove after local.do-loki.tsdb_from
          "allow_structured_metadata" : false,
          # Headroom for Alloy re-reading the existing pod log files on first start.
          "ingestion_rate_mb" : 10,
          "ingestion_burst_size_mb" : 20,
        },
        "compactor" : {
          "retention_enabled" : true,
          "delete_request_store" : "aws",
        },
      },
      "singleBinary" : {
        "replicas" : 1,
        "extraArgs" : ["-config.expand-env=true"],
        "extraEnvFrom" : [{
          "secretRef" : {
            "name" : data.kubernetes_secret_v1.loki-do-spaces.metadata[0].name,
          },
        }],
        # WAL, active index files, and compactor working directory
        "persistence" : {
          "enabled" : true,
          "size" : "10Gi",
          "storageClass" : "do-block-storage",
        },
        "resources" : {
          "requests" : {
            "cpu" : "100m",
            "memory" : "256Mi",
          },
        },
      },
      # Disable the components that are not used in the single binary mode.
      "backend" : { "replicas" : 0 },
      "read" : { "replicas" : 0 },
      "write" : { "replicas" : 0 },
      "gateway" : { "enabled" : false },
      "chunksCache" : { "enabled" : false },
      "resultsCache" : { "enabled" : false },
      "lokiCanary" : { "enabled" : false },
      "test" : { "enabled" : false },
      "ruler" : { "enabled" : false },
      "sidecar" : {
        "rules" : { "enabled" : false },
      },
    })
  ]
}

# Collects pod logs on every node and pushes them to Loki.
# The labels are the same as the ones produced by promtail of loki-stack,
# such that queries work across logs collected before and after the migration.
# https://github.com/grafana/alloy/tree/main/operations/helm/charts/alloy
resource "helm_release" "do-alloy" {
  provider = helm.do

  namespace  = kubernetes_namespace_v1.do-monitoring.metadata[0].name
  name       = "alloy"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "alloy"
  version    = "1.15.0"
  values = [
    yamlencode({
      "controller" : {
        "type" : "daemonset",
        "volumes" : {
          "extra" : [{
            "name" : "alloy-data",
            "hostPath" : {
              "path" : "/var/lib/alloy",
              "type" : "DirectoryOrCreate",
            },
          }],
        },
      },
      "alloy" : {
        # Keep the read positions of the log files on the node, to avoid re-sending logs when the pod restarts.
        "storagePath" : "/var/lib/alloy",
        "mounts" : {
          "varlog" : true,
          "extra" : [{
            "name" : "alloy-data",
            "mountPath" : "/var/lib/alloy",
          }],
        },
        "resources" : {
          "requests" : {
            "cpu" : "20m",
            "memory" : "64Mi",
          },
        },
        "configMap" : {
          "content" : <<-EOT
            discovery.kubernetes "pods" {
              role = "pod"
              selectors {
                role  = "pod"
                field = "spec.nodeName=" + sys.env("HOSTNAME")
              }
            }

            discovery.relabel "pods" {
              targets = discovery.kubernetes.pods.targets

              rule {
                source_labels = ["__meta_kubernetes_pod_controller_name"]
                regex         = "([0-9a-z-.]+?)(-[0-9a-f]{8,10})?"
                target_label  = "__tmp_controller_name"
              }
              rule {
                source_labels = [
                  "__meta_kubernetes_pod_label_app_kubernetes_io_name",
                  "__meta_kubernetes_pod_label_app",
                  "__tmp_controller_name",
                  "__meta_kubernetes_pod_name",
                ]
                regex        = "^;*([^;]+)(;.*)?$"
                target_label = "app"
              }
              rule {
                source_labels = [
                  "__meta_kubernetes_pod_label_app_kubernetes_io_instance",
                  "__meta_kubernetes_pod_label_release",
                ]
                regex        = "^;*([^;]+)(;.*)?$"
                target_label = "instance"
              }
              rule {
                source_labels = [
                  "__meta_kubernetes_pod_label_app_kubernetes_io_component",
                  "__meta_kubernetes_pod_label_component",
                ]
                regex        = "^;*([^;]+)(;.*)?$"
                target_label = "component"
              }
              rule {
                source_labels = ["__meta_kubernetes_pod_node_name"]
                target_label  = "node_name"
              }
              rule {
                source_labels = ["__meta_kubernetes_namespace"]
                target_label  = "namespace"
              }
              rule {
                source_labels = ["namespace", "app"]
                separator     = "/"
                target_label  = "job"
              }
              rule {
                source_labels = ["__meta_kubernetes_pod_name"]
                target_label  = "pod"
              }
              rule {
                source_labels = ["__meta_kubernetes_pod_container_name"]
                target_label  = "container"
              }
              rule {
                source_labels = ["__meta_kubernetes_pod_uid", "__meta_kubernetes_pod_container_name"]
                separator     = "/"
                replacement   = "/var/log/pods/*$1/*.log"
                target_label  = "__path__"
              }
              // static pods
              rule {
                source_labels = [
                  "__meta_kubernetes_pod_annotationpresent_kubernetes_io_config_hash",
                  "__meta_kubernetes_pod_annotation_kubernetes_io_config_hash",
                  "__meta_kubernetes_pod_container_name",
                ]
                separator    = "/"
                regex        = "true/(.*)"
                replacement  = "/var/log/pods/*$1/*.log"
                target_label = "__path__"
              }
            }

            local.file_match "pods" {
              path_targets = discovery.relabel.pods.output
            }

            loki.source.file "pods" {
              targets    = local.file_match.pods.targets
              forward_to = [loki.process.pods.receiver]
            }

            loki.process "pods" {
              stage.cri {}
              forward_to = [loki.write.default.receiver]
            }

            loki.write "default" {
              endpoint {
                url = "${local.do-loki.url}/loki/api/v1/push"
                // Keep retrying for ~6 hours (backoff doubles from 500ms up to max_backoff_period)
                // before dropping a batch, so a Loki restart/upgrade/outage doesn't lose logs.
                // While retrying, Alloy stops reading, and the logs wait in the pod log files on the node.
                max_backoff_period  = "5m"
                max_backoff_retries = 80
              }
            }
          EOT
        },
      },
    })
  ]

  depends_on = [
    helm_release.do-loki,
  ]
}
