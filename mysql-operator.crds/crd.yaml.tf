resource "kubernetes_manifest" "customresourcedefinition_innodbclusters_mysql_oracle_com" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "name" = "innodbclusters.mysql.oracle.com"
    }
    "spec" = {
      "group" = "mysql.oracle.com"
      "names" = {
        "kind" = "InnoDBCluster"
        "listKind" = "InnoDBClusterList"
        "plural" = "innodbclusters"
        "shortNames" = [
          "ic",
          "ics",
        ]
        "singular" = "innodbcluster"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "description" = "Status of the InnoDB Cluster"
              "jsonPath" = ".status.cluster.status"
              "name" = "Status"
              "type" = "string"
            },
            {
              "description" = "Number of ONLINE InnoDB Cluster instances"
              "jsonPath" = ".status.cluster.onlineInstances"
              "name" = "Online"
              "type" = "integer"
            },
            {
              "description" = "Number of InnoDB Cluster instances configured"
              "jsonPath" = ".spec.instances"
              "name" = "Instances"
              "type" = "integer"
            },
            {
              "description" = "Number of Router instances configured for the InnoDB Cluster"
              "jsonPath" = ".spec.router.instances"
              "name" = "Routers"
              "type" = "integer"
            },
            {
              "jsonPath" = ".metadata.creationTimestamp"
              "name" = "Age"
              "type" = "date"
            },
          ]
          "name" = "v2alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "properties" = {
                "metadata" = {
                  "properties" = {
                    "name" = {
                      "maxLength" = 40
                      "type" = "string"
                    }
                  }
                  "type" = "object"
                }
                "spec" = {
                  "properties" = {
                    "backupProfiles" = {
                      "description" = "Backup profile specifications for the cluster, which can be referenced from backup schedules and one-off backup jobs."
                      "items" = {
                        "properties" = {
                          "dumpInstance" = {
                            "type" = "object"
                            "x-kubernetes-preserve-unknown-fields" = true
                          }
                          "name" = {
                            "type" = "string"
                          }
                          "snapshot" = {
                            "type" = "object"
                            "x-kubernetes-preserve-unknown-fields" = true
                          }
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "backupSchedules" = {
                      "description" = "Schedules for periodically executed backups"
                      "items" = {
                        "properties" = {
                          "backupProfile" = {
                            "type" = "object"
                            "x-kubernetes-preserve-unknown-fields" = true
                          }
                          "backupProfileName" = {
                            "type" = "string"
                          }
                          "deleteBackupData" = {
                            "default" = false
                            "type" = "boolean"
                          }
                          "enabled" = {
                            "default" = true
                            "type" = "boolean"
                          }
                          "name" = {
                            "type" = "string"
                          }
                          "schedule" = {
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "name",
                          "schedule",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "baseServerId" = {
                      "default" = 1000
                      "description" = "Base value for MySQL server_id for instances in the cluster"
                      "maximum" = 4294967195
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "datadirVolumeClaimTemplate" = {
                      "description" = "Template for a PersistentVolumeClaim, to be used as datadir"
                      "type" = "object"
                      "x-kubernetes-preserve-unknown-fields" = true
                    }
                    "edition" = {
                      "description" = "MySQL Server Edition (commercial or enterprise)"
                      "pattern" = "^(commercial|enterprise)$"
                      "type" = "string"
                    }
                    "imagePullPolicy" = {
                      "type" = "string"
                    }
                    "imagePullSecrets" = {
                      "items" = {
                        "properties" = {
                          "name" = {
                            "type" = "string"
                          }
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "imageRepository" = {
                      "description" = "Repository from where images must be pulled from. Default mysql"
                      "type" = "string"
                    }
                    "initDB" = {
                      "type" = "object"
                      "x-kubernetes-preserve-unknown-fields" = true
                    }
                    "instances" = {
                      "default" = 1
                      "description" = "Number of MySQL replica instances for the cluster"
                      "maximum" = 9
                      "minimum" = 1
                      "type" = "integer"
                    }
                    "mycnf" = {
                      "description" = "Custom configuration additions for my.cnf"
                      "type" = "string"
                    }
                    "podSpec" = {
                      "type" = "object"
                      "x-kubernetes-preserve-unknown-fields" = true
                    }
                    "router" = {
                      "properties" = {
                        "instances" = {
                          "default" = 0
                          "description" = "Number of MySQL Router instances to deploy"
                          "minimum" = 0
                          "type" = "integer"
                        }
                        "podSpec" = {
                          "type" = "object"
                          "x-kubernetes-preserve-unknown-fields" = true
                        }
                        "version" = {
                          "description" = "Override MySQL Router version"
                          "pattern" = "^\\d+\\.\\d+\\.\\d+(-.+)?"
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "secretName" = {
                      "description" = "Name of a Secret containing root/default account password"
                      "type" = "string"
                    }
                    "serviceAccountName" = {
                      "type" = "string"
                    }
                    "sslSecretName" = {
                      "type" = "string"
                    }
                    "version" = {
                      "description" = "MySQL Server version"
                      "pattern" = "^\\d+\\.\\d+\\.\\d+(-.+)?"
                      "type" = "string"
                    }
                  }
                  "required" = [
                    "secretName",
                  ]
                  "type" = "object"
                }
                "status" = {
                  "type" = "object"
                  "x-kubernetes-preserve-unknown-fields" = true
                }
              }
              "required" = [
                "spec",
              ]
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "customresourcedefinition_mysqlbackups_mysql_oracle_com" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "name" = "mysqlbackups.mysql.oracle.com"
    }
    "spec" = {
      "group" = "mysql.oracle.com"
      "names" = {
        "kind" = "MySQLBackup"
        "listKind" = "MySQLBackupList"
        "plural" = "mysqlbackups"
        "shortNames" = [
          "mbk",
        ]
        "singular" = "mysqlbackup"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "description" = "Name of the target cluster"
              "jsonPath" = ".spec.clusterName"
              "name" = "Cluster"
              "type" = "string"
            },
            {
              "description" = "Status of the Backup"
              "jsonPath" = ".status.status"
              "name" = "Status"
              "type" = "string"
            },
            {
              "description" = "Name of the produced file/directory"
              "jsonPath" = ".status.output"
              "name" = "Output"
              "type" = "string"
            },
            {
              "jsonPath" = ".metadata.creationTimestamp"
              "name" = "Age"
              "type" = "date"
            },
          ]
          "name" = "v2alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "properties" = {
                "spec" = {
                  "properties" = {
                    "addTimestampToBackupDirectory" = {
                      "default" = true
                      "type" = "boolean"
                    }
                    "backupProfile" = {
                      "type" = "object"
                      "x-kubernetes-preserve-unknown-fields" = true
                    }
                    "backupProfileName" = {
                      "type" = "string"
                    }
                    "clusterName" = {
                      "type" = "string"
                    }
                    "deleteBackupData" = {
                      "default" = false
                      "type" = "boolean"
                    }
                  }
                  "required" = [
                    "clusterName",
                  ]
                  "type" = "object"
                }
                "status" = {
                  "properties" = {
                    "bucket" = {
                      "type" = "string"
                    }
                    "completionTime" = {
                      "type" = "string"
                    }
                    "elapsedTime" = {
                      "type" = "string"
                    }
                    "method" = {
                      "type" = "string"
                    }
                    "ociTenancy" = {
                      "type" = "string"
                    }
                    "output" = {
                      "type" = "string"
                    }
                    "size" = {
                      "type" = "string"
                    }
                    "source" = {
                      "type" = "string"
                    }
                    "spaceAvailable" = {
                      "type" = "string"
                    }
                    "startTime" = {
                      "type" = "string"
                    }
                    "status" = {
                      "type" = "string"
                    }
                  }
                  "type" = "object"
                }
              }
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "customresourcedefinition_clusterkopfpeerings_zalando_org" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "name" = "clusterkopfpeerings.zalando.org"
    }
    "spec" = {
      "group" = "zalando.org"
      "names" = {
        "kind" = "ClusterKopfPeering"
        "plural" = "clusterkopfpeerings"
        "singular" = "clusterkopfpeering"
      }
      "scope" = "Cluster"
      "versions" = [
        {
          "name" = "v1"
          "schema" = {
            "openAPIV3Schema" = {
              "properties" = {
                "status" = {
                  "type" = "object"
                  "x-kubernetes-preserve-unknown-fields" = true
                }
              }
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "customresourcedefinition_kopfpeerings_zalando_org" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "name" = "kopfpeerings.zalando.org"
    }
    "spec" = {
      "group" = "zalando.org"
      "names" = {
        "kind" = "KopfPeering"
        "plural" = "kopfpeerings"
        "singular" = "kopfpeering"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1"
          "schema" = {
            "openAPIV3Schema" = {
              "properties" = {
                "status" = {
                  "type" = "object"
                  "x-kubernetes-preserve-unknown-fields" = true
                }
              }
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
        },
      ]
    }
  }
}
