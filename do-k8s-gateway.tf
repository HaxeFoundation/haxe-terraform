# NGINX Gateway Fabric (Gateway API), replacing ingress-nginx (do-k8s-ingress.tf).
#
# Bootstrapping: `kubernetes_manifest` needs its CRD to exist at plan time, so on a fresh cluster apply in two steps:
#   tofu apply -target=module.do-gateway-api-crds -target=module.do-nginx-gateway-fabric-crds -target=helm_release.do-nginx-gateway-fabric
#   tofu apply -exclude=data.kubernetes_service_v1.do-gateway  # the Gateway's Service doesn't exist yet
#   tofu apply

locals {
  do-gateway = {
    name      = "haxe"
    namespace = "nginx-gateway"
    class     = "nginx"

    # Every HTTPS hostname gets its own listener ("https-<key>") and Let's Encrypt certificate ("<key>-tls").
    # The haxelib routes (in the haxelib repo) attach to the "https-lib-dev" and "https-lib-prod" listeners.
    https_hosts = merge(
      { for k, v in local.build_haxe_org.stage : "build-${k}" => v.host },
      {
        lib-dev  = "development-lib.haxe.org"
        lib-prod = "lib.haxe.org"
        grafana  = local.do-grafana.hostnames[0]
      },
    )

    # Namespaces allowed to attach routes to the Gateway.
    # "nginx-gateway" is for the HTTP-01 challenge routes of the Gateway certificates (letsencrypt-production-gateway).
    route_namespaces = ["default", "monitoring", "nginx-gateway"]

    parent_ref = {
      group     = "gateway.networking.k8s.io"
      kind      = "Gateway"
      name      = "haxe"
      namespace = "nginx-gateway"
    }
  }
}

module "do-gateway-api-crds" {
  source = "./gateway-api.crds"
  providers = {
    kubernetes = kubernetes.do
  }
}

# DOKS pre-installed these Gateway API CRDs (v1.2.1). Adopt them so that Terraform can upgrade them.
import {
  to = module.do-gateway-api-crds.kubernetes_manifest.customresourcedefinition_gatewayclasses_gateway_networking_k8s_io
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=gatewayclasses.gateway.networking.k8s.io"
}
import {
  to = module.do-gateway-api-crds.kubernetes_manifest.customresourcedefinition_gateways_gateway_networking_k8s_io
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=gateways.gateway.networking.k8s.io"
}
import {
  to = module.do-gateway-api-crds.kubernetes_manifest.customresourcedefinition_grpcroutes_gateway_networking_k8s_io
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=grpcroutes.gateway.networking.k8s.io"
}
import {
  to = module.do-gateway-api-crds.kubernetes_manifest.customresourcedefinition_httproutes_gateway_networking_k8s_io
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=httproutes.gateway.networking.k8s.io"
}
import {
  to = module.do-gateway-api-crds.kubernetes_manifest.customresourcedefinition_referencegrants_gateway_networking_k8s_io
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=referencegrants.gateway.networking.k8s.io"
}
import {
  to = module.do-gateway-api-crds.kubernetes_manifest.customresourcedefinition_tlsroutes_gateway_networking_k8s_io
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=tlsroutes.gateway.networking.k8s.io"
}

module "do-nginx-gateway-fabric-crds" {
  source = "./nginx-gateway-fabric.crds"
  providers = {
    kubernetes = kubernetes.do
  }
}

resource "kubernetes_namespace_v1" "do-nginx-gateway" {
  provider = kubernetes.do
  metadata {
    name = local.do-gateway.namespace
  }
}

