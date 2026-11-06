resource "kubernetes_manifest" "customresourcedefinition_probes_monitoring_coreos_com" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.22.0"
        "operator.prometheus.io/version" = "0.94.2"
      }
      "name" = "probes.monitoring.coreos.com"
    }
    "spec" = {
      "group" = "monitoring.coreos.com"
      "names" = {
        "categories" = [
          "prometheus-operator",
        ]
        "kind" = "Probe"
        "listKind" = "ProbeList"
        "plural" = "probes"
        "shortNames" = [
          "prb",
        ]
        "singular" = "probe"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = <<-EOT
              The `Probe` custom resource definition (CRD) defines how to scrape metrics from prober exporters such as the [blackbox exporter](https://github.com/prometheus/blackbox_exporter).
              
              The `Probe` resource needs 2 pieces of information:
              * The list of probed addresses which can be defined statically or by discovering Kubernetes Ingress objects.
              * The prober which exposes the availability of probed endpoints (over various protocols such HTTP, TCP, ICMP, ...) as Prometheus metrics.
              
              `Prometheus` and `PrometheusAgent` objects select `Probe` objects using label and namespace selectors.
              EOT
              "properties" = {
                "apiVersion" = {
                  "description" = <<-EOT
                  APIVersion defines the versioned schema of this representation of an object.
                  Servers should convert recognized schemas to the latest internal value, and
                  may reject unrecognized values.
                  More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
                  EOT
                  "type" = "string"
                }
                "kind" = {
                  "description" = <<-EOT
                  Kind is a string value representing the REST resource this object represents.
                  Servers may infer this from the endpoint the client submits requests to.
                  Cannot be updated.
                  In CamelCase.
                  More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
                  EOT
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "description" = "spec defines the specification of desired Ingress selection for target discovery by Prometheus."
                  "properties" = {
                    "authorization" = {
                      "description" = <<-EOT
                      authorization configures the Authorization header credentials used by
                      the client.
                      
                      Cannot be set at the same time as `basicAuth`, `bearerTokenSecret` or `oauth2`.
                      EOT
                      "properties" = {
                        "credentials" = {
                          "description" = "credentials defines a key of a Secret in the namespace that contains the credentials for authentication."
                          "properties" = {
                            "key" = {
                              "description" = "The key of the secret to select from.  Must be a valid secret key."
                              "type" = "string"
                            }
                            "name" = {
                              "default" = ""
                              "description" = <<-EOT
                              Name of the referent.
                              This field is effectively required, but due to backwards compatibility is
                              allowed to be empty. Instances of this type with an empty value here are
                              almost certainly wrong.
                              More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                              EOT
                              "type" = "string"
                            }
                            "optional" = {
                              "description" = "Specify whether the Secret or its key must be defined"
                              "type" = "boolean"
                            }
                          }
                          "required" = [
                            "key",
                          ]
                          "type" = "object"
                          "x-kubernetes-map-type" = "atomic"
                        }
                        "type" = {
                          "description" = <<-EOT
                          type defines the authentication type. The value is case-insensitive.
                          
                          "Basic" is not a supported value.
                          
                          Default: "Bearer"
                          EOT
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "basicAuth" = {
                      "description" = <<-EOT
                      basicAuth defines the Basic Authentication credentials used by the
                      client.
                      
                      Cannot be set at the same time as `authorization`, `bearerTokenSecret` or `oauth2`.
                      EOT
                      "properties" = {
                        "password" = {
                          "description" = <<-EOT
                          password defines a key of a Secret containing the password for
                          authentication.
                          EOT
                          "properties" = {
                            "key" = {
                              "description" = "The key of the secret to select from.  Must be a valid secret key."
                              "type" = "string"
                            }
                            "name" = {
                              "default" = ""
                              "description" = <<-EOT
                              Name of the referent.
                              This field is effectively required, but due to backwards compatibility is
                              allowed to be empty. Instances of this type with an empty value here are
                              almost certainly wrong.
                              More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                              EOT
                              "type" = "string"
                            }
                            "optional" = {
                              "description" = "Specify whether the Secret or its key must be defined"
                              "type" = "boolean"
                            }
                          }
                          "required" = [
                            "key",
                          ]
                          "type" = "object"
                          "x-kubernetes-map-type" = "atomic"
                        }
                        "username" = {
                          "description" = <<-EOT
                          username defines a key of a Secret containing the username for
                          authentication.
                          EOT
                          "properties" = {
                            "key" = {
                              "description" = "The key of the secret to select from.  Must be a valid secret key."
                              "type" = "string"
                            }
                            "name" = {
                              "default" = ""
                              "description" = <<-EOT
                              Name of the referent.
                              This field is effectively required, but due to backwards compatibility is
                              allowed to be empty. Instances of this type with an empty value here are
                              almost certainly wrong.
                              More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                              EOT
                              "type" = "string"
                            }
                            "optional" = {
                              "description" = "Specify whether the Secret or its key must be defined"
                              "type" = "boolean"
                            }
                          }
                          "required" = [
                            "key",
                          ]
                          "type" = "object"
                          "x-kubernetes-map-type" = "atomic"
                        }
                      }
                      "type" = "object"
                    }
                    "bearerTokenSecret" = {
                      "description" = <<-EOT
                      bearerTokenSecret defines a key of a Secret containing the bearer token
                      used by the client for authentication. The secret needs to be in the
                      same namespace as the custom resource and readable by the Prometheus
                      Operator.
                      
                      Cannot be set at the same time as `authorization`, `basicAuth` or `oauth2`.
                      
                      Deprecated: use `authorization` instead.
                      EOT
                      "properties" = {
                        "key" = {
                          "description" = "The key of the secret to select from.  Must be a valid secret key."
                          "type" = "string"
                        }
                        "name" = {
                          "default" = ""
                          "description" = <<-EOT
                          Name of the referent.
                          This field is effectively required, but due to backwards compatibility is
                          allowed to be empty. Instances of this type with an empty value here are
                          almost certainly wrong.
                          More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                          EOT
                          "type" = "string"
                        }
                        "optional" = {
                          "description" = "Specify whether the Secret or its key must be defined"
                          "type" = "boolean"
                        }
                      }
                      "required" = [
                        "key",
                      ]
                      "type" = "object"
                      "x-kubernetes-map-type" = "atomic"
                    }
                    "convertClassicHistogramsToNHCB" = {
                      "description" = <<-EOT
                      convertClassicHistogramsToNHCB defines whether to convert all scraped classic histograms into a native histogram with custom buckets.
                      It requires Prometheus >= v3.0.0.
                      EOT
                      "type" = "boolean"
                    }
                    "enableHttp2" = {
                      "description" = "enableHttp2 can be used to disable HTTP2."
                      "type" = "boolean"
                    }
                    "fallbackScrapeProtocol" = {
                      "description" = <<-EOT
                      fallbackScrapeProtocol defines the protocol to use if a scrape returns blank, unparseable, or otherwise invalid Content-Type.
                      
                      It requires Prometheus >= v3.0.0.
                      EOT
                      "enum" = [
                        "PrometheusProto",
                        "OpenMetricsText0.0.1",
                        "OpenMetricsText1.0.0",
                        "PrometheusText0.0.4",
                        "PrometheusText1.0.0",
                      ]
                      "type" = "string"
                    }
                    "followRedirects" = {
                      "description" = <<-EOT
                      followRedirects defines whether the client should follow HTTP 3xx
                      redirects.
                      EOT
                      "type" = "boolean"
                    }
                    "interval" = {
                      "description" = <<-EOT
                      interval at which targets are probed using the configured prober.
                      If not specified Prometheus' global scrape interval is used.
                      EOT
                      "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                      "type" = "string"
                    }
                    "jobName" = {
                      "description" = "jobName assigned to scraped metrics by default."
                      "type" = "string"
                    }
                    "keepDroppedTargets" = {
                      "description" = <<-EOT
                      keepDroppedTargets defines the per-scrape limit on the number of targets dropped by relabeling
                      that will be kept in memory. 0 means no limit.
                      
                      It requires Prometheus >= v2.47.0.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "labelLimit" = {
                      "description" = <<-EOT
                      labelLimit defines the per-scrape limit on number of labels that will be accepted for a sample.
                      Only valid in Prometheus versions 2.27.0 and newer.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "labelNameLengthLimit" = {
                      "description" = <<-EOT
                      labelNameLengthLimit defines the per-scrape limit on length of labels name that will be accepted for a sample.
                      Only valid in Prometheus versions 2.27.0 and newer.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "labelValueLengthLimit" = {
                      "description" = <<-EOT
                      labelValueLengthLimit defines the per-scrape limit on length of labels value that will be accepted for a sample.
                      Only valid in Prometheus versions 2.27.0 and newer.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "metricRelabelings" = {
                      "description" = "metricRelabelings defines the RelabelConfig to apply to samples before ingestion."
                      "items" = {
                        "description" = <<-EOT
                        RelabelConfig allows dynamic rewriting of the label set for targets, alerts,
                        scraped samples and remote write samples.
                        
                        More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
                        EOT
                        "properties" = {
                          "action" = {
                            "default" = "replace"
                            "description" = <<-EOT
                            action to perform based on the regex matching.
                            
                            `Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.
                            `DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.
                            
                            Default: "Replace"
                            EOT
                            "enum" = [
                              "replace",
                              "Replace",
                              "keep",
                              "Keep",
                              "drop",
                              "Drop",
                              "hashmod",
                              "HashMod",
                              "labelmap",
                              "LabelMap",
                              "labeldrop",
                              "LabelDrop",
                              "labelkeep",
                              "LabelKeep",
                              "lowercase",
                              "Lowercase",
                              "uppercase",
                              "Uppercase",
                              "keepequal",
                              "KeepEqual",
                              "dropequal",
                              "DropEqual",
                            ]
                            "type" = "string"
                          }
                          "modulus" = {
                            "description" = <<-EOT
                            modulus to take of the hash of the source label values.
                            
                            Only applicable when the action is `HashMod`.
                            EOT
                            "format" = "int64"
                            "minimum" = 0
                            "type" = "integer"
                          }
                          "regex" = {
                            "description" = "regex defines the regular expression against which the extracted value is matched."
                            "type" = "string"
                          }
                          "replacement" = {
                            "description" = <<-EOT
                            replacement value against which a Replace action is performed if the
                            regular expression matches.
                            
                            Regex capture groups are available.
                            EOT
                            "type" = "string"
                          }
                          "separator" = {
                            "description" = "separator defines the string between concatenated SourceLabels."
                            "type" = "string"
                          }
                          "sourceLabels" = {
                            "description" = <<-EOT
                            sourceLabels defines the source labels select values from existing labels. Their content is
                            concatenated using the configured Separator and matched against the
                            configured regular expression.
                            EOT
                            "items" = {
                              "description" = <<-EOT
                              LabelName is a valid Prometheus label name.
                              For Prometheus 3.x, a label name is valid if it contains UTF-8 characters.
                              For Prometheus 2.x, a label name is only valid if it contains ASCII characters, letters, numbers, as well as underscores.
                              EOT
                              "type" = "string"
                            }
                            "type" = "array"
                          }
                          "targetLabel" = {
                            "description" = <<-EOT
                            targetLabel defines the label to which the resulting string is written in a replacement.
                            
                            It is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,
                            `KeepEqual` and `DropEqual` actions.
                            
                            Regex capture groups are available.
                            EOT
                            "type" = "string"
                          }
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "module" = {
                      "description" = <<-EOT
                      module to use for probing specifying how to probe the target.
                      Example module configuring in the blackbox exporter:
                      https://github.com/prometheus/blackbox_exporter/blob/master/example.yml
                      EOT
                      "type" = "string"
                    }
                    "nativeHistogramBucketLimit" = {
                      "description" = <<-EOT
                      nativeHistogramBucketLimit defines ff there are more than this many buckets in a native histogram,
                      buckets will be merged to stay within the limit.
                      It requires Prometheus >= v2.45.0.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "nativeHistogramMinBucketFactor" = {
                      "anyOf" = [
                        {
                          "type" = "integer"
                        },
                        {
                          "type" = "string"
                        },
                      ]
                      "description" = <<-EOT
                      nativeHistogramMinBucketFactor defines if the growth factor of one bucket to the next is smaller than this,
                      buckets will be merged to increase the factor sufficiently.
                      It requires Prometheus >= v2.50.0.
                      EOT
                      "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                      "x-kubernetes-int-or-string" = true
                    }
                    "oauth2" = {
                      "description" = <<-EOT
                      oauth2 defines the OAuth2 settings used by the client.
                      
                      It requires Prometheus >= 2.27.0.
                      
                      Cannot be set at the same time as `authorization`, `basicAuth` or `bearerTokenSecret`.
                      EOT
                      "properties" = {
                        "clientId" = {
                          "description" = <<-EOT
                          clientId defines a key of a Secret or ConfigMap containing the
                          OAuth2 client's ID.
                          EOT
                          "properties" = {
                            "configMap" = {
                              "description" = "configMap defines the ConfigMap containing data to use for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = <<-EOT
                                  The key to select from the ConfigMap's Data field.
                                  Keys in the BinaryData field are not currently propagated to container env vars.
                                  EOT
                                  "type" = "string"
                                }
                                "name" = {
                                  "default" = ""
                                  "description" = <<-EOT
                                  Name of the referent.
                                  This field is effectively required, but due to backwards compatibility is
                                  allowed to be empty. Instances of this type with an empty value here are
                                  almost certainly wrong.
                                  More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                  EOT
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the ConfigMap or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                            "secret" = {
                              "description" = "secret defines the Secret containing data to use for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the secret to select from.  Must be a valid secret key."
                                  "type" = "string"
                                }
                                "name" = {
                                  "default" = ""
                                  "description" = <<-EOT
                                  Name of the referent.
                                  This field is effectively required, but due to backwards compatibility is
                                  allowed to be empty. Instances of this type with an empty value here are
                                  almost certainly wrong.
                                  More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                  EOT
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the Secret or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                          }
                          "type" = "object"
                        }
                        "clientSecret" = {
                          "description" = <<-EOT
                          clientSecret defines a key of a Secret containing the OAuth2
                          client's secret.
                          EOT
                          "properties" = {
                            "key" = {
                              "description" = "The key of the secret to select from.  Must be a valid secret key."
                              "type" = "string"
                            }
                            "name" = {
                              "default" = ""
                              "description" = <<-EOT
                              Name of the referent.
                              This field is effectively required, but due to backwards compatibility is
                              allowed to be empty. Instances of this type with an empty value here are
                              almost certainly wrong.
                              More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                              EOT
                              "type" = "string"
                            }
                            "optional" = {
                              "description" = "Specify whether the Secret or its key must be defined"
                              "type" = "boolean"
                            }
                          }
                          "required" = [
                            "key",
                          ]
                          "type" = "object"
                          "x-kubernetes-map-type" = "atomic"
                        }
                        "endpointParams" = {
                          "additionalProperties" = {
                            "type" = "string"
                          }
                          "description" = <<-EOT
                          endpointParams configures the HTTP parameters to append to the token
                          URL.
                          EOT
                          "type" = "object"
                        }
                        "noProxy" = {
                          "description" = <<-EOT
                          noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
                          that should be excluded from proxying. IP and domain names can
                          contain port numbers.
                          
                          It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
                          EOT
                          "type" = "string"
                        }
                        "proxyConnectHeader" = {
                          "additionalProperties" = {
                            "items" = {
                              "description" = "SecretKeySelector selects a key of a Secret."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the secret to select from.  Must be a valid secret key."
                                  "type" = "string"
                                }
                                "name" = {
                                  "default" = ""
                                  "description" = <<-EOT
                                  Name of the referent.
                                  This field is effectively required, but due to backwards compatibility is
                                  allowed to be empty. Instances of this type with an empty value here are
                                  almost certainly wrong.
                                  More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                  EOT
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the Secret or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                            "type" = "array"
                          }
                          "description" = <<-EOT
                          proxyConnectHeader optionally specifies headers to send to
                          proxies during CONNECT requests.
                          
                          It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
                          EOT
                          "type" = "object"
                          "x-kubernetes-map-type" = "atomic"
                        }
                        "proxyFromEnvironment" = {
                          "description" = <<-EOT
                          proxyFromEnvironment defines whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).
                          
                          It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
                          EOT
                          "type" = "boolean"
                        }
                        "proxyUrl" = {
                          "description" = "proxyUrl defines the HTTP proxy server to use."
                          "pattern" = "^(http|https|socks5)://.+$"
                          "type" = "string"
                        }
                        "scopes" = {
                          "description" = "scopes defines the OAuth2 scopes used for the token request."
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "tlsConfig" = {
                          "description" = <<-EOT
                          tlsConfig defines the TLS configuration to use when connecting to the OAuth2 server.
                          It requires Prometheus >= v2.43.0.
                          EOT
                          "properties" = {
                            "ca" = {
                              "description" = "ca defines the Certificate authority used when verifying server certificates."
                              "properties" = {
                                "configMap" = {
                                  "description" = "configMap defines the ConfigMap containing data to use for the targets."
                                  "properties" = {
                                    "key" = {
                                      "description" = <<-EOT
                                      The key to select from the ConfigMap's Data field.
                                      Keys in the BinaryData field are not currently propagated to container env vars.
                                      EOT
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "default" = ""
                                      "description" = <<-EOT
                                      Name of the referent.
                                      This field is effectively required, but due to backwards compatibility is
                                      allowed to be empty. Instances of this type with an empty value here are
                                      almost certainly wrong.
                                      More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                      EOT
                                      "type" = "string"
                                    }
                                    "optional" = {
                                      "description" = "Specify whether the ConfigMap or its key must be defined"
                                      "type" = "boolean"
                                    }
                                  }
                                  "required" = [
                                    "key",
                                  ]
                                  "type" = "object"
                                  "x-kubernetes-map-type" = "atomic"
                                }
                                "secret" = {
                                  "description" = "secret defines the Secret containing data to use for the targets."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the secret to select from.  Must be a valid secret key."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "default" = ""
                                      "description" = <<-EOT
                                      Name of the referent.
                                      This field is effectively required, but due to backwards compatibility is
                                      allowed to be empty. Instances of this type with an empty value here are
                                      almost certainly wrong.
                                      More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                      EOT
                                      "type" = "string"
                                    }
                                    "optional" = {
                                      "description" = "Specify whether the Secret or its key must be defined"
                                      "type" = "boolean"
                                    }
                                  }
                                  "required" = [
                                    "key",
                                  ]
                                  "type" = "object"
                                  "x-kubernetes-map-type" = "atomic"
                                }
                              }
                              "type" = "object"
                            }
                            "cert" = {
                              "description" = "cert defines the Client certificate to present when doing client-authentication."
                              "properties" = {
                                "configMap" = {
                                  "description" = "configMap defines the ConfigMap containing data to use for the targets."
                                  "properties" = {
                                    "key" = {
                                      "description" = <<-EOT
                                      The key to select from the ConfigMap's Data field.
                                      Keys in the BinaryData field are not currently propagated to container env vars.
                                      EOT
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "default" = ""
                                      "description" = <<-EOT
                                      Name of the referent.
                                      This field is effectively required, but due to backwards compatibility is
                                      allowed to be empty. Instances of this type with an empty value here are
                                      almost certainly wrong.
                                      More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                      EOT
                                      "type" = "string"
                                    }
                                    "optional" = {
                                      "description" = "Specify whether the ConfigMap or its key must be defined"
                                      "type" = "boolean"
                                    }
                                  }
                                  "required" = [
                                    "key",
                                  ]
                                  "type" = "object"
                                  "x-kubernetes-map-type" = "atomic"
                                }
                                "secret" = {
                                  "description" = "secret defines the Secret containing data to use for the targets."
                                  "properties" = {
                                    "key" = {
                                      "description" = "The key of the secret to select from.  Must be a valid secret key."
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "default" = ""
                                      "description" = <<-EOT
                                      Name of the referent.
                                      This field is effectively required, but due to backwards compatibility is
                                      allowed to be empty. Instances of this type with an empty value here are
                                      almost certainly wrong.
                                      More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                      EOT
                                      "type" = "string"
                                    }
                                    "optional" = {
                                      "description" = "Specify whether the Secret or its key must be defined"
                                      "type" = "boolean"
                                    }
                                  }
                                  "required" = [
                                    "key",
                                  ]
                                  "type" = "object"
                                  "x-kubernetes-map-type" = "atomic"
                                }
                              }
                              "type" = "object"
                            }
                            "insecureSkipVerify" = {
                              "description" = "insecureSkipVerify defines how to disable target certificate validation."
                              "type" = "boolean"
                            }
                            "keySecret" = {
                              "description" = "keySecret defines the Secret containing the client key file for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the secret to select from.  Must be a valid secret key."
                                  "type" = "string"
                                }
                                "name" = {
                                  "default" = ""
                                  "description" = <<-EOT
                                  Name of the referent.
                                  This field is effectively required, but due to backwards compatibility is
                                  allowed to be empty. Instances of this type with an empty value here are
                                  almost certainly wrong.
                                  More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                  EOT
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the Secret or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                            "maxVersion" = {
                              "description" = <<-EOT
                              maxVersion defines the maximum acceptable TLS version.
                              
                              It requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.
                              EOT
                              "enum" = [
                                "TLS10",
                                "TLS11",
                                "TLS12",
                                "TLS13",
                              ]
                              "type" = "string"
                            }
                            "minVersion" = {
                              "description" = <<-EOT
                              minVersion defines the minimum acceptable TLS version.
                              
                              It requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.
                              EOT
                              "enum" = [
                                "TLS10",
                                "TLS11",
                                "TLS12",
                                "TLS13",
                              ]
                              "type" = "string"
                            }
                            "serverName" = {
                              "description" = "serverName is used to verify the hostname for the targets."
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                        "tokenUrl" = {
                          "description" = "tokenUrl defines the URL to fetch the token from."
                          "pattern" = "^(http|https)://.+$"
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "clientId",
                        "clientSecret",
                        "tokenUrl",
                      ]
                      "type" = "object"
                    }
                    "params" = {
                      "description" = <<-EOT
                      params defines the list of HTTP query parameters for the scrape.
                      Please note that the `.spec.module` field takes precedence over the `module` parameter from this list when both are defined.
                      The module name must be added using Module under ProbeSpec.
                      EOT
                      "items" = {
                        "description" = "ProbeParam defines specification of extra parameters for a Probe."
                        "properties" = {
                          "name" = {
                            "description" = "name defines the parameter name"
                            "minLength" = 1
                            "type" = "string"
                          }
                          "values" = {
                            "description" = "values defines the parameter values"
                            "items" = {
                              "minLength" = 1
                              "type" = "string"
                            }
                            "minItems" = 1
                            "type" = "array"
                          }
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "minItems" = 1
                      "type" = "array"
                      "x-kubernetes-list-map-keys" = [
                        "name",
                      ]
                      "x-kubernetes-list-type" = "map"
                    }
                    "prober" = {
                      "description" = <<-EOT
                      prober defines the specification for the prober to use for probing targets.
                      The prober.URL parameter is required. Targets cannot be probed if left empty.
                      EOT
                      "properties" = {
                        "noProxy" = {
                          "description" = <<-EOT
                          noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
                          that should be excluded from proxying. IP and domain names can
                          contain port numbers.
                          
                          It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
                          EOT
                          "type" = "string"
                        }
                        "path" = {
                          "default" = "/probe"
                          "description" = <<-EOT
                          path to collect metrics from.
                          Defaults to `/probe`.
                          EOT
                          "type" = "string"
                        }
                        "proxyConnectHeader" = {
                          "additionalProperties" = {
                            "items" = {
                              "description" = "SecretKeySelector selects a key of a Secret."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the secret to select from.  Must be a valid secret key."
                                  "type" = "string"
                                }
                                "name" = {
                                  "default" = ""
                                  "description" = <<-EOT
                                  Name of the referent.
                                  This field is effectively required, but due to backwards compatibility is
                                  allowed to be empty. Instances of this type with an empty value here are
                                  almost certainly wrong.
                                  More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                  EOT
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the Secret or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                            "type" = "array"
                          }
                          "description" = <<-EOT
                          proxyConnectHeader optionally specifies headers to send to
                          proxies during CONNECT requests.
                          
                          It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
                          EOT
                          "type" = "object"
                          "x-kubernetes-map-type" = "atomic"
                        }
                        "proxyFromEnvironment" = {
                          "description" = <<-EOT
                          proxyFromEnvironment defines whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).
                          
                          It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
                          EOT
                          "type" = "boolean"
                        }
                        "proxyUrl" = {
                          "description" = "proxyUrl defines the HTTP proxy server to use."
                          "pattern" = "^(http|https|socks5)://.+$"
                          "type" = "string"
                        }
                        "scheme" = {
                          "description" = "scheme defines the HTTP scheme to use when scraping the prober."
                          "enum" = [
                            "http",
                            "https",
                            "HTTP",
                            "HTTPS",
                          ]
                          "type" = "string"
                        }
                        "url" = {
                          "description" = <<-EOT
                          url defines the address of the prober.
                          
                          Unlike what the name indicates, the value should be in the form of
                          `address:port` without any scheme which should be specified in the
                          `scheme` field.
                          EOT
                          "minLength" = 1
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "url",
                      ]
                      "type" = "object"
                    }
                    "sampleLimit" = {
                      "description" = "sampleLimit defines per-scrape limit on number of scraped samples that will be accepted."
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "scrapeClass" = {
                      "description" = "scrapeClass defines the scrape class to apply."
                      "minLength" = 1
                      "type" = "string"
                    }
                    "scrapeClassicHistograms" = {
                      "description" = <<-EOT
                      scrapeClassicHistograms defines whether to scrape a classic histogram that is also exposed as a native histogram.
                      It requires Prometheus >= v2.45.0.
                      
                      Notice: `scrapeClassicHistograms` corresponds to the `always_scrape_classic_histograms` field in the Prometheus configuration.
                      EOT
                      "type" = "boolean"
                    }
                    "scrapeNativeHistograms" = {
                      "description" = <<-EOT
                      scrapeNativeHistograms defines whether to enable scraping of native histograms.
                      It requires Prometheus >= v3.8.0.
                      EOT
                      "type" = "boolean"
                    }
                    "scrapeProtocols" = {
                      "description" = <<-EOT
                      scrapeProtocols defines the protocols to negotiate during a scrape. It tells clients the
                      protocols supported by Prometheus in order of preference (from most to least preferred).
                      
                      If unset, Prometheus uses its default value.
                      
                      It requires Prometheus >= v2.49.0.
                      EOT
                      "items" = {
                        "description" = <<-EOT
                        ScrapeProtocol represents a protocol used by Prometheus for scraping metrics.
                        Supported values are:
                        * `OpenMetricsText0.0.1`
                        * `OpenMetricsText1.0.0`
                        * `PrometheusProto`
                        * `PrometheusText0.0.4`
                        * `PrometheusText1.0.0`
                        EOT
                        "enum" = [
                          "PrometheusProto",
                          "OpenMetricsText0.0.1",
                          "OpenMetricsText1.0.0",
                          "PrometheusText0.0.4",
                          "PrometheusText1.0.0",
                        ]
                        "type" = "string"
                      }
                      "type" = "array"
                      "x-kubernetes-list-type" = "set"
                    }
                    "scrapeTimeout" = {
                      "description" = <<-EOT
                      scrapeTimeout defines the timeout for scraping metrics from the Prometheus exporter.
                      If not specified, the Prometheus global scrape timeout is used.
                      The value cannot be greater than the scrape interval otherwise the operator will reject the resource.
                      EOT
                      "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                      "type" = "string"
                    }
                    "targetLimit" = {
                      "description" = "targetLimit defines a limit on the number of scraped targets that will be accepted."
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "targets" = {
                      "description" = "targets defines a set of static or dynamically discovered targets to probe."
                      "properties" = {
                        "ingress" = {
                          "description" = <<-EOT
                          ingress defines the Ingress objects to probe and the relabeling
                          configuration.
                          If `staticConfig` is also defined, `staticConfig` takes precedence.
                          EOT
                          "properties" = {
                            "namespaceSelector" = {
                              "description" = "namespaceSelector defines from which namespaces to select Ingress objects."
                              "properties" = {
                                "any" = {
                                  "description" = <<-EOT
                                  any defines the boolean describing whether all namespaces are selected in contrast to a
                                  list restricting them.
                                  EOT
                                  "type" = "boolean"
                                }
                                "matchNames" = {
                                  "description" = "matchNames defines the list of namespace names to select from."
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                              }
                              "type" = "object"
                            }
                            "relabelingConfigs" = {
                              "description" = <<-EOT
                              relabelingConfigs to apply to the label set of the target before it gets
                              scraped.
                              The original ingress address is available via the
                              `__tmp_prometheus_ingress_address` label. It can be used to customize the
                              probed URL.
                              The original scrape job's name is available via the `__tmp_prometheus_job_name` label.
                              More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
                              EOT
                              "items" = {
                                "description" = <<-EOT
                                RelabelConfig allows dynamic rewriting of the label set for targets, alerts,
                                scraped samples and remote write samples.
                                
                                More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
                                EOT
                                "properties" = {
                                  "action" = {
                                    "default" = "replace"
                                    "description" = <<-EOT
                                    action to perform based on the regex matching.
                                    
                                    `Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.
                                    `DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.
                                    
                                    Default: "Replace"
                                    EOT
                                    "enum" = [
                                      "replace",
                                      "Replace",
                                      "keep",
                                      "Keep",
                                      "drop",
                                      "Drop",
                                      "hashmod",
                                      "HashMod",
                                      "labelmap",
                                      "LabelMap",
                                      "labeldrop",
                                      "LabelDrop",
                                      "labelkeep",
                                      "LabelKeep",
                                      "lowercase",
                                      "Lowercase",
                                      "uppercase",
                                      "Uppercase",
                                      "keepequal",
                                      "KeepEqual",
                                      "dropequal",
                                      "DropEqual",
                                    ]
                                    "type" = "string"
                                  }
                                  "modulus" = {
                                    "description" = <<-EOT
                                    modulus to take of the hash of the source label values.
                                    
                                    Only applicable when the action is `HashMod`.
                                    EOT
                                    "format" = "int64"
                                    "minimum" = 0
                                    "type" = "integer"
                                  }
                                  "regex" = {
                                    "description" = "regex defines the regular expression against which the extracted value is matched."
                                    "type" = "string"
                                  }
                                  "replacement" = {
                                    "description" = <<-EOT
                                    replacement value against which a Replace action is performed if the
                                    regular expression matches.
                                    
                                    Regex capture groups are available.
                                    EOT
                                    "type" = "string"
                                  }
                                  "separator" = {
                                    "description" = "separator defines the string between concatenated SourceLabels."
                                    "type" = "string"
                                  }
                                  "sourceLabels" = {
                                    "description" = <<-EOT
                                    sourceLabels defines the source labels select values from existing labels. Their content is
                                    concatenated using the configured Separator and matched against the
                                    configured regular expression.
                                    EOT
                                    "items" = {
                                      "description" = <<-EOT
                                      LabelName is a valid Prometheus label name.
                                      For Prometheus 3.x, a label name is valid if it contains UTF-8 characters.
                                      For Prometheus 2.x, a label name is only valid if it contains ASCII characters, letters, numbers, as well as underscores.
                                      EOT
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                  }
                                  "targetLabel" = {
                                    "description" = <<-EOT
                                    targetLabel defines the label to which the resulting string is written in a replacement.
                                    
                                    It is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,
                                    `KeepEqual` and `DropEqual` actions.
                                    
                                    Regex capture groups are available.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "type" = "array"
                            }
                            "selector" = {
                              "description" = "selector to select the Ingress objects."
                              "properties" = {
                                "matchExpressions" = {
                                  "description" = "matchExpressions is a list of label selector requirements. The requirements are ANDed."
                                  "items" = {
                                    "description" = <<-EOT
                                    A label selector requirement is a selector that contains values, a key, and an operator that
                                    relates the key and values.
                                    EOT
                                    "properties" = {
                                      "key" = {
                                        "description" = "key is the label key that the selector applies to."
                                        "type" = "string"
                                      }
                                      "operator" = {
                                        "description" = <<-EOT
                                        operator represents a key's relationship to a set of values.
                                        Valid operators are In, NotIn, Exists and DoesNotExist.
                                        EOT
                                        "type" = "string"
                                      }
                                      "values" = {
                                        "description" = <<-EOT
                                        values is an array of string values. If the operator is In or NotIn,
                                        the values array must be non-empty. If the operator is Exists or DoesNotExist,
                                        the values array must be empty. This array is replaced during a strategic
                                        merge patch.
                                        EOT
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                    }
                                    "required" = [
                                      "key",
                                      "operator",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                  "x-kubernetes-list-type" = "atomic"
                                }
                                "matchLabels" = {
                                  "additionalProperties" = {
                                    "type" = "string"
                                  }
                                  "description" = <<-EOT
                                  matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
                                  map is equivalent to an element of matchExpressions, whose key field is "key", the
                                  operator is "In", and the values array contains only "value". The requirements are ANDed.
                                  EOT
                                  "type" = "object"
                                }
                              }
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                          }
                          "type" = "object"
                        }
                        "staticConfig" = {
                          "description" = <<-EOT
                          staticConfig defines the static list of targets to probe and the
                          relabeling configuration.
                          If `ingress` is also defined, `staticConfig` takes precedence.
                          More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#static_config.
                          EOT
                          "properties" = {
                            "labels" = {
                              "additionalProperties" = {
                                "type" = "string"
                              }
                              "description" = "labels defines all labels assigned to all metrics scraped from the targets."
                              "type" = "object"
                            }
                            "relabelingConfigs" = {
                              "description" = <<-EOT
                              relabelingConfigs defines relabelings to be apply to the label set of the targets before it gets
                              scraped.
                              More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
                              EOT
                              "items" = {
                                "description" = <<-EOT
                                RelabelConfig allows dynamic rewriting of the label set for targets, alerts,
                                scraped samples and remote write samples.
                                
                                More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
                                EOT
                                "properties" = {
                                  "action" = {
                                    "default" = "replace"
                                    "description" = <<-EOT
                                    action to perform based on the regex matching.
                                    
                                    `Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.
                                    `DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.
                                    
                                    Default: "Replace"
                                    EOT
                                    "enum" = [
                                      "replace",
                                      "Replace",
                                      "keep",
                                      "Keep",
                                      "drop",
                                      "Drop",
                                      "hashmod",
                                      "HashMod",
                                      "labelmap",
                                      "LabelMap",
                                      "labeldrop",
                                      "LabelDrop",
                                      "labelkeep",
                                      "LabelKeep",
                                      "lowercase",
                                      "Lowercase",
                                      "uppercase",
                                      "Uppercase",
                                      "keepequal",
                                      "KeepEqual",
                                      "dropequal",
                                      "DropEqual",
                                    ]
                                    "type" = "string"
                                  }
                                  "modulus" = {
                                    "description" = <<-EOT
                                    modulus to take of the hash of the source label values.
                                    
                                    Only applicable when the action is `HashMod`.
                                    EOT
                                    "format" = "int64"
                                    "minimum" = 0
                                    "type" = "integer"
                                  }
                                  "regex" = {
                                    "description" = "regex defines the regular expression against which the extracted value is matched."
                                    "type" = "string"
                                  }
                                  "replacement" = {
                                    "description" = <<-EOT
                                    replacement value against which a Replace action is performed if the
                                    regular expression matches.
                                    
                                    Regex capture groups are available.
                                    EOT
                                    "type" = "string"
                                  }
                                  "separator" = {
                                    "description" = "separator defines the string between concatenated SourceLabels."
                                    "type" = "string"
                                  }
                                  "sourceLabels" = {
                                    "description" = <<-EOT
                                    sourceLabels defines the source labels select values from existing labels. Their content is
                                    concatenated using the configured Separator and matched against the
                                    configured regular expression.
                                    EOT
                                    "items" = {
                                      "description" = <<-EOT
                                      LabelName is a valid Prometheus label name.
                                      For Prometheus 3.x, a label name is valid if it contains UTF-8 characters.
                                      For Prometheus 2.x, a label name is only valid if it contains ASCII characters, letters, numbers, as well as underscores.
                                      EOT
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                  }
                                  "targetLabel" = {
                                    "description" = <<-EOT
                                    targetLabel defines the label to which the resulting string is written in a replacement.
                                    
                                    It is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,
                                    `KeepEqual` and `DropEqual` actions.
                                    
                                    Regex capture groups are available.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "type" = "array"
                            }
                            "static" = {
                              "description" = "static defines the list of hosts to probe."
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "tlsConfig" = {
                      "description" = "tlsConfig defines the TLS configuration used by the client."
                      "properties" = {
                        "ca" = {
                          "description" = "ca defines the Certificate authority used when verifying server certificates."
                          "properties" = {
                            "configMap" = {
                              "description" = "configMap defines the ConfigMap containing data to use for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = <<-EOT
                                  The key to select from the ConfigMap's Data field.
                                  Keys in the BinaryData field are not currently propagated to container env vars.
                                  EOT
                                  "type" = "string"
                                }
                                "name" = {
                                  "default" = ""
                                  "description" = <<-EOT
                                  Name of the referent.
                                  This field is effectively required, but due to backwards compatibility is
                                  allowed to be empty. Instances of this type with an empty value here are
                                  almost certainly wrong.
                                  More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                  EOT
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the ConfigMap or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                            "secret" = {
                              "description" = "secret defines the Secret containing data to use for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the secret to select from.  Must be a valid secret key."
                                  "type" = "string"
                                }
                                "name" = {
                                  "default" = ""
                                  "description" = <<-EOT
                                  Name of the referent.
                                  This field is effectively required, but due to backwards compatibility is
                                  allowed to be empty. Instances of this type with an empty value here are
                                  almost certainly wrong.
                                  More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                  EOT
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the Secret or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                          }
                          "type" = "object"
                        }
                        "cert" = {
                          "description" = "cert defines the Client certificate to present when doing client-authentication."
                          "properties" = {
                            "configMap" = {
                              "description" = "configMap defines the ConfigMap containing data to use for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = <<-EOT
                                  The key to select from the ConfigMap's Data field.
                                  Keys in the BinaryData field are not currently propagated to container env vars.
                                  EOT
                                  "type" = "string"
                                }
                                "name" = {
                                  "default" = ""
                                  "description" = <<-EOT
                                  Name of the referent.
                                  This field is effectively required, but due to backwards compatibility is
                                  allowed to be empty. Instances of this type with an empty value here are
                                  almost certainly wrong.
                                  More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                  EOT
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the ConfigMap or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                            "secret" = {
                              "description" = "secret defines the Secret containing data to use for the targets."
                              "properties" = {
                                "key" = {
                                  "description" = "The key of the secret to select from.  Must be a valid secret key."
                                  "type" = "string"
                                }
                                "name" = {
                                  "default" = ""
                                  "description" = <<-EOT
                                  Name of the referent.
                                  This field is effectively required, but due to backwards compatibility is
                                  allowed to be empty. Instances of this type with an empty value here are
                                  almost certainly wrong.
                                  More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                  EOT
                                  "type" = "string"
                                }
                                "optional" = {
                                  "description" = "Specify whether the Secret or its key must be defined"
                                  "type" = "boolean"
                                }
                              }
                              "required" = [
                                "key",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                          }
                          "type" = "object"
                        }
                        "insecureSkipVerify" = {
                          "description" = "insecureSkipVerify defines how to disable target certificate validation."
                          "type" = "boolean"
                        }
                        "keySecret" = {
                          "description" = "keySecret defines the Secret containing the client key file for the targets."
                          "properties" = {
                            "key" = {
                              "description" = "The key of the secret to select from.  Must be a valid secret key."
                              "type" = "string"
                            }
                            "name" = {
                              "default" = ""
                              "description" = <<-EOT
                              Name of the referent.
                              This field is effectively required, but due to backwards compatibility is
                              allowed to be empty. Instances of this type with an empty value here are
                              almost certainly wrong.
                              More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                              EOT
                              "type" = "string"
                            }
                            "optional" = {
                              "description" = "Specify whether the Secret or its key must be defined"
                              "type" = "boolean"
                            }
                          }
                          "required" = [
                            "key",
                          ]
                          "type" = "object"
                          "x-kubernetes-map-type" = "atomic"
                        }
                        "maxVersion" = {
                          "description" = <<-EOT
                          maxVersion defines the maximum acceptable TLS version.
                          
                          It requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.
                          EOT
                          "enum" = [
                            "TLS10",
                            "TLS11",
                            "TLS12",
                            "TLS13",
                          ]
                          "type" = "string"
                        }
                        "minVersion" = {
                          "description" = <<-EOT
                          minVersion defines the minimum acceptable TLS version.
                          
                          It requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.
                          EOT
                          "enum" = [
                            "TLS10",
                            "TLS11",
                            "TLS12",
                            "TLS13",
                          ]
                          "type" = "string"
                        }
                        "serverName" = {
                          "description" = "serverName is used to verify the hostname for the targets."
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                  }
                  "type" = "object"
                }
                "status" = {
                  "description" = <<-EOT
                  status defines the status subresource. It is under active development and is updated only when the
                  "StatusForConfigurationResources" feature gate is enabled.
                  
                  Most recent observed status of the Probe. Read-only.
                  More info:
                  https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
                  EOT
                  "properties" = {
                    "bindings" = {
                      "description" = "bindings defines the list of workload resources (Prometheus, PrometheusAgent, ThanosRuler or Alertmanager) which select the configuration resource."
                      "items" = {
                        "description" = "WorkloadBinding is a link between a configuration resource and a workload resource."
                        "properties" = {
                          "conditions" = {
                            "description" = "conditions defines the current state of the configuration resource when bound to the referenced Workload object."
                            "items" = {
                              "description" = "ConfigResourceCondition describes the status of configuration resources linked to Prometheus, PrometheusAgent, Alertmanager or ThanosRuler."
                              "properties" = {
                                "lastTransitionTime" = {
                                  "description" = "lastTransitionTime defines the time of the last update to the current status property."
                                  "format" = "date-time"
                                  "type" = "string"
                                }
                                "message" = {
                                  "description" = "message defines the human-readable message indicating details for the condition's last transition."
                                  "type" = "string"
                                }
                                "observedGeneration" = {
                                  "description" = <<-EOT
                                  observedGeneration defines the .metadata.generation that the
                                  condition was set based upon. For instance, if `.metadata.generation` is
                                  currently 12, but the `.status.conditions[].observedGeneration` is 9, the
                                  condition is out of date with respect to the current state of the object.
                                  EOT
                                  "format" = "int64"
                                  "type" = "integer"
                                }
                                "reason" = {
                                  "description" = "reason for the condition's last transition."
                                  "type" = "string"
                                }
                                "status" = {
                                  "description" = "status of the condition."
                                  "minLength" = 1
                                  "type" = "string"
                                }
                                "type" = {
                                  "description" = <<-EOT
                                  type of the condition being reported.
                                  Currently, only "Accepted" is supported.
                                  EOT
                                  "enum" = [
                                    "Accepted",
                                  ]
                                  "minLength" = 1
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "lastTransitionTime",
                                "status",
                                "type",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "type",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "group" = {
                            "description" = "group defines the group of the referenced resource."
                            "enum" = [
                              "monitoring.coreos.com",
                            ]
                            "type" = "string"
                          }
                          "name" = {
                            "description" = "name defines the name of the referenced object."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "namespace" = {
                            "description" = "namespace defines the namespace of the referenced object."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "resource" = {
                            "description" = "resource defines the type of resource being referenced (e.g. Prometheus, PrometheusAgent, ThanosRuler or Alertmanager)."
                            "enum" = [
                              "prometheuses",
                              "prometheusagents",
                              "thanosrulers",
                              "alertmanagers",
                            ]
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "group",
                          "name",
                          "namespace",
                          "resource",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-map-keys" = [
                        "group",
                        "resource",
                        "name",
                        "namespace",
                      ]
                      "x-kubernetes-list-type" = "map"
                    }
                  }
                  "type" = "object"
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
