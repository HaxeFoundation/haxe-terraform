resource "kubernetes_manifest" "customresourcedefinition_scrapeconfigs_monitoring_coreos_com" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.22.0"
        "operator.prometheus.io/version" = "0.94.2"
      }
      "name" = "scrapeconfigs.monitoring.coreos.com"
    }
    "spec" = {
      "group" = "monitoring.coreos.com"
      "names" = {
        "categories" = [
          "prometheus-operator",
        ]
        "kind" = "ScrapeConfig"
        "listKind" = "ScrapeConfigList"
        "plural" = "scrapeconfigs"
        "shortNames" = [
          "scfg",
        ]
        "singular" = "scrapeconfig"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = <<-EOT
              ScrapeConfig defines a namespaced Prometheus scrape_config to be aggregated across
              multiple namespaces into the Prometheus configuration.
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
                  "description" = "spec defines the specification of ScrapeConfigSpec."
                  "properties" = {
                    "authorization" = {
                      "description" = "authorization defines the header to use on every scrape request."
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
                    "azureSDConfigs" = {
                      "description" = "azureSDConfigs defines a list of Azure service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        AzureSDConfig allow retrieving scrape targets from Azure VMs.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#azure_sd_config
                        EOT
                        "properties" = {
                          "authenticationMethod" = {
                            "description" = <<-EOT
                            authenticationMethod defines the authentication method, either `OAuth` or `ManagedIdentity` or `SDK`.
                            See https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview
                            SDK authentication method uses environment variables by default.
                            See https://learn.microsoft.com/en-us/azure/developer/go/azure-sdk-authentication
                            EOT
                            "enum" = [
                              "OAuth",
                              "ManagedIdentity",
                              "SDK",
                              "WorkloadIdentity",
                            ]
                            "type" = "string"
                          }
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the authorization header configuration to authenticate against the target HTTP endpoint.
                            Cannot be set at the same time as `oAuth2`, or `basicAuth`.
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
                            basicAuth defines the information to authenticate against the target HTTP endpoint.
                            More info: https://prometheus.io/docs/operating/configuration/#endpoints
                            Cannot be set at the same time as `authorization`, or `oAuth2`.
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
                          "clientID" = {
                            "description" = "clientID defines client ID. Only required with the OAuth authentication method."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "clientSecret" = {
                            "description" = "clientSecret defines client secret. Only required with the OAuth authentication method."
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
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "environment" = {
                            "description" = "environment defines the Azure environment."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
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
                          "oauth2" = {
                            "description" = "oauth2 defines the configuration to use on every scrape request."
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
                          "port" = {
                            "description" = <<-EOT
                            port defines the port to scrape metrics from. If using the public IP address, this must
                            instead be specified in the relabeling rule.
                            EOT
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "resourceGroup" = {
                            "description" = <<-EOT
                            resourceGroup defines resource group name. Limits discovery to this resource group.
                            Requires  Prometheus v2.35.0 and above
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "subscriptionID" = {
                            "description" = "subscriptionID defines subscription ID. Always required."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "tenantID" = {
                            "description" = "tenantID defines tenant ID. Only required with the OAuth authentication method."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration applying to the target HTTP endpoint."
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
                        "required" = [
                          "subscriptionID",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "basicAuth" = {
                      "description" = "basicAuth defines information to use on every scrape request."
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
                    "bodySizeLimit" = {
                      "description" = <<-EOT
                      bodySizeLimit defines a per-scrape limit on the size of the uncompressed
                      response body that will be accepted by Prometheus. Targets responding with
                      a body larger than this many bytes will cause the scrape to fail.
                      
                      It requires Prometheus >= v2.28.0.
                      EOT
                      "pattern" = "(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
                      "type" = "string"
                    }
                    "consulSDConfigs" = {
                      "description" = "consulSDConfigs defines a list of Consul service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        ConsulSDConfig defines a Consul service discovery configuration
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#consul_sd_config
                        EOT
                        "properties" = {
                          "allowStale" = {
                            "description" = <<-EOT
                            allowStale Consul results (see https://www.consul.io/api/features/consistency.html). Will reduce load on Consul.
                            If unset, Prometheus uses its default value.
                            EOT
                            "type" = "boolean"
                          }
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the header configuration to authenticate against the Consul Server.
                            Cannot be set at the same time as `basicAuth`, or `oauth2`.
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
                            basicAuth defines the information to authenticate against the Consul Server.
                            More info: https://prometheus.io/docs/operating/configuration/#endpoints
                            Cannot be set at the same time as `authorization`, or `oauth2`.
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
                          "datacenter" = {
                            "description" = "datacenter defines the consul Datacenter name, if not provided it will use the local Consul Agent Datacenter."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "filter" = {
                            "description" = <<-EOT
                            filter defines the filter expression used to filter the catalog results.
                            See https://developer.hashicorp.com/consul/api-docs/catalog#filtering
                            It requires Prometheus >= 3.0.0.
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "healthFilter" = {
                            "description" = <<-EOT
                            healthFilter defines the filter expression used to filter the health results.
                            See https://developer.hashicorp.com/consul/api-docs/health#filtering
                            It requires Prometheus >= 3.11.2.
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "namespace" = {
                            "description" = <<-EOT
                            namespace are only supported in Consul Enterprise.
                            
                            It requires Prometheus >= 2.28.0.
                            EOT
                            "minLength" = 1
                            "type" = "string"
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
                          "nodeMeta" = {
                            "additionalProperties" = {
                              "type" = "string"
                            }
                            "description" = <<-EOT
                            nodeMeta defines the node metadata key/value pairs to filter nodes for a given service.
                            Starting with Consul 1.14, it is recommended to use `filter` with the `NodeMeta` selector instead.
                            EOT
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "oauth2" = {
                            "description" = <<-EOT
                            oauth2 defines the optional OAuth 2.0 configuration to authenticate against the target HTTP endpoint.
                            Cannot be set at the same time as `authorization`, or `basicAuth`.
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
                          "partition" = {
                            "description" = "partition defines the admin Partitions are only supported in Consul Enterprise."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "pathPrefix" = {
                            "description" = <<-EOT
                            pathPrefix defines the prefix for URIs for when consul is behind an API gateway (reverse proxy).
                            
                            It requires Prometheus >= 2.45.0.
                            EOT
                            "minLength" = 1
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "scheme" = {
                            "description" = "scheme defines the HTTP Scheme."
                            "enum" = [
                              "http",
                              "https",
                              "HTTP",
                              "HTTPS",
                            ]
                            "type" = "string"
                          }
                          "server" = {
                            "description" = "server defines the consul server address. A valid string consisting of a hostname or IP followed by an optional port number."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "services" = {
                            "description" = "services defines a list of services for which targets are retrieved. If omitted, all services are scraped."
                            "items" = {
                              "minLength" = 1
                              "type" = "string"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "set"
                          }
                          "tagSeparator" = {
                            "description" = <<-EOT
                            tagSeparator defines the string by which Consul tags are joined into the tag label.
                            If unset, Prometheus uses its default value.
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "tags" = {
                            "description" = <<-EOT
                            tags defines an optional list of tags used to filter nodes for a given service. Services must contain all tags in the list.
                            Starting with Consul 1.14, it is recommended to use `filter` with the `ServiceTags` selector instead.
                            EOT
                            "items" = {
                              "minLength" = 1
                              "type" = "string"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "set"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the Consul API."
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
                          "tokenRef" = {
                            "description" = "tokenRef defines the consul ACL TokenRef, if not provided it will use the ACL from the local Consul Agent."
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
                        "required" = [
                          "server",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "convertClassicHistogramsToNHCB" = {
                      "description" = <<-EOT
                      convertClassicHistogramsToNHCB defines whether to convert all scraped classic histograms into a native histogram with custom buckets.
                      It requires Prometheus >= v3.0.0.
                      EOT
                      "type" = "boolean"
                    }
                    "digitalOceanSDConfigs" = {
                      "description" = "digitalOceanSDConfigs defines a list of DigitalOcean service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        DigitalOceanSDConfig allow retrieving scrape targets from DigitalOcean's Droplets API.
                        This service discovery uses the public IPv4 address by default, by that can be changed with relabeling
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#digitalocean_sd_config
                        EOT
                        "properties" = {
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the header configuration to authenticate against the DigitalOcean API.
                            Cannot be set at the same time as `oauth2`.
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
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
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
                          "oauth2" = {
                            "description" = "oauth2 defines the configuration to use on every scrape request."
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
                          "port" = {
                            "description" = "port defines the port to scrape metrics from. If using the public IP address, this must"
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the DigitalOcean API."
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
                      "type" = "array"
                    }
                    "dnsSDConfigs" = {
                      "description" = "dnsSDConfigs defines a list of DNS service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        DNSSDConfig allows specifying a set of DNS domain names which are periodically queried to discover a list of targets.
                        The DNS servers to be contacted are read from /etc/resolv.conf.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#dns_sd_config
                        EOT
                        "properties" = {
                          "names" = {
                            "description" = "names defines a list of DNS domain names to be queried."
                            "items" = {
                              "minLength" = 1
                              "type" = "string"
                            }
                            "minItems" = 1
                            "type" = "array"
                          }
                          "port" = {
                            "description" = <<-EOT
                            port defines the port to scrape metrics from. If using the public IP address, this must
                            Ignored for SRV records
                            EOT
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
                          }
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "type" = {
                            "description" = <<-EOT
                            type defines the type of DNS query to perform. One of SRV, A, AAAA, MX or NS.
                            If not set, Prometheus uses its default value.
                            
                            When set to NS, it requires Prometheus >= v2.49.0.
                            When set to MX, it requires Prometheus >= v2.38.0
                            EOT
                            "enum" = [
                              "A",
                              "AAAA",
                              "MX",
                              "NS",
                              "SRV",
                            ]
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "names",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "dockerSDConfigs" = {
                      "description" = "dockerSDConfigs defines a list of Docker service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        Docker SD configurations allow retrieving scrape targets from Docker Engine hosts.
                        This SD discovers "containers" and will create a target for each network IP and
                        port the container is configured to expose.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#docker_sd_config
                        EOT
                        "properties" = {
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the header configuration to authenticate against the Docker daemon.
                            Cannot be set at the same time as `oauth2`.
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
                            "description" = "basicAuth defines information to use on every scrape request."
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
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "filters" = {
                            "description" = "filters defines filters to limit the discovery process to a subset of the available resources."
                            "items" = {
                              "description" = "Filter name and value pairs to limit the discovery process to a subset of available resources."
                              "properties" = {
                                "name" = {
                                  "description" = "name of the Filter."
                                  "minLength" = 1
                                  "type" = "string"
                                }
                                "values" = {
                                  "description" = "values defines values to filter on."
                                  "items" = {
                                    "minLength" = 1
                                    "type" = "string"
                                  }
                                  "minItems" = 1
                                  "type" = "array"
                                  "x-kubernetes-list-type" = "set"
                                }
                              }
                              "required" = [
                                "name",
                                "values",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "name",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "host" = {
                            "description" = "host defines the address of the docker daemon."
                            "pattern" = "^[a-zA-Z][a-zA-Z0-9+.-]*://.+$"
                            "type" = "string"
                          }
                          "hostNetworkingHost" = {
                            "description" = "hostNetworkingHost defines the host to use if the container is in host networking mode."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "matchFirstNetwork" = {
                            "description" = <<-EOT
                            matchFirstNetwork defines whether to match the first network if the container has multiple networks defined.
                            If unset, Prometheus uses true by default.
                            It requires Prometheus >= v2.54.1.
                            EOT
                            "type" = "boolean"
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
                          "oauth2" = {
                            "description" = "oauth2 defines the configuration to use on every scrape request."
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
                          "port" = {
                            "description" = "port defines the port to scrape metrics from. If using the public IP address, this must"
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the Docker daemon."
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
                        "required" = [
                          "host",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "dockerSwarmSDConfigs" = {
                      "description" = "dockerSwarmSDConfigs defines a list of Dockerswarm service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        DockerSwarmSDConfig configurations allow retrieving scrape targets from Docker Swarm engine.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#dockerswarm_sd_config
                        EOT
                        "properties" = {
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the header configuration to authenticate against the Docker Swarm API.
                            Cannot be set at the same time as `oauth2`.
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
                            "description" = "basicAuth defines information to use on every scrape request."
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
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "filters" = {
                            "description" = <<-EOT
                            filters defines the filters to limit the discovery process to a subset of available
                            resources.
                            The available filters are listed in the upstream documentation:
                            Services: https://docs.docker.com/engine/api/v1.40/#operation/ServiceList
                            Tasks: https://docs.docker.com/engine/api/v1.40/#operation/TaskList
                            Nodes: https://docs.docker.com/engine/api/v1.40/#operation/NodeList
                            EOT
                            "items" = {
                              "description" = "Filter name and value pairs to limit the discovery process to a subset of available resources."
                              "properties" = {
                                "name" = {
                                  "description" = "name of the Filter."
                                  "minLength" = 1
                                  "type" = "string"
                                }
                                "values" = {
                                  "description" = "values defines values to filter on."
                                  "items" = {
                                    "minLength" = 1
                                    "type" = "string"
                                  }
                                  "minItems" = 1
                                  "type" = "array"
                                  "x-kubernetes-list-type" = "set"
                                }
                              }
                              "required" = [
                                "name",
                                "values",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "name",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "host" = {
                            "description" = "host defines the address of the Docker daemon"
                            "pattern" = "^[a-zA-Z][a-zA-Z0-9+.-]*://.+$"
                            "type" = "string"
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
                          "oauth2" = {
                            "description" = <<-EOT
                            oauth2 defines the optional OAuth 2.0 configuration to authenticate against the target HTTP endpoint.
                            Cannot be set at the same time as `authorization`, or `basicAuth`.
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
                          "port" = {
                            "description" = <<-EOT
                            port defines the port to scrape metrics from. If using the public IP address, this must
                            tasks and services that don't have published ports.
                            EOT
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "role" = {
                            "description" = "role of the targets to retrieve. Must be `Services`, `Tasks`, or `Nodes`."
                            "enum" = [
                              "Services",
                              "Tasks",
                              "Nodes",
                            ]
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the Docker Swarm daemon."
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
                        "required" = [
                          "host",
                          "role",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "ec2SDConfigs" = {
                      "description" = "ec2SDConfigs defines a list of EC2 service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        EC2SDConfig allow retrieving scrape targets from AWS EC2 instances.
                        The private IP address is used by default, but may be changed to the public IP address with relabeling.
                        The IAM credentials used must have the ec2:DescribeInstances permission to discover scrape targets
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#ec2_sd_config
                        
                        The EC2 service discovery requires AWS API keys or role ARN for authentication.
                        BasicAuth, Authorization and OAuth2 fields are not present on purpose.
                        EOT
                        "properties" = {
                          "accessKey" = {
                            "description" = "accessKey defines the AWS API key."
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
                          "enableHTTP2" = {
                            "description" = <<-EOT
                            enableHTTP2 defines whether to enable HTTP2.
                            It requires Prometheus >= v2.41.0
                            EOT
                            "type" = "boolean"
                          }
                          "filters" = {
                            "description" = <<-EOT
                            filters can be used optionally to filter the instance list by other criteria.
                            Available filter criteria can be found here:
                            https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html
                            Filter API documentation: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Filter.html
                            It requires Prometheus >= v2.3.0
                            EOT
                            "items" = {
                              "description" = "Filter name and value pairs to limit the discovery process to a subset of available resources."
                              "properties" = {
                                "name" = {
                                  "description" = "name of the Filter."
                                  "minLength" = 1
                                  "type" = "string"
                                }
                                "values" = {
                                  "description" = "values defines values to filter on."
                                  "items" = {
                                    "minLength" = 1
                                    "type" = "string"
                                  }
                                  "minItems" = 1
                                  "type" = "array"
                                  "x-kubernetes-list-type" = "set"
                                }
                              }
                              "required" = [
                                "name",
                                "values",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "name",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "followRedirects" = {
                            "description" = <<-EOT
                            followRedirects defines whether HTTP requests follow HTTP 3xx redirects.
                            It requires Prometheus >= v2.41.0
                            EOT
                            "type" = "boolean"
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
                          "port" = {
                            "description" = <<-EOT
                            port defines the port to scrape metrics from. If using the public IP address, this must
                            instead be specified in the relabeling rule.
                            EOT
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "region" = {
                            "description" = "region defines the AWS region."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "roleARN" = {
                            "description" = "roleARN defines an alternative to using AWS API keys."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "secretKey" = {
                            "description" = "secretKey defines the AWS API secret."
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
                          "tlsConfig" = {
                            "description" = <<-EOT
                            tlsConfig defines the TLS configuration to connect to the EC2 API.
                            It requires Prometheus >= v2.41.0
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
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "enableCompression" = {
                      "description" = <<-EOT
                      enableCompression when false, Prometheus will request uncompressed response from the scraped target.
                      
                      It requires Prometheus >= v2.49.0.
                      
                      If unset, Prometheus uses true by default.
                      EOT
                      "type" = "boolean"
                    }
                    "enableHTTP2" = {
                      "description" = "enableHTTP2 defines whether to enable HTTP2."
                      "type" = "boolean"
                    }
                    "eurekaSDConfigs" = {
                      "description" = "eurekaSDConfigs defines a list of Eureka service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        Eureka SD configurations allow retrieving scrape targets using the Eureka REST API.
                        Prometheus will periodically check the REST endpoint and create a target for every app instance.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#eureka_sd_config
                        EOT
                        "properties" = {
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the header configuration to authenticate against the Eureka server.
                            Cannot be set at the same time as `oauth2`.
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
                            "description" = "basicAuth defines the BasicAuth information to use on every scrape request."
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
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
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
                          "oauth2" = {
                            "description" = "oauth2 defines the configuration to use on every scrape request."
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "server" = {
                            "description" = "server defines the URL to connect to the Eureka server."
                            "pattern" = "^https?://.+$"
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the Eureka server."
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
                        "required" = [
                          "server",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
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
                    "fileSDConfigs" = {
                      "description" = "fileSDConfigs defines a list of file service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        FileSDConfig defines a Prometheus file service discovery configuration
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#file_sd_config
                        EOT
                        "properties" = {
                          "files" = {
                            "description" = <<-EOT
                            files defines the list of files to be used for file discovery. Recommendation: use absolute paths. While relative paths work, the
                            prometheus-operator project makes no guarantees about the working directory where the configuration file is
                            stored.
                            Files must be mounted using Prometheus.ConfigMaps or Prometheus.Secrets.
                            EOT
                            "items" = {
                              "description" = "SDFile represents a file used for service discovery"
                              "pattern" = "^[^*]*(\\*[^/]*)?\\.(json|yml|yaml|JSON|YML|YAML)$"
                              "type" = "string"
                            }
                            "minItems" = 1
                            "type" = "array"
                            "x-kubernetes-list-type" = "set"
                          }
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "files",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "gceSDConfigs" = {
                      "description" = "gceSDConfigs defines a list of GCE service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        GCESDConfig configures scrape targets from GCP GCE instances.
                        The private IP address is used by default, but may be changed to
                        the public IP address with relabeling.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#gce_sd_config
                        
                        The GCE service discovery will load the Google Cloud credentials
                        from the file specified by the GOOGLE_APPLICATION_CREDENTIALS environment variable.
                        See https://cloud.google.com/kubernetes-engine/docs/tutorials/authenticating-to-cloud-platform
                        
                        A pre-requisite for using GCESDConfig is that a Secret containing valid
                        Google Cloud credentials is mounted into the Prometheus or PrometheusAgent
                        pod via the `.spec.secrets` field and that the GOOGLE_APPLICATION_CREDENTIALS
                        environment variable is set to /etc/prometheus/secrets/<secret-name>/<credentials-filename.json>.
                        EOT
                        "properties" = {
                          "filter" = {
                            "description" = <<-EOT
                            filter defines the filter that can be used optionally to filter the instance list by other criteria
                            Syntax of this filter is described in the filter query parameter section:
                            https://cloud.google.com/compute/docs/reference/latest/instances/list
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "port" = {
                            "description" = <<-EOT
                            port defines the port to scrape metrics from. If using the public IP address, this must
                            instead be specified in the relabeling rule.
                            EOT
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
                          }
                          "project" = {
                            "description" = "project defines the Google Cloud Project ID"
                            "minLength" = 1
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "tagSeparator" = {
                            "description" = "tagSeparator defines the tag separator is used to separate the tags on concatenation"
                            "minLength" = 1
                            "type" = "string"
                          }
                          "zone" = {
                            "description" = "zone defines the zone of the scrape targets. If you need multiple zones use multiple GCESDConfigs."
                            "minLength" = 1
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "project",
                          "zone",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "hetznerSDConfigs" = {
                      "description" = "hetznerSDConfigs defines a list of Hetzner service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        HetznerSDConfig allow retrieving scrape targets from Hetzner Cloud API and Robot API.
                        This service discovery uses the public IPv4 address by default, but that can be changed with relabeling
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#hetzner_sd_config
                        EOT
                        "properties" = {
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the header configuration to authenticate against the Hetzner API.
                            Cannot be set at the same time as `oauth2`.
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
                            "description" = "basicAuth defines information to use on every scrape request."
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
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "labelSelector" = {
                            "description" = <<-EOT
                            labelSelector defines the label selector used to filter the servers when fetching them from the API.
                            It requires Prometheus >= v3.5.0.
                            EOT
                            "minLength" = 1
                            "type" = "string"
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
                          "oauth2" = {
                            "description" = "oauth2 defines the configuration to use on every scrape request."
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
                          "port" = {
                            "description" = "port defines the port to scrape metrics from. If using the public IP address, this must"
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "role" = {
                            "description" = "role defines the Hetzner role of entities that should be discovered."
                            "enum" = [
                              "Hcloud",
                              "Robot",
                            ]
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the Hetzner API."
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
                        "required" = [
                          "role",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "honorLabels" = {
                      "description" = <<-EOT
                      honorLabels defines when true the metric's labels when they collide
                      with the target's labels.
                      EOT
                      "type" = "boolean"
                    }
                    "honorTimestamps" = {
                      "description" = <<-EOT
                      honorTimestamps defines whether Prometheus preserves the timestamps
                      when exposed by the target.
                      EOT
                      "type" = "boolean"
                    }
                    "httpSDConfigs" = {
                      "description" = "httpSDConfigs defines a list of HTTP service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        HTTPSDConfig defines a prometheus HTTP service discovery configuration
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#http_sd_config
                        EOT
                        "properties" = {
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the authorization header configuration to authenticate against the target HTTP endpoint.
                            Cannot be set at the same time as `oAuth2`, or `basicAuth`.
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
                            basicAuth defines information to use on every scrape request.
                            More info: https://prometheus.io/docs/operating/configuration/#endpoints
                            Cannot be set at the same time as `authorization`, or `oAuth2`.
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
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
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
                          "oauth2" = {
                            "description" = <<-EOT
                            oauth2 defines the optional OAuth 2.0 configuration to authenticate against the target HTTP endpoint.
                            Cannot be set at the same time as `authorization`, or `basicAuth`.
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration applying to the target HTTP endpoint."
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
                          "url" = {
                            "description" = "url defines the URL from which the targets are fetched."
                            "pattern" = "^https?://.+$"
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "url",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "ionosSDConfigs" = {
                      "description" = "ionosSDConfigs defines a list of IONOS service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        IonosSDConfig configurations allow retrieving scrape targets from IONOS resources.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#ionos_sd_config
                        EOT
                        "properties" = {
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the header configuration to authenticate against the IONOS API.
                            Cannot be set at the same time as `oauth2`.
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
                          "datacenterID" = {
                            "description" = "datacenterID defines the unique ID of the IONOS data center."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
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
                          "oauth2" = {
                            "description" = "oauth2 defines the configuration to use on every scrape request."
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
                          "port" = {
                            "description" = "port defines the port to scrape metrics from. If using the public IP address, this must"
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the IONOS API."
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
                        "required" = [
                          "authorization",
                          "datacenterID",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "jobName" = {
                      "description" = <<-EOT
                      jobName defines the value of the `job` label assigned to the scraped metrics by default.
                      
                      The `job_name` field in the rendered scrape configuration is always controlled by the
                      operator to prevent duplicate job names, which Prometheus does not allow. Instead the
                      `job` label is set by means of relabeling configs.
                      EOT
                      "minLength" = 1
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
                    "kubernetesSDConfigs" = {
                      "description" = "kubernetesSDConfigs defines a list of Kubernetes service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        KubernetesSDConfig allows retrieving scrape targets from Kubernetes' REST API.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#kubernetes_sd_config
                        EOT
                        "properties" = {
                          "apiServer" = {
                            "description" = <<-EOT
                            apiServer defines the API server address consisting of a hostname or IP address followed
                            by an optional port number.
                            If left empty, Prometheus is assumed to run inside
                            of the cluster. It will discover API servers automatically and use the pod's
                            CA certificate and bearer token file at /var/run/secrets/kubernetes.io/serviceaccount/.
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "attachMetadata" = {
                            "description" = <<-EOT
                            attachMetadata defines the metadata to attach to discovered targets.
                            It requires Prometheus >= v2.35.0 when using the `Pod` role and
                            Prometheus >= v2.37.0 for `Endpoints` and `Endpointslice` roles.
                            EOT
                            "properties" = {
                              "node" = {
                                "description" = <<-EOT
                                node attaches node metadata to discovered targets.
                                When set to true, Prometheus must have the `get` permission on the
                                `Nodes` objects.
                                Only valid for Pod, Endpoint and Endpointslice roles.
                                EOT
                                "type" = "boolean"
                              }
                            }
                            "type" = "object"
                          }
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the authorization header to use on every scrape request.
                            Cannot be set at the same time as `basicAuth`, or `oauth2`.
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
                            basicAuth defines information to use on every scrape request.
                            Cannot be set at the same time as `authorization`, or `oauth2`.
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
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "namespaces" = {
                            "description" = "namespaces defines the namespace discovery. If omitted, Prometheus discovers targets across all namespaces."
                            "properties" = {
                              "names" = {
                                "description" = <<-EOT
                                names defines a list of namespaces where to watch for resources.
                                If empty and `ownNamespace` isn't true, Prometheus watches for resources in all namespaces.
                                EOT
                                "items" = {
                                  "minLength" = 1
                                  "type" = "string"
                                }
                                "type" = "array"
                                "x-kubernetes-list-type" = "set"
                              }
                              "ownNamespace" = {
                                "description" = "ownNamespace includes the namespace in which the Prometheus pod runs to the list of watched namespaces."
                                "type" = "boolean"
                              }
                            }
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
                          "oauth2" = {
                            "description" = <<-EOT
                            oauth2 defines the optional OAuth 2.0 configuration to authenticate against the target HTTP endpoint.
                            Cannot be set at the same time as `authorization`, or `basicAuth`.
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
                          "role" = {
                            "description" = <<-EOT
                            role defines the Kubernetes role of the entities that should be discovered.
                            Role `Endpointslice` requires Prometheus >= v2.21.0
                            EOT
                            "enum" = [
                              "Pod",
                              "Endpoints",
                              "Ingress",
                              "Service",
                              "Node",
                              "EndpointSlice",
                            ]
                            "type" = "string"
                          }
                          "selectors" = {
                            "description" = <<-EOT
                            selectors defines the selector to select objects.
                            It requires Prometheus >= v2.17.0
                            EOT
                            "items" = {
                              "description" = "K8SSelectorConfig is Kubernetes Selector Config"
                              "properties" = {
                                "field" = {
                                  "description" = <<-EOT
                                  field defines an optional field selector to limit the service discovery to resources which have fields with specific values.
                                  e.g: `metadata.name=foobar`
                                  EOT
                                  "minLength" = 1
                                  "type" = "string"
                                }
                                "label" = {
                                  "description" = <<-EOT
                                  label defines an optional label selector to limit the service discovery to resources with specific labels and label values.
                                  e.g: `node.kubernetes.io/instance-type=master`
                                  EOT
                                  "minLength" = 1
                                  "type" = "string"
                                }
                                "role" = {
                                  "description" = <<-EOT
                                  role defines the type of Kubernetes resource to limit the service discovery to.
                                  Accepted values are: Node, Pod, Endpoints, EndpointSlice, Service, Ingress.
                                  EOT
                                  "enum" = [
                                    "Pod",
                                    "Endpoints",
                                    "Ingress",
                                    "Service",
                                    "Node",
                                    "EndpointSlice",
                                  ]
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "role",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "role",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the Kubernetes API."
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
                        "required" = [
                          "role",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "kumaSDConfigs" = {
                      "description" = "kumaSDConfigs defines a list of Kuma service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        KumaSDConfig allow retrieving scrape targets from Kuma's control plane.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#kuma_sd_config
                        EOT
                        "properties" = {
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the header configuration to authenticate against the Kuma control plane.
                            Cannot be set at the same time as `oauth2`.
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
                            "description" = "basicAuth defines information to use on every scrape request."
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
                          "clientID" = {
                            "description" = <<-EOT
                            clientID is used by Kuma Control Plane to compute Monitoring Assignment for specific Prometheus backend.
                            It requires Prometheus >= v2.50.0.
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "fetchTimeout" = {
                            "description" = "fetchTimeout defines the time after which the monitoring assignments are refreshed."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
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
                          "oauth2" = {
                            "description" = "oauth2 defines the configuration to use on every scrape request."
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "server" = {
                            "description" = "server defines the address of the Kuma Control Plane's MADS xDS server."
                            "pattern" = "^https?://.+$"
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the Kuma control plane."
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
                        "required" = [
                          "server",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
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
                    "lightSailSDConfigs" = {
                      "description" = "lightSailSDConfigs defines a list of Lightsail service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        LightSailSDConfig configurations allow retrieving scrape targets from AWS Lightsail instances.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#lightsail_sd_config
                        EOT
                        "properties" = {
                          "accessKey" = {
                            "description" = "accessKey defines the AWS API key."
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
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the header configuration to authenticate against the Lightsail API.
                            Cannot be set at the same time as `oauth2`.
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
                            basicAuth defines information to use on every scrape request.
                            Cannot be set at the same time as `authorization`, or `oauth2`.
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
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "endpoint" = {
                            "description" = "endpoint defines the custom endpoint to be used."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
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
                          "oauth2" = {
                            "description" = <<-EOT
                            oauth2 defines the optional OAuth 2.0 configuration to authenticate against the target HTTP endpoint.
                            Cannot be set at the same time as `authorization`, or `basicAuth`.
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
                          "port" = {
                            "description" = "port defines the port to scrape metrics from. If using the public IP address, this must"
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "region" = {
                            "description" = "region defines the AWS region."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "roleARN" = {
                            "description" = "roleARN defines the AWS Role ARN, an alternative to using AWS API keys."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "secretKey" = {
                            "description" = "secretKey defines the AWS API secret."
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
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the Lightsail API."
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
                      "type" = "array"
                    }
                    "linodeSDConfigs" = {
                      "description" = "linodeSDConfigs defines a list of Linode service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        LinodeSDConfig configurations allow retrieving scrape targets from Linode's Linode APIv4.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#linode_sd_config
                        EOT
                        "properties" = {
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the header configuration to authenticate against the Linode API.
                            Cannot be set at the same time as `oauth2`.
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
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
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
                          "oauth2" = {
                            "description" = <<-EOT
                            oauth2 defines the optional OAuth 2.0 configuration to authenticate against the target HTTP endpoint.
                            Cannot be set at the same time as `authorization`, or `basicAuth`.
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
                          "port" = {
                            "description" = "port defines the port to scrape metrics from. If using the public IP address, this must"
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "region" = {
                            "description" = "region defines the region to filter on."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "tagSeparator" = {
                            "description" = "tagSeparator defines the string by which Linode Instance tags are joined into the tag label.el."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the Linode API."
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
                      "type" = "array"
                    }
                    "metricRelabelings" = {
                      "description" = "metricRelabelings defines the metricRelabelings to apply to samples before ingestion."
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
                      "minItems" = 1
                      "type" = "array"
                    }
                    "metricsPath" = {
                      "description" = "metricsPath defines the HTTP path to scrape for metrics. If empty, Prometheus uses the default value (e.g. /metrics)."
                      "minLength" = 1
                      "type" = "string"
                    }
                    "nameEscapingScheme" = {
                      "description" = <<-EOT
                      nameEscapingScheme defines the metric name escaping mode to request through content negotiation.
                      
                      It requires Prometheus >= v3.4.0.
                      EOT
                      "enum" = [
                        "AllowUTF8",
                        "Underscores",
                        "Dots",
                        "Values",
                      ]
                      "type" = "string"
                    }
                    "nameValidationScheme" = {
                      "description" = <<-EOT
                      nameValidationScheme defines the validation scheme for metric and label names.
                      
                      It requires Prometheus >= v3.0.0.
                      EOT
                      "enum" = [
                        "UTF8",
                        "Legacy",
                      ]
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
                    "noProxy" = {
                      "description" = <<-EOT
                      noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
                      that should be excluded from proxying. IP and domain names can
                      contain port numbers.
                      
                      It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
                      EOT
                      "type" = "string"
                    }
                    "nomadSDConfigs" = {
                      "description" = "nomadSDConfigs defines a list of Nomad service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        NomadSDConfig configurations allow retrieving scrape targets from Nomad's Service API.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#nomad_sd_config
                        EOT
                        "properties" = {
                          "allowStale" = {
                            "description" = <<-EOT
                            allowStale defines the information to access the Nomad API. It is to be defined
                            as the Nomad documentation requires.
                            EOT
                            "type" = "boolean"
                          }
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the header configuration to authenticate against the Nomad API.
                            Cannot be set at the same time as `oauth2`.
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
                            "description" = "basicAuth defines information to use on every scrape request."
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
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "namespace" = {
                            "description" = <<-EOT
                            namespace defines the Nomad namespace to query for service discovery.
                            When specified, only resources within this namespace will be discovered.
                            EOT
                            "minLength" = 1
                            "type" = "string"
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
                          "oauth2" = {
                            "description" = "oauth2 defines the configuration to use on every scrape request."
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "region" = {
                            "description" = <<-EOT
                            region defines the Nomad region to query for service discovery.
                            When specified, only resources within this region will be discovered.
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "server" = {
                            "description" = <<-EOT
                            server defines the Nomad server address to connect to for service discovery.
                            This should be the full URL including protocol (e.g., "https://nomad.example.com:4646").
                            EOT
                            "pattern" = "^https?://.+$"
                            "type" = "string"
                          }
                          "tagSeparator" = {
                            "description" = <<-EOT
                            tagSeparator defines the separator used to join multiple tags.
                            This determines how Nomad service tags are concatenated into Prometheus labels.
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the Nomad API."
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
                        "required" = [
                          "server",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "oauth2" = {
                      "description" = "oauth2 defines the configuration to use on every scrape request."
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
                    "openstackSDConfigs" = {
                      "description" = "openstackSDConfigs defines a list of OpenStack service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        OpenStackSDConfig allow retrieving scrape targets from OpenStack Nova instances.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#openstack_sd_config
                        EOT
                        "properties" = {
                          "allTenants" = {
                            "description" = <<-EOT
                            allTenants defines whether the service discovery should list all instances for all projects.
                            It is only relevant for the 'instance' role and usually requires admin permissions.
                            EOT
                            "type" = "boolean"
                          }
                          "applicationCredentialId" = {
                            "description" = "applicationCredentialId defines the OpenStack applicationCredentialId."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "applicationCredentialName" = {
                            "description" = <<-EOT
                            applicationCredentialName defines the ApplicationCredentialID or ApplicationCredentialName fields are
                            required if using an application credential to authenticate. Some providers
                            allow you to create an application credential to authenticate rather than a
                            password.
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "applicationCredentialSecret" = {
                            "description" = <<-EOT
                            applicationCredentialSecret defines the required field if using an application
                            credential to authenticate.
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
                          "availability" = {
                            "description" = "availability defines the availability of the endpoint to connect to."
                            "enum" = [
                              "Public",
                              "Admin",
                              "Internal",
                            ]
                            "type" = "string"
                          }
                          "domainID" = {
                            "description" = "domainID defines The OpenStack domainID."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "domainName" = {
                            "description" = <<-EOT
                            domainName defines at most one of domainId and domainName that must be provided if using username
                            with Identity V3. Otherwise, either are optional.
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "identityEndpoint" = {
                            "description" = <<-EOT
                            identityEndpoint defines the HTTP endpoint that is required to work with
                            the Identity API of the appropriate version.
                            EOT
                            "pattern" = "^https?://.+$"
                            "type" = "string"
                          }
                          "password" = {
                            "description" = <<-EOT
                            password defines the password for the Identity V2 and V3 APIs. Consult with your provider's
                            control panel to discover your account's preferred method of authentication.
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
                          "port" = {
                            "description" = <<-EOT
                            port defines the port to scrape metrics from. If using the public IP address, this must
                            instead be specified in the relabeling rule.
                            EOT
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
                          }
                          "projectID" = {
                            "description" = "projectID defines the OpenStack projectID."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "projectName" = {
                            "description" = <<-EOT
                            projectName defines an optional field for the Identity V2 API.
                            Some providers allow you to specify a ProjectName instead of the ProjectId.
                            Some require both. Your provider's authentication policies will determine
                            how these fields influence authentication.
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "region" = {
                            "description" = "region defines the OpenStack Region."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "role" = {
                            "description" = <<-EOT
                            role defines the OpenStack role of entities that should be discovered.
                            
                            Note: The `LoadBalancer` role requires Prometheus >= v3.2.0.
                            EOT
                            "enum" = [
                              "Instance",
                              "Hypervisor",
                              "LoadBalancer",
                            ]
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration applying to the target HTTP endpoint."
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
                          "userid" = {
                            "description" = "userid defines the OpenStack userid."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "username" = {
                            "description" = <<-EOT
                            username defines the username required if using Identity V2 API. Consult with your provider's
                            control panel to discover your account's username.
                            In Identity V3, either userid or a combination of username
                            and domainId or domainName are needed
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "region",
                          "role",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "ovhcloudSDConfigs" = {
                      "description" = "ovhcloudSDConfigs defines a list of OVHcloud service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        OVHCloudSDConfig configurations allow retrieving scrape targets from OVHcloud's dedicated servers and VPS using their API.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#ovhcloud_sd_config
                        EOT
                        "properties" = {
                          "applicationKey" = {
                            "description" = <<-EOT
                            applicationKey defines the access key to use for OVHCloud API authentication.
                            This is obtained from the OVHCloud API credentials at https://api.ovh.com.
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "applicationSecret" = {
                            "description" = <<-EOT
                            applicationSecret defines the secret key for OVHCloud API authentication.
                            This contains the application secret obtained during OVHCloud API credential creation.
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
                          "consumerKey" = {
                            "description" = <<-EOT
                            consumerKey defines the consumer key for OVHCloud API authentication.
                            This is the third component of OVHCloud's three-key authentication system.
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
                          "endpoint" = {
                            "description" = <<-EOT
                            endpoint defines a custom API endpoint to be used.
                            When not specified, defaults to the standard OVHCloud API endpoint for the region.
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "service" = {
                            "description" = <<-EOT
                            service defines the service type of the targets to retrieve.
                            Must be either `VPS` or `DedicatedServer` to specify which OVHCloud resources to discover.
                            EOT
                            "enum" = [
                              "VPS",
                              "DedicatedServer",
                            ]
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "applicationKey",
                          "applicationSecret",
                          "consumerKey",
                          "service",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "params" = {
                      "additionalProperties" = {
                        "items" = {
                          "type" = "string"
                        }
                        "type" = "array"
                      }
                      "description" = "params defines optional HTTP URL parameters"
                      "type" = "object"
                      "x-kubernetes-map-type" = "atomic"
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
                    "puppetDBSDConfigs" = {
                      "description" = "puppetDBSDConfigs defines a list of PuppetDB service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        PuppetDBSDConfig configurations allow retrieving scrape targets from PuppetDB resources.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#puppetdb_sd_config
                        EOT
                        "properties" = {
                          "authorization" = {
                            "description" = <<-EOT
                            authorization defines the header configuration to authenticate against the PuppetDB API.
                            Cannot be set at the same time as `oauth2`.
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
                            basicAuth defines information to use on every scrape request.
                            Cannot be set at the same time as `authorization`, or `oauth2`.
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
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "includeParameters" = {
                            "description" = <<-EOT
                            includeParameters defines whether to include the parameters as meta labels.
                            Note: Enabling this exposes parameters in the Prometheus UI and API. Make sure
                            that you don't have secrets exposed as parameters if you enable this.
                            EOT
                            "type" = "boolean"
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
                          "oauth2" = {
                            "description" = <<-EOT
                            oauth2 defines the optional OAuth 2.0 configuration to authenticate against the target HTTP endpoint.
                            Cannot be set at the same time as `authorization`, or `basicAuth`.
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
                          "port" = {
                            "description" = "port defines the port to scrape metrics from. If using the public IP address, this must"
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
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
                          "query" = {
                            "description" = <<-EOT
                            query defines the Puppet Query Language (PQL) query. Only resources are supported.
                            https://puppet.com/docs/puppetdb/latest/api/query/v4/pql.html
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the PuppetDB server."
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
                          "url" = {
                            "description" = "url defines the URL of the PuppetDB root query endpoint."
                            "pattern" = "^https?://.+$"
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "query",
                          "url",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "relabelings" = {
                      "description" = <<-EOT
                      relabelings defines how to rewrite the target's labels before scraping.
                      Prometheus Operator automatically adds relabelings for a few standard Kubernetes fields.
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
                      "minItems" = 1
                      "type" = "array"
                    }
                    "sampleLimit" = {
                      "description" = "sampleLimit defines per-scrape limit on number of scraped samples that will be accepted."
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "scalewaySDConfigs" = {
                      "description" = "scalewaySDConfigs defines a list of Scaleway instances and baremetal service discovery configurations."
                      "items" = {
                        "description" = <<-EOT
                        ScalewaySDConfig configurations allow retrieving scrape targets from Scaleway instances and baremetal services.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scaleway_sd_config
                        
                        Note: The `_file` variants of credential fields (e.g. `secret_key_file`)
                        from the Prometheus configuration are not supported. Use Kubernetes secrets via `secretKey` instead.
                        EOT
                        "properties" = {
                          "accessKey" = {
                            "description" = "accessKey defines the access key to use. https://console.scaleway.com/project/credentials"
                            "minLength" = 1
                            "type" = "string"
                          }
                          "apiURL" = {
                            "description" = "apiURL defines the API URL to use when doing the server listing requests."
                            "pattern" = "^https?://.+$"
                            "type" = "string"
                          }
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = "followRedirects defines whether HTTP requests follow HTTP 3xx redirects."
                            "type" = "boolean"
                          }
                          "nameFilter" = {
                            "description" = "nameFilter defines a name filter (works as a LIKE) to apply on the server listing request."
                            "minLength" = 1
                            "type" = "string"
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
                          "port" = {
                            "description" = "port defines the port to scrape metrics from. If using the public IP address, this must"
                            "format" = "int32"
                            "maximum" = 65535
                            "minimum" = 0
                            "type" = "integer"
                          }
                          "projectID" = {
                            "description" = "projectID defines the Project ID of the targets."
                            "minLength" = 1
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
                          "refreshInterval" = {
                            "description" = <<-EOT
                            refreshInterval defines the time after which the provided names are refreshed.
                            If not set, Prometheus uses its default value.
                            EOT
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "role" = {
                            "description" = "role defines the service of the targets to retrieve. Must be `Instance` or `Baremetal`."
                            "enum" = [
                              "Instance",
                              "Baremetal",
                            ]
                            "type" = "string"
                          }
                          "secretKey" = {
                            "description" = "secretKey defines the secret key to use when listing targets."
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
                          "tagsFilter" = {
                            "description" = "tagsFilter defines a tag filter (a server needs to have all defined tags to be listed) to apply on the server listing request."
                            "items" = {
                              "minLength" = 1
                              "type" = "string"
                            }
                            "minItems" = 1
                            "type" = "array"
                            "x-kubernetes-list-type" = "set"
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig defines the TLS configuration to connect to the Scaleway API."
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
                          "zone" = {
                            "description" = "zone defines the availability zone of your targets (e.g. fr-par-1)."
                            "minLength" = 1
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "accessKey",
                          "projectID",
                          "role",
                          "secretKey",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "scheme" = {
                      "description" = "scheme defines the protocol scheme used for requests."
                      "enum" = [
                        "http",
                        "https",
                        "HTTP",
                        "HTTPS",
                      ]
                      "type" = "string"
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
                    "scrapeInterval" = {
                      "description" = "scrapeInterval defines the interval between consecutive scrapes."
                      "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                      "type" = "string"
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
                      "minItems" = 1
                      "type" = "array"
                      "x-kubernetes-list-type" = "set"
                    }
                    "scrapeTimeout" = {
                      "description" = <<-EOT
                      scrapeTimeout defines the number of seconds to wait until a scrape request times out.
                      The value cannot be greater than the scrape interval otherwise the operator will reject the resource.
                      EOT
                      "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                      "type" = "string"
                    }
                    "staticConfigs" = {
                      "description" = "staticConfigs defines a list of static targets with a common label set."
                      "items" = {
                        "description" = <<-EOT
                        StaticConfig defines a Prometheus static configuration.
                        See https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config
                        EOT
                        "properties" = {
                          "labels" = {
                            "additionalProperties" = {
                              "type" = "string"
                            }
                            "description" = "labels defines labels assigned to all metrics scraped from the targets."
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "targets" = {
                            "description" = "targets defines the list of targets for this static configuration."
                            "items" = {
                              "description" = "Target represents a target for Prometheus to scrape"
                              "minLength" = 1
                              "type" = "string"
                            }
                            "minItems" = 1
                            "type" = "array"
                            "x-kubernetes-list-type" = "set"
                          }
                        }
                        "required" = [
                          "targets",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "targetLimit" = {
                      "description" = "targetLimit defines a limit on the number of scraped targets that will be accepted."
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "tlsConfig" = {
                      "description" = "tlsConfig defines the TLS configuration to use on every scrape request"
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
                    "trackTimestampsStaleness" = {
                      "description" = <<-EOT
                      trackTimestampsStaleness defines whether Prometheus tracks staleness of
                      the metrics that have an explicit timestamp present in scraped data.
                      Has no effect if `honorTimestamps` is false.
                      It requires Prometheus >= v2.48.0.
                      EOT
                      "type" = "boolean"
                    }
                  }
                  "type" = "object"
                  "x-kubernetes-validations" = [
                    {
                      "message" = "at most one of basicAuth, authorization, or oauth2 can be configured"
                      "rule" = "[has(self.basicAuth), has(self.authorization), has(self.oauth2)].filter(x, x).size() <= 1"
                    },
                  ]
                }
                "status" = {
                  "description" = <<-EOT
                  status defines the status subresource. It is under active development and is updated only when the
                  "StatusForConfigurationResources" feature gate is enabled.
                  
                  Most recent observed status of the ScrapeConfig. Read-only.
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