# https://github.com/nginx/nginx-gateway-fabric/tree/main/charts/nginx-gateway-fabric
resource "helm_release" "do-nginx-gateway-fabric" {
  provider = helm.do

  name       = "nginx-gateway-fabric"
  namespace  = kubernetes_namespace_v1.do-nginx-gateway.metadata[0].name
  repository = "oci://ghcr.io/nginx/charts"
  chart      = "nginx-gateway-fabric"
  version    = "2.8.1" # keep in sync with the Earthfile target +nginx-gateway-fabric.crds

  skip_crds = true # CRDs are installed by module.do-nginx-gateway-fabric-crds

  values = [yamlencode({
    nginxGateway = {
      gatewayClassName = local.do-gateway.class
      # For SnippetsPolicy (proxy_cache_path) and SnippetsFilter (proxy_cache), see below.
      snippets = {
        enable = true
      }
      productTelemetry = {
        enable = false
      }
      metrics = {
        serviceMonitor = {
          enable = true
        }
      }
    }

    # Applied to the NGINX data plane of every Gateway.
    nginx = {
      replicas = 2
      podDisruptionBudget = {
        enable       = true
        minAvailable = 1
      }
      pod = {
        topologySpreadConstraints = [
          {
            maxSkew           = 1
            topologyKey       = "kubernetes.io/hostname"
            whenUnsatisfiable = "ScheduleAnyway"
            labelSelector = {
              matchLabels = {
                "gateway.networking.k8s.io/gateway-name" = local.do-gateway.name
              }
            }
          }
        ]
      }
      config = {
        # The DO load balancer sends the client address with the PROXY protocol
        # (see "do-loadbalancer-enable-proxy-protocol" on the Gateway).
        rewriteClientIP = {
          mode = "ProxyProtocol"
          trustedAddresses = [
            {
              type  = "CIDR"
              value = "10.106.0.0/20" # the cluster's VPC (default-lon1): the load balancer
            },
            {
              # The pod network: with externalTrafficPolicy "Cluster", connections forwarded from another node
              # arrive from that node's pod network address.
              type  = "CIDR"
              value = "10.244.0.0/16"
            },
          ]
        }
      }
      service = {
        # Client addresses come from the PROXY protocol, so there's no need for "Local".
        # "Cluster" lets the DO load balancer use every node, which keeps NGINX rollouts smooth.
        externalTrafficPolicy = "Cluster"
      }
      serviceMonitor = {
        enable = true
      }
    }
  })]

  depends_on = [
    module.do-gateway-api-crds,
    module.do-nginx-gateway-fabric-crds,
  ]
}

resource "kubernetes_manifest" "do-gateway" {
  provider = kubernetes.do

  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "Gateway"
    metadata = {
      name      = local.do-gateway.name
      namespace = local.do-gateway.namespace
    }
    spec = {
      gatewayClassName = local.do-gateway.class
      # Copied to the generated LoadBalancer Service.
      infrastructure = {
        annotations = {
          "service.beta.kubernetes.io/do-loadbalancer-name" = "haxe-gateway"
          # The HTTP load balancer, as used by ingress-nginx. Since DOKS 1.33.1 the default is "REGIONAL_NETWORK",
          # a network load balancer (public preview) that supports neither the PROXY protocol nor the hostname annotation below.
          "service.beta.kubernetes.io/do-loadbalancer-type"                  = "REGIONAL"
          "service.beta.kubernetes.io/do-loadbalancer-enable-proxy-protocol" = "true"
          # Makes in-cluster traffic to the load balancer go through the load balancer, so that it gets the PROXY header.
          # https://docs.digitalocean.com/products/kubernetes/how-to/configure-load-balancers/#accessing-by-hostname
          "service.beta.kubernetes.io/do-loadbalancer-hostname" = "do-k8s-gw.haxe.org"
        }
      }
      listeners = concat(
        [{
          name     = "http"
          protocol = "HTTP"
          port     = 80
          allowedRoutes = {
            namespaces = {
              from = "Selector"
              selector = {
                matchExpressions = [{
                  key      = "kubernetes.io/metadata.name"
                  operator = "In"
                  values   = local.do-gateway.route_namespaces
                }]
              }
            }
          }
        }],
        [for k, host in local.do-gateway.https_hosts : {
          name     = "https-${k}"
          protocol = "HTTPS"
          port     = 443
          hostname = host
          tls = {
            mode = "Terminate"
            certificateRefs = [{
              kind = "Secret"
              name = "${k}-tls"
            }]
          }
          allowedRoutes = {
            namespaces = {
              from = "Selector"
              selector = {
                matchExpressions = [{
                  key      = "kubernetes.io/metadata.name"
                  operator = "In"
                  values   = local.do-gateway.route_namespaces
                }]
              }
            }
          }
        }],
      )
    }
  }

  depends_on = [helm_release.do-nginx-gateway-fabric]
}

# Certificates of the Gateway listeners.
# They are separate from the certificates of the Ingresses, so the two can run side by side.
resource "kubernetes_manifest" "do-gateway-certificate" {
  for_each = local.do-gateway.https_hosts
  provider = kubernetes.do

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"
    metadata = {
      name      = "${each.key}-tls"
      namespace = local.do-gateway.namespace
    }
    spec = {
      secretName = "${each.key}-tls"
      dnsNames   = [each.value]
      issuerRef = {
        group = "cert-manager.io"
        kind  = "ClusterIssuer"
        name  = "letsencrypt-production"
      }
    }
  }

  depends_on = [kubernetes_namespace_v1.do-nginx-gateway]
}

# Same as ingress-nginx's "proxy-body-size" (do-k8s-ingress.tf).
resource "kubernetes_manifest" "do-gateway-client-settings" {
  provider = kubernetes.do

  manifest = {
    apiVersion = "gateway.nginx.org/v1alpha1"
    kind       = "ClientSettingsPolicy"
    metadata = {
      name      = local.do-gateway.name
      namespace = local.do-gateway.namespace
    }
    spec = {
      targetRef = {
        group = "gateway.networking.k8s.io"
        kind  = "Gateway"
        name  = local.do-gateway.name
      }
      body = {
        maxSize = "256m"
      }
    }
  }

  depends_on = [kubernetes_manifest.do-gateway]
}

# The cache zone used by the "proxy-cache" SnippetsFilter.
# Same as ingress-nginx's "http-snippet" (do-k8s-ingress.tf), but in the writable emptyDir of the NGINX pods.
resource "kubernetes_manifest" "do-gateway-proxy-cache-path" {
  provider = kubernetes.do

  manifest = {
    apiVersion = "gateway.nginx.org/v1alpha1"
    kind       = "SnippetsPolicy"
    metadata = {
      name      = "proxy-cache-path"
      namespace = local.do-gateway.namespace
    }
    spec = {
      targetRefs = [{
        group = "gateway.networking.k8s.io"
        kind  = "Gateway"
        name  = local.do-gateway.name
      }]
      snippets = [{
        context = "http"
        value   = "proxy_cache_path /var/cache/nginx/mycache levels=1:2 keys_zone=mycache:2m use_temp_path=off max_size=2g inactive=48h;"
      }]
    }
  }

  depends_on = [kubernetes_manifest.do-gateway]
}

# Cache the responses of a route rule. Add it to a rule with:
#   filters = [{ type = "ExtensionRef", extensionRef = { group = "gateway.nginx.org", kind = "SnippetsFilter", name = "proxy-cache" } }]
# Used by build.haxe.org and by lib.haxe.org (haxelib repo), so it lives in their namespace ("default").
# Same as the "configuration-snippet" on their Ingresses.
resource "kubernetes_manifest" "do-gateway-proxy-cache" {
  provider = kubernetes.do

  manifest = {
    apiVersion = "gateway.nginx.org/v1alpha1"
    kind       = "SnippetsFilter"
    metadata = {
      name      = "proxy-cache"
      namespace = "default"
    }
    spec = {
      snippets = [{
        context = "http.server.location"
        value   = <<-EOT
          proxy_set_header Cookie "";
          proxy_cache mycache;
          proxy_cache_key "$scheme$request_method$host$request_uri";
          proxy_cache_use_stale error timeout updating http_500 http_502 http_503 http_504;
          proxy_cache_background_update on;
          proxy_cache_revalidate on;
          proxy_cache_lock on;
          add_header X-Cache-Status $upstream_cache_status;
        EOT
      }]
    }
  }

  depends_on = [helm_release.do-nginx-gateway-fabric]
}

# Redirect HTTP to HTTPS, except for haxelib, which serves plain HTTP for old haxelib clients.
# Same as ingress-nginx's default "ssl-redirect" behaviour.
resource "kubernetes_manifest" "do-gateway-https-redirect" {
  provider = kubernetes.do

  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "https-redirect"
      namespace = "default"
    }
    spec = {
      parentRefs = [merge(local.do-gateway.parent_ref, { sectionName = "http" })]
      hostnames = [
        for k, host in local.do-gateway.https_hosts : host
        if !startswith(k, "lib-")
      ]
      rules = [{
        filters = [{
          type = "RequestRedirect"
          requestRedirect = {
            scheme     = "https"
            statusCode = 308 # same as ingress-nginx
          }
        }]
      }]
    }
  }

  depends_on = [kubernetes_manifest.do-gateway]
}

# The Service and its DO load balancer are created by NGINX Gateway Fabric for the Gateway,
# named "<gateway>-<gatewayclass>".
data "kubernetes_service_v1" "do-gateway" {
  provider = kubernetes.do

  metadata {
    name      = "${local.do-gateway.name}-${local.do-gateway.class}"
    namespace = local.do-gateway.namespace
  }
}

data "digitalocean_loadbalancer" "do-gateway" {
  id = data.kubernetes_service_v1.do-gateway.metadata[0].annotations["kubernetes.digitalocean.com/load-balancer-id"]
}

# The "do-loadbalancer-hostname" of the Gateway.
resource "cloudflare_dns_record" "do-k8s-gw-haxe-org" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "do-k8s-gw"
  type    = "A"
  ttl     = 300
  content = data.digitalocean_loadbalancer.do-gateway.ip
}

resource "aws_route53_record" "do-k8s-gw-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "do-k8s-gw"
  type    = "A"
  ttl     = 300
  records = [data.digitalocean_loadbalancer.do-gateway.ip]
}
