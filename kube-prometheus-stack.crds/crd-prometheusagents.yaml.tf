resource "kubernetes_manifest" "customresourcedefinition_prometheusagents_monitoring_coreos_com" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.22.0"
        "operator.prometheus.io/version" = "0.94.2"
      }
      "name" = "prometheusagents.monitoring.coreos.com"
    }
    "spec" = {
      "group" = "monitoring.coreos.com"
      "names" = {
        "categories" = [
          "prometheus-operator",
        ]
        "kind" = "PrometheusAgent"
        "listKind" = "PrometheusAgentList"
        "plural" = "prometheusagents"
        "shortNames" = [
          "promagent",
        ]
        "singular" = "prometheusagent"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "description" = "The version of Prometheus agent"
              "jsonPath" = ".spec.version"
              "name" = "Version"
              "type" = "string"
            },
            {
              "description" = "The number of desired replicas"
              "jsonPath" = ".spec.replicas"
              "name" = "Desired"
              "type" = "integer"
            },
            {
              "description" = "The number of ready replicas"
              "jsonPath" = ".status.availableReplicas"
              "name" = "Ready"
              "type" = "integer"
            },
            {
              "jsonPath" = ".status.conditions[?(@.type == 'Reconciled')].status"
              "name" = "Reconciled"
              "type" = "string"
            },
            {
              "jsonPath" = ".status.conditions[?(@.type == 'Available')].status"
              "name" = "Available"
              "type" = "string"
            },
            {
              "jsonPath" = ".metadata.creationTimestamp"
              "name" = "Age"
              "type" = "date"
            },
            {
              "description" = "Whether the resource reconciliation is paused or not"
              "jsonPath" = ".status.paused"
              "name" = "Paused"
              "priority" = 1
              "type" = "boolean"
            },
          ]
          "name" = "v1alpha1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = <<-EOT
              The `PrometheusAgent` custom resource definition (CRD) defines a desired [Prometheus Agent](https://prometheus.io/blog/2021/11/16/agent/) setup to run in a Kubernetes cluster.
              
              The CRD is very similar to the `Prometheus` CRD except for features which aren't available in agent mode like rule evaluation, persistent storage and Thanos sidecar.
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
                  "description" = <<-EOT
                  spec defines the specification of the desired behavior of the Prometheus agent. More info:
                  https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
                  EOT
                  "properties" = {
                    "additionalArgs" = {
                      "description" = <<-EOT
                      additionalArgs allows setting additional arguments for the 'prometheus' container.
                      
                      It is intended for e.g. activating hidden flags which are not supported by
                      the dedicated configuration options yet. The arguments are passed as-is to the
                      Prometheus container which may cause issues if they are invalid or not supported
                      by the given Prometheus version.
                      
                      In case of an argument conflict (e.g. an argument which is already set by the
                      operator itself) or when providing an invalid argument, the reconciliation will
                      fail and an error will be logged.
                      EOT
                      "items" = {
                        "description" = "Argument as part of the AdditionalArgs list."
                        "properties" = {
                          "name" = {
                            "description" = "name of the argument, e.g. \"scrape.discovery-reload-interval\"."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "value" = {
                            "description" = "value defines the argument value, e.g. 30s. Can be empty for name-only arguments (e.g. --storage.tsdb.no-lockfile)"
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "additionalScrapeConfigs" = {
                      "description" = <<-EOT
                      additionalScrapeConfigs allows specifying a key of a Secret containing
                      additional Prometheus scrape configurations. Scrape configurations
                      specified are appended to the configurations generated by the Prometheus
                      Operator. Job configurations specified must have the form as specified
                      in the official Prometheus documentation:
                      https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config.
                      As scrape configs are appended, the user is responsible to make sure it
                      is valid. Note that using this feature may expose the possibility to
                      break upgrades of Prometheus. It is advised to review Prometheus release
                      notes to ensure that no incompatible scrape configs are going to break
                      Prometheus after the upgrade.
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
                    "affinity" = {
                      "description" = "affinity defines the Pods' affinity scheduling rules if specified."
                      "properties" = {
                        "nodeAffinity" = {
                          "description" = "Describes node affinity scheduling rules for the pod."
                          "properties" = {
                            "preferredDuringSchedulingIgnoredDuringExecution" = {
                              "description" = <<-EOT
                              The scheduler will prefer to schedule pods to nodes that satisfy
                              the affinity expressions specified by this field, but it may choose
                              a node that violates one or more of the expressions. The node that is
                              most preferred is the one with the greatest sum of weights, i.e.
                              for each node that meets all of the scheduling requirements (resource
                              request, requiredDuringScheduling affinity expressions, etc.),
                              compute a sum by iterating through the elements of this field and adding
                              "weight" to the sum if the node matches the corresponding matchExpressions; the
                              node(s) with the highest sum are the most preferred.
                              EOT
                              "items" = {
                                "description" = <<-EOT
                                An empty preferred scheduling term matches all objects with implicit weight 0
                                (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op).
                                EOT
                                "properties" = {
                                  "preference" = {
                                    "description" = "A node selector term, associated with the corresponding weight."
                                    "properties" = {
                                      "matchExpressions" = {
                                        "description" = "A list of node selector requirements by node's labels."
                                        "items" = {
                                          "description" = <<-EOT
                                          A node selector requirement is a selector that contains values, a key, and an operator
                                          that relates the key and values.
                                          EOT
                                          "properties" = {
                                            "key" = {
                                              "description" = "The label key that the selector applies to."
                                              "type" = "string"
                                            }
                                            "operator" = {
                                              "description" = <<-EOT
                                              Represents a key's relationship to a set of values.
                                              Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
                                              EOT
                                              "type" = "string"
                                            }
                                            "values" = {
                                              "description" = <<-EOT
                                              An array of string values. If the operator is In or NotIn,
                                              the values array must be non-empty. If the operator is Exists or DoesNotExist,
                                              the values array must be empty. If the operator is Gt or Lt, the values
                                              array must have a single element, which will be interpreted as an integer.
                                              This array is replaced during a strategic merge patch.
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
                                      "matchFields" = {
                                        "description" = "A list of node selector requirements by node's fields."
                                        "items" = {
                                          "description" = <<-EOT
                                          A node selector requirement is a selector that contains values, a key, and an operator
                                          that relates the key and values.
                                          EOT
                                          "properties" = {
                                            "key" = {
                                              "description" = "The label key that the selector applies to."
                                              "type" = "string"
                                            }
                                            "operator" = {
                                              "description" = <<-EOT
                                              Represents a key's relationship to a set of values.
                                              Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
                                              EOT
                                              "type" = "string"
                                            }
                                            "values" = {
                                              "description" = <<-EOT
                                              An array of string values. If the operator is In or NotIn,
                                              the values array must be non-empty. If the operator is Exists or DoesNotExist,
                                              the values array must be empty. If the operator is Gt or Lt, the values
                                              array must have a single element, which will be interpreted as an integer.
                                              This array is replaced during a strategic merge patch.
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
                                    }
                                    "type" = "object"
                                    "x-kubernetes-map-type" = "atomic"
                                  }
                                  "weight" = {
                                    "description" = "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
                                    "format" = "int32"
                                    "type" = "integer"
                                  }
                                }
                                "required" = [
                                  "preference",
                                  "weight",
                                ]
                                "type" = "object"
                              }
                              "type" = "array"
                              "x-kubernetes-list-type" = "atomic"
                            }
                            "requiredDuringSchedulingIgnoredDuringExecution" = {
                              "description" = <<-EOT
                              If the affinity requirements specified by this field are not met at
                              scheduling time, the pod will not be scheduled onto the node.
                              If the affinity requirements specified by this field cease to be met
                              at some point during pod execution (e.g. due to an update), the system
                              may or may not try to eventually evict the pod from its node.
                              EOT
                              "properties" = {
                                "nodeSelectorTerms" = {
                                  "description" = "Required. A list of node selector terms. The terms are ORed."
                                  "items" = {
                                    "description" = <<-EOT
                                    A null or empty node selector term matches no objects. The requirements of
                                    them are ANDed.
                                    The TopologySelectorTerm type implements a subset of the NodeSelectorTerm.
                                    EOT
                                    "properties" = {
                                      "matchExpressions" = {
                                        "description" = "A list of node selector requirements by node's labels."
                                        "items" = {
                                          "description" = <<-EOT
                                          A node selector requirement is a selector that contains values, a key, and an operator
                                          that relates the key and values.
                                          EOT
                                          "properties" = {
                                            "key" = {
                                              "description" = "The label key that the selector applies to."
                                              "type" = "string"
                                            }
                                            "operator" = {
                                              "description" = <<-EOT
                                              Represents a key's relationship to a set of values.
                                              Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
                                              EOT
                                              "type" = "string"
                                            }
                                            "values" = {
                                              "description" = <<-EOT
                                              An array of string values. If the operator is In or NotIn,
                                              the values array must be non-empty. If the operator is Exists or DoesNotExist,
                                              the values array must be empty. If the operator is Gt or Lt, the values
                                              array must have a single element, which will be interpreted as an integer.
                                              This array is replaced during a strategic merge patch.
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
                                      "matchFields" = {
                                        "description" = "A list of node selector requirements by node's fields."
                                        "items" = {
                                          "description" = <<-EOT
                                          A node selector requirement is a selector that contains values, a key, and an operator
                                          that relates the key and values.
                                          EOT
                                          "properties" = {
                                            "key" = {
                                              "description" = "The label key that the selector applies to."
                                              "type" = "string"
                                            }
                                            "operator" = {
                                              "description" = <<-EOT
                                              Represents a key's relationship to a set of values.
                                              Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
                                              EOT
                                              "type" = "string"
                                            }
                                            "values" = {
                                              "description" = <<-EOT
                                              An array of string values. If the operator is In or NotIn,
                                              the values array must be non-empty. If the operator is Exists or DoesNotExist,
                                              the values array must be empty. If the operator is Gt or Lt, the values
                                              array must have a single element, which will be interpreted as an integer.
                                              This array is replaced during a strategic merge patch.
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
                                    }
                                    "type" = "object"
                                    "x-kubernetes-map-type" = "atomic"
                                  }
                                  "type" = "array"
                                  "x-kubernetes-list-type" = "atomic"
                                }
                              }
                              "required" = [
                                "nodeSelectorTerms",
                              ]
                              "type" = "object"
                              "x-kubernetes-map-type" = "atomic"
                            }
                          }
                          "type" = "object"
                        }
                        "podAffinity" = {
                          "description" = "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
                          "properties" = {
                            "preferredDuringSchedulingIgnoredDuringExecution" = {
                              "description" = <<-EOT
                              The scheduler will prefer to schedule pods to nodes that satisfy
                              the affinity expressions specified by this field, but it may choose
                              a node that violates one or more of the expressions. The node that is
                              most preferred is the one with the greatest sum of weights, i.e.
                              for each node that meets all of the scheduling requirements (resource
                              request, requiredDuringScheduling affinity expressions, etc.),
                              compute a sum by iterating through the elements of this field and adding
                              "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the
                              node(s) with the highest sum are the most preferred.
                              EOT
                              "items" = {
                                "description" = "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
                                "properties" = {
                                  "podAffinityTerm" = {
                                    "description" = "Required. A pod affinity term, associated with the corresponding weight."
                                    "properties" = {
                                      "labelSelector" = {
                                        "description" = <<-EOT
                                        A label query over a set of resources, in this case pods.
                                        If it's null, this PodAffinityTerm matches with no Pods.
                                        EOT
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
                                      "matchLabelKeys" = {
                                        "description" = <<-EOT
                                        MatchLabelKeys is a set of pod label keys to select which pods will
                                        be taken into consideration. The keys are used to lookup values from the
                                        incoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`
                                        to select the group of existing pods which pods will be taken into consideration
                                        for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
                                        pod labels will be ignored. The default value is empty.
                                        The same key is forbidden to exist in both matchLabelKeys and labelSelector.
                                        Also, matchLabelKeys cannot be set when labelSelector isn't set.
                                        EOT
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                      "mismatchLabelKeys" = {
                                        "description" = <<-EOT
                                        MismatchLabelKeys is a set of pod label keys to select which pods will
                                        be taken into consideration. The keys are used to lookup values from the
                                        incoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`
                                        to select the group of existing pods which pods will be taken into consideration
                                        for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
                                        pod labels will be ignored. The default value is empty.
                                        The same key is forbidden to exist in both mismatchLabelKeys and labelSelector.
                                        Also, mismatchLabelKeys cannot be set when labelSelector isn't set.
                                        EOT
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                      "namespaceSelector" = {
                                        "description" = <<-EOT
                                        A label query over the set of namespaces that the term applies to.
                                        The term is applied to the union of the namespaces selected by this field
                                        and the ones listed in the namespaces field.
                                        null selector and null or empty namespaces list means "this pod's namespace".
                                        An empty selector ({}) matches all namespaces.
                                        EOT
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
                                      "namespaces" = {
                                        "description" = <<-EOT
                                        namespaces specifies a static list of namespace names that the term applies to.
                                        The term is applied to the union of the namespaces listed in this field
                                        and the ones selected by namespaceSelector.
                                        null or empty namespaces list and null namespaceSelector means "this pod's namespace".
                                        EOT
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                      "topologyKey" = {
                                        "description" = <<-EOT
                                        This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching
                                        the labelSelector in the specified namespaces, where co-located is defined as running on a node
                                        whose value of the label with key topologyKey matches that of any node on which any of the
                                        selected pods is running.
                                        Empty topologyKey is not allowed.
                                        EOT
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "topologyKey",
                                    ]
                                    "type" = "object"
                                  }
                                  "weight" = {
                                    "description" = <<-EOT
                                    weight associated with matching the corresponding podAffinityTerm,
                                    in the range 1-100.
                                    EOT
                                    "format" = "int32"
                                    "type" = "integer"
                                  }
                                }
                                "required" = [
                                  "podAffinityTerm",
                                  "weight",
                                ]
                                "type" = "object"
                              }
                              "type" = "array"
                              "x-kubernetes-list-type" = "atomic"
                            }
                            "requiredDuringSchedulingIgnoredDuringExecution" = {
                              "description" = <<-EOT
                              If the affinity requirements specified by this field are not met at
                              scheduling time, the pod will not be scheduled onto the node.
                              If the affinity requirements specified by this field cease to be met
                              at some point during pod execution (e.g. due to a pod label update), the
                              system may or may not try to eventually evict the pod from its node.
                              When there are multiple elements, the lists of nodes corresponding to each
                              podAffinityTerm are intersected, i.e. all terms must be satisfied.
                              EOT
                              "items" = {
                                "description" = <<-EOT
                                Defines a set of pods (namely those matching the labelSelector
                                relative to the given namespace(s)) that this pod should be
                                co-located (affinity) or not co-located (anti-affinity) with,
                                where co-located is defined as running on a node whose value of
                                the label with key <topologyKey> matches that of any node on which
                                a pod of the set of pods is running
                                EOT
                                "properties" = {
                                  "labelSelector" = {
                                    "description" = <<-EOT
                                    A label query over a set of resources, in this case pods.
                                    If it's null, this PodAffinityTerm matches with no Pods.
                                    EOT
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
                                  "matchLabelKeys" = {
                                    "description" = <<-EOT
                                    MatchLabelKeys is a set of pod label keys to select which pods will
                                    be taken into consideration. The keys are used to lookup values from the
                                    incoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`
                                    to select the group of existing pods which pods will be taken into consideration
                                    for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
                                    pod labels will be ignored. The default value is empty.
                                    The same key is forbidden to exist in both matchLabelKeys and labelSelector.
                                    Also, matchLabelKeys cannot be set when labelSelector isn't set.
                                    EOT
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "mismatchLabelKeys" = {
                                    "description" = <<-EOT
                                    MismatchLabelKeys is a set of pod label keys to select which pods will
                                    be taken into consideration. The keys are used to lookup values from the
                                    incoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`
                                    to select the group of existing pods which pods will be taken into consideration
                                    for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
                                    pod labels will be ignored. The default value is empty.
                                    The same key is forbidden to exist in both mismatchLabelKeys and labelSelector.
                                    Also, mismatchLabelKeys cannot be set when labelSelector isn't set.
                                    EOT
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "namespaceSelector" = {
                                    "description" = <<-EOT
                                    A label query over the set of namespaces that the term applies to.
                                    The term is applied to the union of the namespaces selected by this field
                                    and the ones listed in the namespaces field.
                                    null selector and null or empty namespaces list means "this pod's namespace".
                                    An empty selector ({}) matches all namespaces.
                                    EOT
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
                                  "namespaces" = {
                                    "description" = <<-EOT
                                    namespaces specifies a static list of namespace names that the term applies to.
                                    The term is applied to the union of the namespaces listed in this field
                                    and the ones selected by namespaceSelector.
                                    null or empty namespaces list and null namespaceSelector means "this pod's namespace".
                                    EOT
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "topologyKey" = {
                                    "description" = <<-EOT
                                    This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching
                                    the labelSelector in the specified namespaces, where co-located is defined as running on a node
                                    whose value of the label with key topologyKey matches that of any node on which any of the
                                    selected pods is running.
                                    Empty topologyKey is not allowed.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "topologyKey",
                                ]
                                "type" = "object"
                              }
                              "type" = "array"
                              "x-kubernetes-list-type" = "atomic"
                            }
                          }
                          "type" = "object"
                        }
                        "podAntiAffinity" = {
                          "description" = "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
                          "properties" = {
                            "preferredDuringSchedulingIgnoredDuringExecution" = {
                              "description" = <<-EOT
                              The scheduler will prefer to schedule pods to nodes that satisfy
                              the anti-affinity expressions specified by this field, but it may choose
                              a node that violates one or more of the expressions. The node that is
                              most preferred is the one with the greatest sum of weights, i.e.
                              for each node that meets all of the scheduling requirements (resource
                              request, requiredDuringScheduling anti-affinity expressions, etc.),
                              compute a sum by iterating through the elements of this field and subtracting
                              "weight" from the sum if the node has pods which matches the corresponding podAffinityTerm; the
                              node(s) with the highest sum are the most preferred.
                              EOT
                              "items" = {
                                "description" = "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
                                "properties" = {
                                  "podAffinityTerm" = {
                                    "description" = "Required. A pod affinity term, associated with the corresponding weight."
                                    "properties" = {
                                      "labelSelector" = {
                                        "description" = <<-EOT
                                        A label query over a set of resources, in this case pods.
                                        If it's null, this PodAffinityTerm matches with no Pods.
                                        EOT
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
                                      "matchLabelKeys" = {
                                        "description" = <<-EOT
                                        MatchLabelKeys is a set of pod label keys to select which pods will
                                        be taken into consideration. The keys are used to lookup values from the
                                        incoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`
                                        to select the group of existing pods which pods will be taken into consideration
                                        for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
                                        pod labels will be ignored. The default value is empty.
                                        The same key is forbidden to exist in both matchLabelKeys and labelSelector.
                                        Also, matchLabelKeys cannot be set when labelSelector isn't set.
                                        EOT
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                      "mismatchLabelKeys" = {
                                        "description" = <<-EOT
                                        MismatchLabelKeys is a set of pod label keys to select which pods will
                                        be taken into consideration. The keys are used to lookup values from the
                                        incoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`
                                        to select the group of existing pods which pods will be taken into consideration
                                        for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
                                        pod labels will be ignored. The default value is empty.
                                        The same key is forbidden to exist in both mismatchLabelKeys and labelSelector.
                                        Also, mismatchLabelKeys cannot be set when labelSelector isn't set.
                                        EOT
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                      "namespaceSelector" = {
                                        "description" = <<-EOT
                                        A label query over the set of namespaces that the term applies to.
                                        The term is applied to the union of the namespaces selected by this field
                                        and the ones listed in the namespaces field.
                                        null selector and null or empty namespaces list means "this pod's namespace".
                                        An empty selector ({}) matches all namespaces.
                                        EOT
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
                                      "namespaces" = {
                                        "description" = <<-EOT
                                        namespaces specifies a static list of namespace names that the term applies to.
                                        The term is applied to the union of the namespaces listed in this field
                                        and the ones selected by namespaceSelector.
                                        null or empty namespaces list and null namespaceSelector means "this pod's namespace".
                                        EOT
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                      "topologyKey" = {
                                        "description" = <<-EOT
                                        This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching
                                        the labelSelector in the specified namespaces, where co-located is defined as running on a node
                                        whose value of the label with key topologyKey matches that of any node on which any of the
                                        selected pods is running.
                                        Empty topologyKey is not allowed.
                                        EOT
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "topologyKey",
                                    ]
                                    "type" = "object"
                                  }
                                  "weight" = {
                                    "description" = <<-EOT
                                    weight associated with matching the corresponding podAffinityTerm,
                                    in the range 1-100.
                                    EOT
                                    "format" = "int32"
                                    "type" = "integer"
                                  }
                                }
                                "required" = [
                                  "podAffinityTerm",
                                  "weight",
                                ]
                                "type" = "object"
                              }
                              "type" = "array"
                              "x-kubernetes-list-type" = "atomic"
                            }
                            "requiredDuringSchedulingIgnoredDuringExecution" = {
                              "description" = <<-EOT
                              If the anti-affinity requirements specified by this field are not met at
                              scheduling time, the pod will not be scheduled onto the node.
                              If the anti-affinity requirements specified by this field cease to be met
                              at some point during pod execution (e.g. due to a pod label update), the
                              system may or may not try to eventually evict the pod from its node.
                              When there are multiple elements, the lists of nodes corresponding to each
                              podAffinityTerm are intersected, i.e. all terms must be satisfied.
                              EOT
                              "items" = {
                                "description" = <<-EOT
                                Defines a set of pods (namely those matching the labelSelector
                                relative to the given namespace(s)) that this pod should be
                                co-located (affinity) or not co-located (anti-affinity) with,
                                where co-located is defined as running on a node whose value of
                                the label with key <topologyKey> matches that of any node on which
                                a pod of the set of pods is running
                                EOT
                                "properties" = {
                                  "labelSelector" = {
                                    "description" = <<-EOT
                                    A label query over a set of resources, in this case pods.
                                    If it's null, this PodAffinityTerm matches with no Pods.
                                    EOT
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
                                  "matchLabelKeys" = {
                                    "description" = <<-EOT
                                    MatchLabelKeys is a set of pod label keys to select which pods will
                                    be taken into consideration. The keys are used to lookup values from the
                                    incoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`
                                    to select the group of existing pods which pods will be taken into consideration
                                    for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
                                    pod labels will be ignored. The default value is empty.
                                    The same key is forbidden to exist in both matchLabelKeys and labelSelector.
                                    Also, matchLabelKeys cannot be set when labelSelector isn't set.
                                    EOT
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "mismatchLabelKeys" = {
                                    "description" = <<-EOT
                                    MismatchLabelKeys is a set of pod label keys to select which pods will
                                    be taken into consideration. The keys are used to lookup values from the
                                    incoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`
                                    to select the group of existing pods which pods will be taken into consideration
                                    for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
                                    pod labels will be ignored. The default value is empty.
                                    The same key is forbidden to exist in both mismatchLabelKeys and labelSelector.
                                    Also, mismatchLabelKeys cannot be set when labelSelector isn't set.
                                    EOT
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "namespaceSelector" = {
                                    "description" = <<-EOT
                                    A label query over the set of namespaces that the term applies to.
                                    The term is applied to the union of the namespaces selected by this field
                                    and the ones listed in the namespaces field.
                                    null selector and null or empty namespaces list means "this pod's namespace".
                                    An empty selector ({}) matches all namespaces.
                                    EOT
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
                                  "namespaces" = {
                                    "description" = <<-EOT
                                    namespaces specifies a static list of namespace names that the term applies to.
                                    The term is applied to the union of the namespaces listed in this field
                                    and the ones selected by namespaceSelector.
                                    null or empty namespaces list and null namespaceSelector means "this pod's namespace".
                                    EOT
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "topologyKey" = {
                                    "description" = <<-EOT
                                    This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching
                                    the labelSelector in the specified namespaces, where co-located is defined as running on a node
                                    whose value of the label with key topologyKey matches that of any node on which any of the
                                    selected pods is running.
                                    Empty topologyKey is not allowed.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "topologyKey",
                                ]
                                "type" = "object"
                              }
                              "type" = "array"
                              "x-kubernetes-list-type" = "atomic"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "apiserverConfig" = {
                      "description" = <<-EOT
                      apiserverConfig allows specifying a host and auth methods to access the
                      Kuberntees API server.
                      If null, Prometheus is assumed to run inside of the cluster: it will
                      discover the API servers automatically and use the Pod's CA certificate
                      and bearer token file at /var/run/secrets/kubernetes.io/serviceaccount/.
                      EOT
                      "properties" = {
                        "authorization" = {
                          "description" = <<-EOT
                          authorization section for the API server.
                          
                          Cannot be set at the same time as `basicAuth`, `bearerToken`, or
                          `bearerTokenFile`.
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
                            "credentialsFile" = {
                              "description" = "credentialsFile defines the file to read a secret from, mutually exclusive with `credentials`."
                              "type" = "string"
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
                          basicAuth configuration for the API server.
                          
                          Cannot be set at the same time as `authorization`, `bearerToken`, or
                          `bearerTokenFile`.
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
                        "bearerToken" = {
                          "description" = <<-EOT
                          bearerToken is deprecated: this will be removed in a future release.
                           *Warning: this field shouldn't be used because the token value appears
                          in clear-text. Prefer using `authorization`.*
                          EOT
                          "type" = "string"
                        }
                        "bearerTokenFile" = {
                          "description" = <<-EOT
                          bearerTokenFile defines the file to read bearer token for accessing apiserver.
                          
                          Cannot be set at the same time as `basicAuth`, `authorization`, or `bearerToken`.
                          
                          Deprecated: this will be removed in a future release. Prefer using `authorization`.
                          EOT
                          "type" = "string"
                        }
                        "host" = {
                          "description" = <<-EOT
                          host defines the Kubernetes API address consisting of a hostname or IP address followed
                          by an optional port number.
                          EOT
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
                        "tlsConfig" = {
                          "description" = "tlsConfig to use for the API server."
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
                            "caFile" = {
                              "description" = "caFile defines the path to the CA cert in the Prometheus container to use for the targets."
                              "type" = "string"
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
                            "certFile" = {
                              "description" = "certFile defines the path to the client cert file in the Prometheus container for the targets."
                              "type" = "string"
                            }
                            "insecureSkipVerify" = {
                              "description" = "insecureSkipVerify defines how to disable target certificate validation."
                              "type" = "boolean"
                            }
                            "keyFile" = {
                              "description" = "keyFile defines the path to the client key file in the Prometheus container for the targets."
                              "type" = "string"
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
                    "arbitraryFSAccessThroughSMs" = {
                      "description" = <<-EOT
                      arbitraryFSAccessThroughSMs when true, ServiceMonitor, PodMonitor and Probe object are forbidden to
                      reference arbitrary files on the file system of the 'prometheus'
                      container.
                      When a ServiceMonitor's endpoint specifies a `bearerTokenFile` value
                      (e.g.  '/var/run/secrets/kubernetes.io/serviceaccount/token'), a
                      malicious target can get access to the Prometheus service account's
                      token in the Prometheus' scrape request. Setting
                      `spec.arbitraryFSAccessThroughSM` to 'true' would prevent the attack.
                      Users should instead provide the credentials using the
                      `spec.bearerTokenSecret` field.
                      EOT
                      "properties" = {
                        "deny" = {
                          "description" = <<-EOT
                          deny prevents service monitors from accessing arbitrary files on the file system.
                          When true, service monitors cannot use file-based configurations like BearerTokenFile
                          that could potentially access sensitive files. When false (default), such access is allowed.
                          Setting this to true enhances security by preventing potential credential theft attacks.
                          EOT
                          "type" = "boolean"
                        }
                      }
                      "type" = "object"
                    }
                    "automountServiceAccountToken" = {
                      "description" = <<-EOT
                      automountServiceAccountToken defines whether a service account token should be automatically mounted in the pod.
                      If the field isn't set, the operator mounts the service account token by default.
                      
                      **Warning:** be aware that by default, Prometheus requires the service account token for Kubernetes service discovery.
                      It is possible to use strategic merge patch to project the service account token into the 'prometheus' container.
                      EOT
                      "type" = "boolean"
                    }
                    "bodySizeLimit" = {
                      "description" = <<-EOT
                      bodySizeLimit defines per-scrape on response body size.
                      Only valid in Prometheus versions 2.45.0 and newer.
                      
                      Note that the global limit only applies to scrape objects that don't specify an explicit limit value.
                      If you want to enforce a maximum limit for all scrape objects, refer to enforcedBodySizeLimit.
                      EOT
                      "pattern" = "(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
                      "type" = "string"
                    }
                    "configMaps" = {
                      "description" = <<-EOT
                      configMaps defines a list of ConfigMaps in the same namespace as the Prometheus
                      object, which shall be mounted into the Prometheus Pods.
                      Each ConfigMap is added to the StatefulSet definition as a volume named `configmap-<configmap-name>`.
                      The ConfigMaps are mounted into /etc/prometheus/configmaps/<configmap-name> in the 'prometheus' container.
                      EOT
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "containers" = {
                      "description" = <<-EOT
                      containers allows injecting additional containers or modifying operator
                      generated containers. This can be used to allow adding an authentication
                      proxy to the Pods or to change the behavior of an operator generated
                      container. Containers described here modify an operator generated
                      container if they share the same name and modifications are done via a
                      strategic merge patch.
                      
                      The names of containers managed by the operator are:
                      * `prometheus`
                      * `config-reloader`
                      * `thanos-sidecar`
                      
                      Overriding containers which are managed by the operator require careful
                      testing, especially when upgrading to a new version of the operator.
                      EOT
                      "items" = {
                        "description" = "A single application container that you want to run within a pod."
                        "properties" = {
                          "args" = {
                            "description" = <<-EOT
                            Arguments to the entrypoint.
                            The container image's CMD is used if this is not provided.
                            Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
                            cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
                            to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
                            produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
                            of whether the variable exists or not. Cannot be updated.
                            More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
                            EOT
                            "items" = {
                              "type" = "string"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "command" = {
                            "description" = <<-EOT
                            Entrypoint array. Not executed within a shell.
                            The container image's ENTRYPOINT is used if this is not provided.
                            Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
                            cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
                            to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
                            produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
                            of whether the variable exists or not. Cannot be updated.
                            More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
                            EOT
                            "items" = {
                              "type" = "string"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "env" = {
                            "description" = <<-EOT
                            List of environment variables to set in the container.
                            Cannot be updated.
                            EOT
                            "items" = {
                              "description" = "EnvVar represents an environment variable present in a Container."
                              "properties" = {
                                "name" = {
                                  "description" = <<-EOT
                                  Name of the environment variable.
                                  May consist of any printable ASCII characters except '='.
                                  EOT
                                  "type" = "string"
                                }
                                "value" = {
                                  "description" = <<-EOT
                                  Variable references $(VAR_NAME) are expanded
                                  using the previously defined environment variables in the container and
                                  any service environment variables. If a variable cannot be resolved,
                                  the reference in the input string will be unchanged. Double $$ are reduced
                                  to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.
                                  "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)".
                                  Escaped references will never be expanded, regardless of whether the variable
                                  exists or not.
                                  Defaults to "".
                                  EOT
                                  "type" = "string"
                                }
                                "valueFrom" = {
                                  "description" = "Source for the environment variable's value. Cannot be used if value is not empty."
                                  "properties" = {
                                    "configMapKeyRef" = {
                                      "description" = "Selects a key of a ConfigMap."
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
                                    "fieldRef" = {
                                      "description" = <<-EOT
                                      Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,
                                      spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.
                                      EOT
                                      "properties" = {
                                        "apiVersion" = {
                                          "description" = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
                                          "type" = "string"
                                        }
                                        "fieldPath" = {
                                          "description" = "Path of the field to select in the specified API version."
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "fieldPath",
                                      ]
                                      "type" = "object"
                                      "x-kubernetes-map-type" = "atomic"
                                    }
                                    "fileKeyRef" = {
                                      "description" = <<-EOT
                                      FileKeyRef selects a key of the env file.
                                      Requires the EnvFiles feature gate to be enabled.
                                      EOT
                                      "properties" = {
                                        "key" = {
                                          "description" = <<-EOT
                                          The key within the env file. An invalid key will prevent the pod from starting.
                                          The keys defined within a source may consist of any printable ASCII characters except '='.
                                          During Alpha stage of the EnvFiles feature gate, the key size is limited to 128 characters.
                                          EOT
                                          "type" = "string"
                                        }
                                        "optional" = {
                                          "default" = false
                                          "description" = <<-EOT
                                          Specify whether the file or its key must be defined. If the file or key
                                          does not exist, then the env var is not published.
                                          If optional is set to true and the specified key does not exist,
                                          the environment variable will not be set in the Pod's containers.
                                          
                                          If optional is set to false and the specified key does not exist,
                                          an error will be returned during Pod creation.
                                          EOT
                                          "type" = "boolean"
                                        }
                                        "path" = {
                                          "description" = <<-EOT
                                          The path within the volume from which to select the file.
                                          Must be relative and may not contain the '..' path or start with '..'.
                                          EOT
                                          "type" = "string"
                                        }
                                        "volumeName" = {
                                          "description" = "The name of the volume mount containing the env file."
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "key",
                                        "path",
                                        "volumeName",
                                      ]
                                      "type" = "object"
                                      "x-kubernetes-map-type" = "atomic"
                                    }
                                    "resourceFieldRef" = {
                                      "description" = <<-EOT
                                      Selects a resource of the container: only resources limits and requests
                                      (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.
                                      EOT
                                      "properties" = {
                                        "containerName" = {
                                          "description" = "Container name: required for volumes, optional for env vars"
                                          "type" = "string"
                                        }
                                        "divisor" = {
                                          "anyOf" = [
                                            {
                                              "type" = "integer"
                                            },
                                            {
                                              "type" = "string"
                                            },
                                          ]
                                          "description" = "Specifies the output format of the exposed resources, defaults to \"1\""
                                          "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                          "x-kubernetes-int-or-string" = true
                                        }
                                        "resource" = {
                                          "description" = "Required: resource to select"
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "resource",
                                      ]
                                      "type" = "object"
                                      "x-kubernetes-map-type" = "atomic"
                                    }
                                    "secretKeyRef" = {
                                      "description" = "Selects a key of a secret in the pod's namespace"
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
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "name",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "envFrom" = {
                            "description" = <<-EOT
                            List of sources to populate environment variables in the container.
                            The keys defined within a source may consist of any printable ASCII characters except '='.
                            When a key exists in multiple
                            sources, the value associated with the last source will take precedence.
                            Values defined by an Env with a duplicate key will take precedence.
                            Cannot be updated.
                            EOT
                            "items" = {
                              "description" = "EnvFromSource represents the source of a set of ConfigMaps or Secrets"
                              "properties" = {
                                "configMapRef" = {
                                  "description" = "The ConfigMap to select from"
                                  "properties" = {
                                    "name" = {
                                      "default" = ""
                                      "description" = <<-EOT
                                      Name of the referent.
                                      This field is effectively required, but due to backwards compatibility is
                                      allowed to be empty. Instances of this type with an empty value here are
                                      almost certainly wrong.
                                      More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                      EOT
                                      "type" = "string"
                                    }
                                    "optional" = {
                                      "description" = "Specify whether the ConfigMap must be defined"
                                      "type" = "boolean"
                                    }
                                  }
                                  "type" = "object"
                                  "x-kubernetes-map-type" = "atomic"
                                }
                                "prefix" = {
                                  "description" = <<-EOT
                                  Optional text to prepend to the name of each environment variable.
                                  May consist of any printable ASCII characters except '='.
                                  EOT
                                  "type" = "string"
                                }
                                "secretRef" = {
                                  "description" = "The Secret to select from"
                                  "properties" = {
                                    "name" = {
                                      "default" = ""
                                      "description" = <<-EOT
                                      Name of the referent.
                                      This field is effectively required, but due to backwards compatibility is
                                      allowed to be empty. Instances of this type with an empty value here are
                                      almost certainly wrong.
                                      More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                      EOT
                                      "type" = "string"
                                    }
                                    "optional" = {
                                      "description" = "Specify whether the Secret must be defined"
                                      "type" = "boolean"
                                    }
                                  }
                                  "type" = "object"
                                  "x-kubernetes-map-type" = "atomic"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "image" = {
                            "description" = <<-EOT
                            Container image name.
                            More info: https://kubernetes.io/docs/concepts/containers/images
                            This field is optional to allow higher level config management to default or override
                            container images in workload controllers like Deployments and StatefulSets.
                            EOT
                            "type" = "string"
                          }
                          "imagePullPolicy" = {
                            "description" = <<-EOT
                            Image pull policy.
                            One of Always, Never, IfNotPresent.
                            Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
                            Cannot be updated.
                            More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
                            EOT
                            "type" = "string"
                          }
                          "lifecycle" = {
                            "description" = <<-EOT
                            Actions that the management system should take in response to container lifecycle events.
                            Cannot be updated.
                            EOT
                            "properties" = {
                              "postStart" = {
                                "description" = <<-EOT
                                PostStart is called immediately after a container is created. If the handler fails,
                                the container is terminated and restarted according to its restart policy.
                                Other management of the container blocks until the hook completes.
                                More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
                                EOT
                                "properties" = {
                                  "exec" = {
                                    "description" = "Exec specifies a command to execute in the container."
                                    "properties" = {
                                      "command" = {
                                        "description" = <<-EOT
                                        Command is the command line to execute inside the container, the working directory for the
                                        command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
                                        not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
                                        a shell, you need to explicitly call out to that shell.
                                        Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
                                        EOT
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "httpGet" = {
                                    "description" = "HTTPGet specifies an HTTP GET request to perform."
                                    "properties" = {
                                      "host" = {
                                        "description" = <<-EOT
                                        Host name to connect to, defaults to the pod IP. You probably want to set
                                        "Host" in httpHeaders instead.
                                        EOT
                                        "type" = "string"
                                      }
                                      "httpHeaders" = {
                                        "description" = "Custom headers to set in the request. HTTP allows repeated headers."
                                        "items" = {
                                          "description" = "HTTPHeader describes a custom header to be used in HTTP probes"
                                          "properties" = {
                                            "name" = {
                                              "description" = <<-EOT
                                              The header field name.
                                              This will be canonicalized upon output, so case-variant names will be understood as the same header.
                                              EOT
                                              "type" = "string"
                                            }
                                            "value" = {
                                              "description" = "The header field value"
                                              "type" = "string"
                                            }
                                          }
                                          "required" = [
                                            "name",
                                            "value",
                                          ]
                                          "type" = "object"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                      "path" = {
                                        "description" = "Path to access on the HTTP server."
                                        "type" = "string"
                                      }
                                      "port" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "description" = <<-EOT
                                        Name or number of the port to access on the container.
                                        Number must be in the range 1 to 65535.
                                        Name must be an IANA_SVC_NAME.
                                        EOT
                                        "x-kubernetes-int-or-string" = true
                                      }
                                      "protocol" = {
                                        "description" = <<-EOT
                                        Protocol selects the wire protocol for the probe connection.
                                        Nil defaults to HTTP/1.1.
                                        EOT
                                        "type" = "string"
                                      }
                                      "scheme" = {
                                        "description" = <<-EOT
                                        Scheme to use for connecting to the host.
                                        Defaults to HTTP.
                                        EOT
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "port",
                                    ]
                                    "type" = "object"
                                  }
                                  "sleep" = {
                                    "description" = "Sleep represents a duration that the container should sleep."
                                    "properties" = {
                                      "seconds" = {
                                        "description" = "Seconds is the number of seconds to sleep."
                                        "format" = "int64"
                                        "type" = "integer"
                                      }
                                    }
                                    "required" = [
                                      "seconds",
                                    ]
                                    "type" = "object"
                                  }
                                  "tcpSocket" = {
                                    "description" = <<-EOT
                                    Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept
                                    for backward compatibility. There is no validation of this field and
                                    lifecycle hooks will fail at runtime when it is specified.
                                    EOT
                                    "properties" = {
                                      "host" = {
                                        "description" = "Optional: Host name to connect to, defaults to the pod IP."
                                        "type" = "string"
                                      }
                                      "port" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "description" = <<-EOT
                                        Number or name of the port to access on the container.
                                        Number must be in the range 1 to 65535.
                                        Name must be an IANA_SVC_NAME.
                                        EOT
                                        "x-kubernetes-int-or-string" = true
                                      }
                                    }
                                    "required" = [
                                      "port",
                                    ]
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                              "preStop" = {
                                "description" = <<-EOT
                                PreStop is called immediately before a container is terminated due to an
                                API request or management event such as liveness/startup probe failure,
                                preemption, resource contention, etc. The handler is not called if the
                                container crashes or exits. The Pod's termination grace period countdown begins before the
                                PreStop hook is executed. Regardless of the outcome of the handler, the
                                container will eventually terminate within the Pod's termination grace
                                period (unless delayed by finalizers). Other management of the container blocks until the hook completes
                                or until the termination grace period is reached.
                                More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
                                EOT
                                "properties" = {
                                  "exec" = {
                                    "description" = "Exec specifies a command to execute in the container."
                                    "properties" = {
                                      "command" = {
                                        "description" = <<-EOT
                                        Command is the command line to execute inside the container, the working directory for the
                                        command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
                                        not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
                                        a shell, you need to explicitly call out to that shell.
                                        Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
                                        EOT
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "httpGet" = {
                                    "description" = "HTTPGet specifies an HTTP GET request to perform."
                                    "properties" = {
                                      "host" = {
                                        "description" = <<-EOT
                                        Host name to connect to, defaults to the pod IP. You probably want to set
                                        "Host" in httpHeaders instead.
                                        EOT
                                        "type" = "string"
                                      }
                                      "httpHeaders" = {
                                        "description" = "Custom headers to set in the request. HTTP allows repeated headers."
                                        "items" = {
                                          "description" = "HTTPHeader describes a custom header to be used in HTTP probes"
                                          "properties" = {
                                            "name" = {
                                              "description" = <<-EOT
                                              The header field name.
                                              This will be canonicalized upon output, so case-variant names will be understood as the same header.
                                              EOT
                                              "type" = "string"
                                            }
                                            "value" = {
                                              "description" = "The header field value"
                                              "type" = "string"
                                            }
                                          }
                                          "required" = [
                                            "name",
                                            "value",
                                          ]
                                          "type" = "object"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                      "path" = {
                                        "description" = "Path to access on the HTTP server."
                                        "type" = "string"
                                      }
                                      "port" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "description" = <<-EOT
                                        Name or number of the port to access on the container.
                                        Number must be in the range 1 to 65535.
                                        Name must be an IANA_SVC_NAME.
                                        EOT
                                        "x-kubernetes-int-or-string" = true
                                      }
                                      "protocol" = {
                                        "description" = <<-EOT
                                        Protocol selects the wire protocol for the probe connection.
                                        Nil defaults to HTTP/1.1.
                                        EOT
                                        "type" = "string"
                                      }
                                      "scheme" = {
                                        "description" = <<-EOT
                                        Scheme to use for connecting to the host.
                                        Defaults to HTTP.
                                        EOT
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "port",
                                    ]
                                    "type" = "object"
                                  }
                                  "sleep" = {
                                    "description" = "Sleep represents a duration that the container should sleep."
                                    "properties" = {
                                      "seconds" = {
                                        "description" = "Seconds is the number of seconds to sleep."
                                        "format" = "int64"
                                        "type" = "integer"
                                      }
                                    }
                                    "required" = [
                                      "seconds",
                                    ]
                                    "type" = "object"
                                  }
                                  "tcpSocket" = {
                                    "description" = <<-EOT
                                    Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept
                                    for backward compatibility. There is no validation of this field and
                                    lifecycle hooks will fail at runtime when it is specified.
                                    EOT
                                    "properties" = {
                                      "host" = {
                                        "description" = "Optional: Host name to connect to, defaults to the pod IP."
                                        "type" = "string"
                                      }
                                      "port" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "description" = <<-EOT
                                        Number or name of the port to access on the container.
                                        Number must be in the range 1 to 65535.
                                        Name must be an IANA_SVC_NAME.
                                        EOT
                                        "x-kubernetes-int-or-string" = true
                                      }
                                    }
                                    "required" = [
                                      "port",
                                    ]
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                              "stopSignal" = {
                                "description" = <<-EOT
                                StopSignal defines which signal will be sent to a container when it is being stopped.
                                If not specified, the default is defined by the container runtime in use.
                                StopSignal can only be set for Pods with a non-empty .spec.os.name
                                EOT
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "livenessProbe" = {
                            "description" = <<-EOT
                            Periodic probe of container liveness.
                            Container will be restarted if the probe fails.
                            Cannot be updated.
                            More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                            EOT
                            "properties" = {
                              "exec" = {
                                "description" = "Exec specifies a command to execute in the container."
                                "properties" = {
                                  "command" = {
                                    "description" = <<-EOT
                                    Command is the command line to execute inside the container, the working directory for the
                                    command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
                                    not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
                                    a shell, you need to explicitly call out to that shell.
                                    Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
                                    EOT
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                }
                                "type" = "object"
                              }
                              "failureThreshold" = {
                                "description" = <<-EOT
                                Minimum consecutive failures for the probe to be considered failed after having succeeded.
                                Defaults to 3. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "grpc" = {
                                "description" = "GRPC specifies a GRPC HealthCheckRequest."
                                "properties" = {
                                  "mode" = {
                                    "description" = <<-EOT
                                    mode specifies the connection mode for the gRPC health probe.
                                    Set to "TLS" to use TLS without certificate verification.
                                    Set to "Plaintext" to use a plaintext (insecure) connection explicitly.
                                    If not specified, the probe uses a plaintext (insecure) connection.
                                    EOT
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "description" = "Port number of the gRPC service. Number must be in the range 1 to 65535."
                                    "format" = "int32"
                                    "type" = "integer"
                                  }
                                  "service" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Service is the name of the service to place in the gRPC HealthCheckRequest
                                    (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
                                    
                                    If this is not specified, the default behavior is defined by gRPC.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "httpGet" = {
                                "description" = "HTTPGet specifies an HTTP GET request to perform."
                                "properties" = {
                                  "host" = {
                                    "description" = <<-EOT
                                    Host name to connect to, defaults to the pod IP. You probably want to set
                                    "Host" in httpHeaders instead.
                                    EOT
                                    "type" = "string"
                                  }
                                  "httpHeaders" = {
                                    "description" = "Custom headers to set in the request. HTTP allows repeated headers."
                                    "items" = {
                                      "description" = "HTTPHeader describes a custom header to be used in HTTP probes"
                                      "properties" = {
                                        "name" = {
                                          "description" = <<-EOT
                                          The header field name.
                                          This will be canonicalized upon output, so case-variant names will be understood as the same header.
                                          EOT
                                          "type" = "string"
                                        }
                                        "value" = {
                                          "description" = "The header field value"
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "name",
                                        "value",
                                      ]
                                      "type" = "object"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "path" = {
                                    "description" = "Path to access on the HTTP server."
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = <<-EOT
                                    Name or number of the port to access on the container.
                                    Number must be in the range 1 to 65535.
                                    Name must be an IANA_SVC_NAME.
                                    EOT
                                    "x-kubernetes-int-or-string" = true
                                  }
                                  "protocol" = {
                                    "description" = <<-EOT
                                    Protocol selects the wire protocol for the probe connection.
                                    Nil defaults to HTTP/1.1.
                                    EOT
                                    "type" = "string"
                                  }
                                  "scheme" = {
                                    "description" = <<-EOT
                                    Scheme to use for connecting to the host.
                                    Defaults to HTTP.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "initialDelaySeconds" = {
                                "description" = <<-EOT
                                Number of seconds after the container has started before liveness probes are initiated.
                                More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "periodSeconds" = {
                                "description" = <<-EOT
                                How often (in seconds) to perform the probe.
                                Default to 10 seconds. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "successThreshold" = {
                                "description" = <<-EOT
                                Minimum consecutive successes for the probe to be considered successful after having failed.
                                Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "tcpSocket" = {
                                "description" = "TCPSocket specifies a connection to a TCP port."
                                "properties" = {
                                  "host" = {
                                    "description" = "Optional: Host name to connect to, defaults to the pod IP."
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = <<-EOT
                                    Number or name of the port to access on the container.
                                    Number must be in the range 1 to 65535.
                                    Name must be an IANA_SVC_NAME.
                                    EOT
                                    "x-kubernetes-int-or-string" = true
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "terminationGracePeriodSeconds" = {
                                "description" = <<-EOT
                                Optional duration in seconds the pod needs to terminate gracefully upon probe failure.
                                The grace period is the duration in seconds after the processes running in the pod are sent
                                a termination signal and the time when the processes are forcibly halted with a kill signal.
                                Set this value longer than the expected cleanup time for your process.
                                If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this
                                value overrides the value provided by the pod spec.
                                Value must be non-negative integer. The value zero indicates stop immediately via
                                the kill signal (no opportunity to shut down).
                                This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.
                                Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "timeoutSeconds" = {
                                "description" = <<-EOT
                                Number of seconds after which the probe times out.
                                Defaults to 1 second. Minimum value is 1.
                                More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                            }
                            "type" = "object"
                          }
                          "name" = {
                            "description" = <<-EOT
                            Name of the container specified as a DNS_LABEL.
                            Each container in a pod must have a unique name (DNS_LABEL).
                            Cannot be updated.
                            EOT
                            "type" = "string"
                          }
                          "ports" = {
                            "description" = <<-EOT
                            List of ports to expose from the container. Not specifying a port here
                            DOES NOT prevent that port from being exposed. Any port which is
                            listening on the default "0.0.0.0" address inside a container will be
                            accessible from the network.
                            Modifying this array with strategic merge patch may corrupt the data.
                            For more information See https://github.com/kubernetes/kubernetes/issues/108255.
                            Cannot be updated.
                            EOT
                            "items" = {
                              "description" = "ContainerPort represents a network port in a single container."
                              "properties" = {
                                "containerPort" = {
                                  "description" = <<-EOT
                                  Number of port to expose on the pod's IP address.
                                  This must be a valid port number, 0 < x < 65536.
                                  EOT
                                  "format" = "int32"
                                  "type" = "integer"
                                }
                                "hostIP" = {
                                  "description" = "What host IP to bind the external port to."
                                  "type" = "string"
                                }
                                "hostPort" = {
                                  "description" = <<-EOT
                                  Number of port to expose on the host.
                                  If specified, this must be a valid port number, 0 < x < 65536.
                                  If HostNetwork is specified, this must match ContainerPort.
                                  Most containers do not need this.
                                  EOT
                                  "format" = "int32"
                                  "type" = "integer"
                                }
                                "name" = {
                                  "description" = <<-EOT
                                  If specified, this must be an IANA_SVC_NAME and unique within the pod. Each
                                  named port in a pod must have a unique name. Name for the port that can be
                                  referred to by services.
                                  EOT
                                  "type" = "string"
                                }
                                "protocol" = {
                                  "default" = "TCP"
                                  "description" = <<-EOT
                                  Protocol for port. Must be UDP, TCP, or SCTP.
                                  Defaults to "TCP".
                                  EOT
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "containerPort",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "containerPort",
                              "protocol",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "readinessProbe" = {
                            "description" = <<-EOT
                            Periodic probe of container service readiness.
                            Container will be removed from service endpoints if the probe fails.
                            Cannot be updated.
                            More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                            EOT
                            "properties" = {
                              "exec" = {
                                "description" = "Exec specifies a command to execute in the container."
                                "properties" = {
                                  "command" = {
                                    "description" = <<-EOT
                                    Command is the command line to execute inside the container, the working directory for the
                                    command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
                                    not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
                                    a shell, you need to explicitly call out to that shell.
                                    Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
                                    EOT
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                }
                                "type" = "object"
                              }
                              "failureThreshold" = {
                                "description" = <<-EOT
                                Minimum consecutive failures for the probe to be considered failed after having succeeded.
                                Defaults to 3. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "grpc" = {
                                "description" = "GRPC specifies a GRPC HealthCheckRequest."
                                "properties" = {
                                  "mode" = {
                                    "description" = <<-EOT
                                    mode specifies the connection mode for the gRPC health probe.
                                    Set to "TLS" to use TLS without certificate verification.
                                    Set to "Plaintext" to use a plaintext (insecure) connection explicitly.
                                    If not specified, the probe uses a plaintext (insecure) connection.
                                    EOT
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "description" = "Port number of the gRPC service. Number must be in the range 1 to 65535."
                                    "format" = "int32"
                                    "type" = "integer"
                                  }
                                  "service" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Service is the name of the service to place in the gRPC HealthCheckRequest
                                    (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
                                    
                                    If this is not specified, the default behavior is defined by gRPC.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "httpGet" = {
                                "description" = "HTTPGet specifies an HTTP GET request to perform."
                                "properties" = {
                                  "host" = {
                                    "description" = <<-EOT
                                    Host name to connect to, defaults to the pod IP. You probably want to set
                                    "Host" in httpHeaders instead.
                                    EOT
                                    "type" = "string"
                                  }
                                  "httpHeaders" = {
                                    "description" = "Custom headers to set in the request. HTTP allows repeated headers."
                                    "items" = {
                                      "description" = "HTTPHeader describes a custom header to be used in HTTP probes"
                                      "properties" = {
                                        "name" = {
                                          "description" = <<-EOT
                                          The header field name.
                                          This will be canonicalized upon output, so case-variant names will be understood as the same header.
                                          EOT
                                          "type" = "string"
                                        }
                                        "value" = {
                                          "description" = "The header field value"
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "name",
                                        "value",
                                      ]
                                      "type" = "object"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "path" = {
                                    "description" = "Path to access on the HTTP server."
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = <<-EOT
                                    Name or number of the port to access on the container.
                                    Number must be in the range 1 to 65535.
                                    Name must be an IANA_SVC_NAME.
                                    EOT
                                    "x-kubernetes-int-or-string" = true
                                  }
                                  "protocol" = {
                                    "description" = <<-EOT
                                    Protocol selects the wire protocol for the probe connection.
                                    Nil defaults to HTTP/1.1.
                                    EOT
                                    "type" = "string"
                                  }
                                  "scheme" = {
                                    "description" = <<-EOT
                                    Scheme to use for connecting to the host.
                                    Defaults to HTTP.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "initialDelaySeconds" = {
                                "description" = <<-EOT
                                Number of seconds after the container has started before liveness probes are initiated.
                                More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "periodSeconds" = {
                                "description" = <<-EOT
                                How often (in seconds) to perform the probe.
                                Default to 10 seconds. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "successThreshold" = {
                                "description" = <<-EOT
                                Minimum consecutive successes for the probe to be considered successful after having failed.
                                Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "tcpSocket" = {
                                "description" = "TCPSocket specifies a connection to a TCP port."
                                "properties" = {
                                  "host" = {
                                    "description" = "Optional: Host name to connect to, defaults to the pod IP."
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = <<-EOT
                                    Number or name of the port to access on the container.
                                    Number must be in the range 1 to 65535.
                                    Name must be an IANA_SVC_NAME.
                                    EOT
                                    "x-kubernetes-int-or-string" = true
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "terminationGracePeriodSeconds" = {
                                "description" = <<-EOT
                                Optional duration in seconds the pod needs to terminate gracefully upon probe failure.
                                The grace period is the duration in seconds after the processes running in the pod are sent
                                a termination signal and the time when the processes are forcibly halted with a kill signal.
                                Set this value longer than the expected cleanup time for your process.
                                If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this
                                value overrides the value provided by the pod spec.
                                Value must be non-negative integer. The value zero indicates stop immediately via
                                the kill signal (no opportunity to shut down).
                                This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.
                                Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "timeoutSeconds" = {
                                "description" = <<-EOT
                                Number of seconds after which the probe times out.
                                Defaults to 1 second. Minimum value is 1.
                                More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                            }
                            "type" = "object"
                          }
                          "resizePolicy" = {
                            "description" = <<-EOT
                            Resources resize policy for the container.
                            This field cannot be set on ephemeral containers.
                            EOT
                            "items" = {
                              "description" = "ContainerResizePolicy represents resource resize policy for the container."
                              "properties" = {
                                "resourceName" = {
                                  "description" = <<-EOT
                                  Name of the resource to which this resource resize policy applies.
                                  Supported values: cpu, memory.
                                  EOT
                                  "type" = "string"
                                }
                                "restartPolicy" = {
                                  "description" = <<-EOT
                                  Restart policy to apply when specified resource is resized.
                                  If not specified, it defaults to NotRequired.
                                  EOT
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "resourceName",
                                "restartPolicy",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "resources" = {
                            "description" = <<-EOT
                            Compute Resources required by this container.
                            Cannot be updated.
                            More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                            EOT
                            "properties" = {
                              "claims" = {
                                "description" = <<-EOT
                                Claims lists the names of resources, defined in spec.resourceClaims,
                                that are used by this container.
                                
                                This field depends on the
                                DynamicResourceAllocation feature gate.
                                
                                This field is immutable. It can only be set for containers.
                                EOT
                                "items" = {
                                  "description" = "ResourceClaim references one entry in PodSpec.ResourceClaims."
                                  "properties" = {
                                    "name" = {
                                      "description" = <<-EOT
                                      Name must match the name of one entry in pod.spec.resourceClaims of
                                      the Pod where this field is used. It makes that resource available
                                      inside a container.
                                      EOT
                                      "type" = "string"
                                    }
                                    "request" = {
                                      "description" = <<-EOT
                                      Request is the name chosen for a request in the referenced claim.
                                      If empty, everything from the claim is made available, otherwise
                                      only the result of this request.
                                      EOT
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                                "x-kubernetes-list-map-keys" = [
                                  "name",
                                ]
                                "x-kubernetes-list-type" = "map"
                              }
                              "limits" = {
                                "additionalProperties" = {
                                  "anyOf" = [
                                    {
                                      "type" = "integer"
                                    },
                                    {
                                      "type" = "string"
                                    },
                                  ]
                                  "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                  "x-kubernetes-int-or-string" = true
                                }
                                "description" = <<-EOT
                                Limits describes the maximum amount of compute resources allowed.
                                More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                                EOT
                                "type" = "object"
                              }
                              "requests" = {
                                "additionalProperties" = {
                                  "anyOf" = [
                                    {
                                      "type" = "integer"
                                    },
                                    {
                                      "type" = "string"
                                    },
                                  ]
                                  "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                  "x-kubernetes-int-or-string" = true
                                }
                                "description" = <<-EOT
                                Requests describes the minimum amount of compute resources required.
                                If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
                                otherwise to an implementation-defined value. Requests cannot exceed Limits.
                                More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                                EOT
                                "type" = "object"
                              }
                            }
                            "type" = "object"
                          }
                          "restartPolicy" = {
                            "description" = <<-EOT
                            RestartPolicy defines the restart behavior of individual containers in a pod.
                            This overrides the pod-level restart policy. When this field is not specified,
                            the restart behavior is defined by the Pod's restart policy and the container type.
                            Additionally, setting the RestartPolicy as "Always" for the init container will
                            have the following effect:
                            this init container will be continually restarted on
                            exit until all regular containers have terminated. Once all regular
                            containers have completed, all init containers with restartPolicy "Always"
                            will be shut down. This lifecycle differs from normal init containers and
                            is often referred to as a "sidecar" container. Although this init
                            container still starts in the init container sequence, it does not wait
                            for the container to complete before proceeding to the next init
                            container. Instead, the next init container starts immediately after this
                            init container is started, or after any startupProbe has successfully
                            completed.
                            EOT
                            "type" = "string"
                          }
                          "restartPolicyRules" = {
                            "description" = <<-EOT
                            Represents a list of rules to be checked to determine if the
                            container should be restarted on exit. The rules are evaluated in
                            order. Once a rule matches a container exit condition, the remaining
                            rules are ignored. If no rule matches the container exit condition,
                            the Container-level restart policy determines the whether the container
                            is restarted or not. Constraints on the rules:
                            - At most 20 rules are allowed.
                            - Rules can have the same action.
                            - Identical rules are not forbidden in validations.
                            When rules are specified, container MUST set RestartPolicy explicitly
                            even it if matches the Pod's RestartPolicy.
                            EOT
                            "items" = {
                              "description" = "ContainerRestartRule describes how a container exit is handled."
                              "properties" = {
                                "action" = {
                                  "description" = <<-EOT
                                  Specifies the action taken on a container exit if the requirements
                                  are satisfied. The only possible value is "Restart" to restart the
                                  container.
                                  EOT
                                  "type" = "string"
                                }
                                "exitCodes" = {
                                  "description" = "Represents the exit codes to check on container exits."
                                  "properties" = {
                                    "operator" = {
                                      "description" = <<-EOT
                                      Represents the relationship between the container exit code(s) and the
                                      specified values. Possible values are:
                                      - In: the requirement is satisfied if the container exit code is in the
                                        set of specified values.
                                      - NotIn: the requirement is satisfied if the container exit code is
                                        not in the set of specified values.
                                      EOT
                                      "type" = "string"
                                    }
                                    "values" = {
                                      "description" = <<-EOT
                                      Specifies the set of values to check for container exit codes.
                                      At most 255 elements are allowed.
                                      EOT
                                      "items" = {
                                        "format" = "int32"
                                        "type" = "integer"
                                      }
                                      "type" = "array"
                                      "x-kubernetes-list-type" = "set"
                                    }
                                  }
                                  "required" = [
                                    "operator",
                                  ]
                                  "type" = "object"
                                }
                              }
                              "required" = [
                                "action",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "securityContext" = {
                            "description" = <<-EOT
                            SecurityContext defines the security options the container should be run with.
                            If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.
                            More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
                            EOT
                            "properties" = {
                              "allowPrivilegeEscalation" = {
                                "description" = <<-EOT
                                AllowPrivilegeEscalation controls whether a process can gain more
                                privileges than its parent process. This bool directly controls if
                                the no_new_privs flag will be set on the container process.
                                AllowPrivilegeEscalation is true always when the container is:
                                1) run as Privileged
                                2) has CAP_SYS_ADMIN
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "type" = "boolean"
                              }
                              "appArmorProfile" = {
                                "description" = <<-EOT
                                appArmorProfile is the AppArmor options to use by this container. If set, this profile
                                overrides the pod's appArmorProfile.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "properties" = {
                                  "localhostProfile" = {
                                    "description" = <<-EOT
                                    localhostProfile indicates a profile loaded on the node that should be used.
                                    The profile must be preconfigured on the node to work.
                                    Must match the loaded name of the profile.
                                    Must be set if and only if type is "Localhost".
                                    EOT
                                    "type" = "string"
                                  }
                                  "type" = {
                                    "description" = <<-EOT
                                    type indicates which kind of AppArmor profile will be applied.
                                    Valid options are:
                                      Localhost - a profile pre-loaded on the node.
                                      RuntimeDefault - the container runtime's default profile.
                                      Unconfined - no AppArmor enforcement.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "type",
                                ]
                                "type" = "object"
                              }
                              "capabilities" = {
                                "description" = <<-EOT
                                The capabilities to add/drop when running containers.
                                Defaults to the default set of capabilities granted by the container runtime.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "properties" = {
                                  "add" = {
                                    "description" = "Added capabilities"
                                    "items" = {
                                      "description" = "Capability represent POSIX capabilities type"
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "drop" = {
                                    "description" = "Removed capabilities"
                                    "items" = {
                                      "description" = "Capability represent POSIX capabilities type"
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                }
                                "type" = "object"
                              }
                              "privileged" = {
                                "description" = <<-EOT
                                Run container in privileged mode.
                                Processes in privileged containers are essentially equivalent to root on the host.
                                Defaults to false.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "type" = "boolean"
                              }
                              "procMount" = {
                                "description" = <<-EOT
                                procMount denotes the type of proc mount to use for the containers.
                                The default value is Default which uses the container runtime defaults for
                                readonly paths and masked paths.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "type" = "string"
                              }
                              "readOnlyRootFilesystem" = {
                                "description" = <<-EOT
                                Whether this container has a read-only root filesystem.
                                Default is false.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "type" = "boolean"
                              }
                              "runAsGroup" = {
                                "description" = <<-EOT
                                The GID to run the entrypoint of the container process.
                                Uses runtime default if unset.
                                May also be set in PodSecurityContext.  If set in both SecurityContext and
                                PodSecurityContext, the value specified in SecurityContext takes precedence.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "runAsNonRoot" = {
                                "description" = <<-EOT
                                Indicates that the container must run as a non-root user.
                                If true, the Kubelet will validate the image at runtime to ensure that it
                                does not run as UID 0 (root) and fail to start the container if it does.
                                If unset or false, no such validation will be performed.
                                May also be set in PodSecurityContext.  If set in both SecurityContext and
                                PodSecurityContext, the value specified in SecurityContext takes precedence.
                                EOT
                                "type" = "boolean"
                              }
                              "runAsUser" = {
                                "description" = <<-EOT
                                The UID to run the entrypoint of the container process.
                                Defaults to user specified in image metadata if unspecified.
                                May also be set in PodSecurityContext.  If set in both SecurityContext and
                                PodSecurityContext, the value specified in SecurityContext takes precedence.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "seLinuxOptions" = {
                                "description" = <<-EOT
                                The SELinux context to be applied to the container.
                                If unspecified, the container runtime will allocate a random SELinux context for each
                                container.  May also be set in PodSecurityContext.  If set in both SecurityContext and
                                PodSecurityContext, the value specified in SecurityContext takes precedence.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "properties" = {
                                  "level" = {
                                    "description" = "Level is SELinux level label that applies to the container."
                                    "type" = "string"
                                  }
                                  "role" = {
                                    "description" = "Role is a SELinux role label that applies to the container."
                                    "type" = "string"
                                  }
                                  "type" = {
                                    "description" = "Type is a SELinux type label that applies to the container."
                                    "type" = "string"
                                  }
                                  "user" = {
                                    "description" = "User is a SELinux user label that applies to the container."
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "seccompProfile" = {
                                "description" = <<-EOT
                                The seccomp options to use by this container. If seccomp options are
                                provided at both the pod & container level, the container options
                                override the pod options.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "properties" = {
                                  "localhostProfile" = {
                                    "description" = <<-EOT
                                    localhostProfile indicates a profile defined in a file on the node should be used.
                                    The profile must be preconfigured on the node to work.
                                    Must be a descending path, relative to the kubelet's configured seccomp profile location.
                                    Must be set if type is "Localhost". Must NOT be set for any other type.
                                    EOT
                                    "type" = "string"
                                  }
                                  "type" = {
                                    "description" = <<-EOT
                                    type indicates which kind of seccomp profile will be applied.
                                    Valid options are:
                                    
                                    Localhost - a profile defined in a file on the node should be used.
                                    RuntimeDefault - the container runtime default profile should be used.
                                    Unconfined - no profile should be applied.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "type",
                                ]
                                "type" = "object"
                              }
                              "windowsOptions" = {
                                "description" = <<-EOT
                                The Windows specific settings applied to all containers.
                                If unspecified, the options from the PodSecurityContext will be used.
                                If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                                Note that this field cannot be set when spec.os.name is linux.
                                EOT
                                "properties" = {
                                  "gmsaCredentialSpec" = {
                                    "description" = <<-EOT
                                    GMSACredentialSpec is where the GMSA admission webhook
                                    (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the
                                    GMSA credential spec named by the GMSACredentialSpecName field.
                                    EOT
                                    "type" = "string"
                                  }
                                  "gmsaCredentialSpecName" = {
                                    "description" = "GMSACredentialSpecName is the name of the GMSA credential spec to use."
                                    "type" = "string"
                                  }
                                  "hostProcess" = {
                                    "description" = <<-EOT
                                    HostProcess determines if a container should be run as a 'Host Process' container.
                                    All of a Pod's containers must have the same effective HostProcess value
                                    (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).
                                    In addition, if HostProcess is true then HostNetwork must also be set to true.
                                    EOT
                                    "type" = "boolean"
                                  }
                                  "runAsUserName" = {
                                    "description" = <<-EOT
                                    The UserName in Windows to run the entrypoint of the container process.
                                    Defaults to the user specified in image metadata if unspecified.
                                    May also be set in PodSecurityContext. If set in both SecurityContext and
                                    PodSecurityContext, the value specified in SecurityContext takes precedence.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                            }
                            "type" = "object"
                          }
                          "startupProbe" = {
                            "description" = <<-EOT
                            StartupProbe indicates that the Pod has successfully initialized.
                            If specified, no other probes are executed until this completes successfully.
                            If this probe fails, the Pod will be restarted, just as if the livenessProbe failed.
                            This can be used to provide different probe parameters at the beginning of a Pod's lifecycle,
                            when it might take a long time to load data or warm a cache, than during steady-state operation.
                            This cannot be updated.
                            More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                            EOT
                            "properties" = {
                              "exec" = {
                                "description" = "Exec specifies a command to execute in the container."
                                "properties" = {
                                  "command" = {
                                    "description" = <<-EOT
                                    Command is the command line to execute inside the container, the working directory for the
                                    command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
                                    not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
                                    a shell, you need to explicitly call out to that shell.
                                    Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
                                    EOT
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                }
                                "type" = "object"
                              }
                              "failureThreshold" = {
                                "description" = <<-EOT
                                Minimum consecutive failures for the probe to be considered failed after having succeeded.
                                Defaults to 3. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "grpc" = {
                                "description" = "GRPC specifies a GRPC HealthCheckRequest."
                                "properties" = {
                                  "mode" = {
                                    "description" = <<-EOT
                                    mode specifies the connection mode for the gRPC health probe.
                                    Set to "TLS" to use TLS without certificate verification.
                                    Set to "Plaintext" to use a plaintext (insecure) connection explicitly.
                                    If not specified, the probe uses a plaintext (insecure) connection.
                                    EOT
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "description" = "Port number of the gRPC service. Number must be in the range 1 to 65535."
                                    "format" = "int32"
                                    "type" = "integer"
                                  }
                                  "service" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Service is the name of the service to place in the gRPC HealthCheckRequest
                                    (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
                                    
                                    If this is not specified, the default behavior is defined by gRPC.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "httpGet" = {
                                "description" = "HTTPGet specifies an HTTP GET request to perform."
                                "properties" = {
                                  "host" = {
                                    "description" = <<-EOT
                                    Host name to connect to, defaults to the pod IP. You probably want to set
                                    "Host" in httpHeaders instead.
                                    EOT
                                    "type" = "string"
                                  }
                                  "httpHeaders" = {
                                    "description" = "Custom headers to set in the request. HTTP allows repeated headers."
                                    "items" = {
                                      "description" = "HTTPHeader describes a custom header to be used in HTTP probes"
                                      "properties" = {
                                        "name" = {
                                          "description" = <<-EOT
                                          The header field name.
                                          This will be canonicalized upon output, so case-variant names will be understood as the same header.
                                          EOT
                                          "type" = "string"
                                        }
                                        "value" = {
                                          "description" = "The header field value"
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "name",
                                        "value",
                                      ]
                                      "type" = "object"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "path" = {
                                    "description" = "Path to access on the HTTP server."
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = <<-EOT
                                    Name or number of the port to access on the container.
                                    Number must be in the range 1 to 65535.
                                    Name must be an IANA_SVC_NAME.
                                    EOT
                                    "x-kubernetes-int-or-string" = true
                                  }
                                  "protocol" = {
                                    "description" = <<-EOT
                                    Protocol selects the wire protocol for the probe connection.
                                    Nil defaults to HTTP/1.1.
                                    EOT
                                    "type" = "string"
                                  }
                                  "scheme" = {
                                    "description" = <<-EOT
                                    Scheme to use for connecting to the host.
                                    Defaults to HTTP.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "initialDelaySeconds" = {
                                "description" = <<-EOT
                                Number of seconds after the container has started before liveness probes are initiated.
                                More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "periodSeconds" = {
                                "description" = <<-EOT
                                How often (in seconds) to perform the probe.
                                Default to 10 seconds. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "successThreshold" = {
                                "description" = <<-EOT
                                Minimum consecutive successes for the probe to be considered successful after having failed.
                                Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "tcpSocket" = {
                                "description" = "TCPSocket specifies a connection to a TCP port."
                                "properties" = {
                                  "host" = {
                                    "description" = "Optional: Host name to connect to, defaults to the pod IP."
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = <<-EOT
                                    Number or name of the port to access on the container.
                                    Number must be in the range 1 to 65535.
                                    Name must be an IANA_SVC_NAME.
                                    EOT
                                    "x-kubernetes-int-or-string" = true
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "terminationGracePeriodSeconds" = {
                                "description" = <<-EOT
                                Optional duration in seconds the pod needs to terminate gracefully upon probe failure.
                                The grace period is the duration in seconds after the processes running in the pod are sent
                                a termination signal and the time when the processes are forcibly halted with a kill signal.
                                Set this value longer than the expected cleanup time for your process.
                                If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this
                                value overrides the value provided by the pod spec.
                                Value must be non-negative integer. The value zero indicates stop immediately via
                                the kill signal (no opportunity to shut down).
                                This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.
                                Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "timeoutSeconds" = {
                                "description" = <<-EOT
                                Number of seconds after which the probe times out.
                                Defaults to 1 second. Minimum value is 1.
                                More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                            }
                            "type" = "object"
                          }
                          "stdin" = {
                            "description" = <<-EOT
                            Whether this container should allocate a buffer for stdin in the container runtime. If this
                            is not set, reads from stdin in the container will always result in EOF.
                            Default is false.
                            EOT
                            "type" = "boolean"
                          }
                          "stdinOnce" = {
                            "description" = <<-EOT
                            Whether the container runtime should close the stdin channel after it has been opened by
                            a single attach. When stdin is true the stdin stream will remain open across multiple attach
                            sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the
                            first client attaches to stdin, and then remains open and accepts data until the client disconnects,
                            at which time stdin is closed and remains closed until the container is restarted. If this
                            flag is false, a container processes that reads from stdin will never receive an EOF.
                            Default is false
                            EOT
                            "type" = "boolean"
                          }
                          "terminationMessagePath" = {
                            "description" = <<-EOT
                            Optional: Path at which the file to which the container's termination message
                            will be written is mounted into the container's filesystem.
                            Message written is intended to be brief final status, such as an assertion failure message.
                            Will be truncated by the node if greater than 4096 bytes. The total message length across
                            all containers will be limited to 12kb.
                            Defaults to /dev/termination-log.
                            Cannot be updated.
                            EOT
                            "type" = "string"
                          }
                          "terminationMessagePolicy" = {
                            "description" = <<-EOT
                            Indicate how the termination message should be populated. File will use the contents of
                            terminationMessagePath to populate the container status message on both success and failure.
                            FallbackToLogsOnError will use the last chunk of container log output if the termination
                            message file is empty and the container exited with an error.
                            The log output is limited to 2048 bytes or 80 lines, whichever is smaller.
                            Defaults to File.
                            Cannot be updated.
                            EOT
                            "type" = "string"
                          }
                          "tty" = {
                            "description" = <<-EOT
                            Whether this container should allocate a TTY for itself, also requires 'stdin' to be true.
                            Default is false.
                            EOT
                            "type" = "boolean"
                          }
                          "volumeDevices" = {
                            "description" = "volumeDevices is the list of block devices to be used by the container."
                            "items" = {
                              "description" = "volumeDevice describes a mapping of a raw block device within a container."
                              "properties" = {
                                "devicePath" = {
                                  "description" = "devicePath is the path inside of the container that the device will be mapped to."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "name must match the name of a persistentVolumeClaim in the pod"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "devicePath",
                                "name",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "devicePath",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "volumeMounts" = {
                            "description" = <<-EOT
                            Pod volumes to mount into the container's filesystem.
                            Cannot be updated.
                            EOT
                            "items" = {
                              "description" = "VolumeMount describes a mounting of a Volume within a container."
                              "properties" = {
                                "bindMountOptions" = {
                                  "description" = <<-EOT
                                  bindMountOptions is the list of additional bind mount options to apply when
                                  mounting this volume into the container. Allowed values are noexec,
                                  nodev, and nosuid. These are Linux mount options and have no effect on
                                  Windows nodes.
                                  This field is not supported with image volumes.
                                  This is an alpha field and requires enabling the VolumeBindMountOptions feature gate.
                                  EOT
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                  "x-kubernetes-list-type" = "set"
                                }
                                "mountPath" = {
                                  "description" = "Path within the container at which the volume should be mounted."
                                  "type" = "string"
                                }
                                "mountPropagation" = {
                                  "description" = <<-EOT
                                  mountPropagation determines how mounts are propagated from the host
                                  to container and the other way around.
                                  When not set, MountPropagationNone is used.
                                  This field is beta in 1.10.
                                  When RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation must be None or unspecified
                                  (which defaults to None).
                                  EOT
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "This must match the Name of a Volume."
                                  "type" = "string"
                                }
                                "readOnly" = {
                                  "description" = <<-EOT
                                  Mounted read-only if true, read-write otherwise (false or unspecified).
                                  Defaults to false.
                                  EOT
                                  "type" = "boolean"
                                }
                                "recursiveReadOnly" = {
                                  "description" = <<-EOT
                                  RecursiveReadOnly specifies whether read-only mounts should be handled
                                  recursively.
                                  
                                  If ReadOnly is false, this field has no meaning and must be unspecified.
                                  
                                  If ReadOnly is true, and this field is set to Disabled, the mount is not made
                                  recursively read-only.  If this field is set to IfPossible, the mount is made
                                  recursively read-only, if it is supported by the container runtime.  If this
                                  field is set to Enabled, the mount is made recursively read-only if it is
                                  supported by the container runtime, otherwise the pod will not be started and
                                  an error will be generated to indicate the reason.
                                  
                                  If this field is set to IfPossible or Enabled, MountPropagation must be set to
                                  None (or be unspecified, which defaults to None).
                                  
                                  If this field is not specified, it is treated as an equivalent of Disabled.
                                  EOT
                                  "type" = "string"
                                }
                                "subPath" = {
                                  "description" = <<-EOT
                                  Path within the volume from which the container's volume should be mounted.
                                  Defaults to "" (volume's root).
                                  EOT
                                  "type" = "string"
                                }
                                "subPathExpr" = {
                                  "description" = <<-EOT
                                  Expanded path within the volume from which the container's volume should be mounted.
                                  Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment.
                                  Defaults to "" (volume's root).
                                  SubPathExpr and SubPath are mutually exclusive.
                                  EOT
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "mountPath",
                                "name",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "mountPath",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "workingDir" = {
                            "description" = <<-EOT
                            Container's working directory.
                            If not specified, the container runtime's default will be used, which
                            might be configured in the container image.
                            Cannot be updated.
                            EOT
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "convertClassicHistogramsToNHCB" = {
                      "description" = <<-EOT
                      convertClassicHistogramsToNHCB defines whether to convert all scraped classic histograms into a native
                      histogram with custom buckets.
                      
                      It requires Prometheus >= v3.4.0.
                      EOT
                      "type" = "boolean"
                    }
                    "dnsConfig" = {
                      "description" = "dnsConfig defines the DNS configuration for the pods."
                      "properties" = {
                        "nameservers" = {
                          "description" = <<-EOT
                          nameservers defines the list of DNS name server IP addresses.
                          This will be appended to the base nameservers generated from DNSPolicy.
                          EOT
                          "items" = {
                            "minLength" = 1
                            "type" = "string"
                          }
                          "type" = "array"
                          "x-kubernetes-list-type" = "set"
                        }
                        "options" = {
                          "description" = <<-EOT
                          options defines the list of DNS resolver options.
                          This will be merged with the base options generated from DNSPolicy.
                          Resolution options given in Options
                          will override those that appear in the base DNSPolicy.
                          EOT
                          "items" = {
                            "description" = "PodDNSConfigOption defines DNS resolver options of a pod."
                            "properties" = {
                              "name" = {
                                "description" = "name is required and must be unique."
                                "minLength" = 1
                                "type" = "string"
                              }
                              "value" = {
                                "description" = "value is optional."
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "name",
                            ]
                            "type" = "object"
                          }
                          "type" = "array"
                          "x-kubernetes-list-map-keys" = [
                            "name",
                          ]
                          "x-kubernetes-list-type" = "map"
                        }
                        "searches" = {
                          "description" = <<-EOT
                          searches defines the list of DNS search domains for host-name lookup.
                          This will be appended to the base search paths generated from DNSPolicy.
                          EOT
                          "items" = {
                            "minLength" = 1
                            "type" = "string"
                          }
                          "type" = "array"
                          "x-kubernetes-list-type" = "set"
                        }
                      }
                      "type" = "object"
                    }
                    "dnsPolicy" = {
                      "description" = "dnsPolicy defines the DNS policy for the pods."
                      "enum" = [
                        "ClusterFirstWithHostNet",
                        "ClusterFirst",
                        "Default",
                        "None",
                      ]
                      "type" = "string"
                    }
                    "enableFeatures" = {
                      "description" = <<-EOT
                      enableFeatures enables access to Prometheus feature flags. By default, no features are enabled.
                      
                      Enabling features which are disabled by default is entirely outside the
                      scope of what the maintainers will support and by doing so, you accept
                      that this behaviour may break at any time without notice.
                      
                      For more information see https://prometheus.io/docs/prometheus/latest/feature_flags/
                      EOT
                      "items" = {
                        "minLength" = 1
                        "type" = "string"
                      }
                      "type" = "array"
                      "x-kubernetes-list-type" = "set"
                    }
                    "enableOTLPReceiver" = {
                      "description" = <<-EOT
                      enableOTLPReceiver defines the Prometheus to be used as a receiver for the OTLP Metrics protocol.
                      
                      Note that the OTLP receiver endpoint is automatically enabled if `.spec.otlpConfig` is defined.
                      
                      It requires Prometheus >= v2.47.0.
                      EOT
                      "type" = "boolean"
                    }
                    "enableRemoteWriteReceiver" = {
                      "description" = <<-EOT
                      enableRemoteWriteReceiver defines the Prometheus to be used as a receiver for the Prometheus remote
                      write protocol.
                      
                      WARNING: This is not considered an efficient way of ingesting samples.
                      Use it with caution for specific low-volume use cases.
                      It is not suitable for replacing the ingestion via scraping and turning
                      Prometheus into a push-based metrics collection system.
                      For more information see https://prometheus.io/docs/prometheus/latest/querying/api/#remote-write-receiver
                      
                      It requires Prometheus >= v2.33.0.
                      EOT
                      "type" = "boolean"
                    }
                    "enableServiceLinks" = {
                      "description" = "enableServiceLinks defines whether information about services should be injected into pod's environment variables"
                      "type" = "boolean"
                    }
                    "enforcedBodySizeLimit" = {
                      "description" = <<-EOT
                      enforcedBodySizeLimit when defined specifies a global limit on the size
                      of uncompressed response body that will be accepted by Prometheus.
                      Targets responding with a body larger than this many bytes will cause
                      the scrape to fail.
                      
                      It requires Prometheus >= v2.28.0.
                      
                      When both `enforcedBodySizeLimit` and `bodySizeLimit` are defined and greater than zero, the following rules apply:
                      * Scrape objects without a defined bodySizeLimit value will inherit the global bodySizeLimit value (Prometheus >= 2.45.0) or the enforcedBodySizeLimit value (Prometheus < v2.45.0).
                        If Prometheus version is >= 2.45.0 and the `enforcedBodySizeLimit` is greater than the `bodySizeLimit`, the `bodySizeLimit` will be set to `enforcedBodySizeLimit`.
                      * Scrape objects with a bodySizeLimit value less than or equal to enforcedBodySizeLimit keep their specific value.
                      * Scrape objects with a bodySizeLimit value greater than enforcedBodySizeLimit are set to enforcedBodySizeLimit.
                      EOT
                      "pattern" = "(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
                      "type" = "string"
                    }
                    "enforcedKeepDroppedTargets" = {
                      "description" = <<-EOT
                      enforcedKeepDroppedTargets when defined specifies a global limit on the number of targets
                      dropped by relabeling that will be kept in memory. The value overrides
                      any `spec.keepDroppedTargets` set by
                      ServiceMonitor, PodMonitor, Probe objects unless `spec.keepDroppedTargets` is
                      greater than zero and less than `spec.enforcedKeepDroppedTargets`.
                      
                      It requires Prometheus >= v2.47.0.
                      
                      When both `enforcedKeepDroppedTargets` and `keepDroppedTargets` are defined and greater than zero, the following rules apply:
                      * Scrape objects without a defined keepDroppedTargets value will inherit the global keepDroppedTargets value (Prometheus >= 2.45.0) or the enforcedKeepDroppedTargets value (Prometheus < v2.45.0).
                        If Prometheus version is >= 2.45.0 and the `enforcedKeepDroppedTargets` is greater than the `keepDroppedTargets`, the `keepDroppedTargets` will be set to `enforcedKeepDroppedTargets`.
                      * Scrape objects with a keepDroppedTargets value less than or equal to enforcedKeepDroppedTargets keep their specific value.
                      * Scrape objects with a keepDroppedTargets value greater than enforcedKeepDroppedTargets are set to enforcedKeepDroppedTargets.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "enforcedLabelLimit" = {
                      "description" = <<-EOT
                      enforcedLabelLimit when defined specifies a global limit on the number
                      of labels per sample. The value overrides any `spec.labelLimit` set by
                      ServiceMonitor, PodMonitor, Probe objects unless `spec.labelLimit` is
                      greater than zero and less than `spec.enforcedLabelLimit`.
                      
                      It requires Prometheus >= v2.27.0.
                      
                      When both `enforcedLabelLimit` and `labelLimit` are defined and greater than zero, the following rules apply:
                      * Scrape objects without a defined labelLimit value will inherit the global labelLimit value (Prometheus >= 2.45.0) or the enforcedLabelLimit value (Prometheus < v2.45.0).
                        If Prometheus version is >= 2.45.0 and the `enforcedLabelLimit` is greater than the `labelLimit`, the `labelLimit` will be set to `enforcedLabelLimit`.
                      * Scrape objects with a labelLimit value less than or equal to enforcedLabelLimit keep their specific value.
                      * Scrape objects with a labelLimit value greater than enforcedLabelLimit are set to enforcedLabelLimit.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "enforcedLabelNameLengthLimit" = {
                      "description" = <<-EOT
                      enforcedLabelNameLengthLimit when defined specifies a global limit on the length
                      of labels name per sample. The value overrides any `spec.labelNameLengthLimit` set by
                      ServiceMonitor, PodMonitor, Probe objects unless `spec.labelNameLengthLimit` is
                      greater than zero and less than `spec.enforcedLabelNameLengthLimit`.
                      
                      It requires Prometheus >= v2.27.0.
                      
                      When both `enforcedLabelNameLengthLimit` and `labelNameLengthLimit` are defined and greater than zero, the following rules apply:
                      * Scrape objects without a defined labelNameLengthLimit value will inherit the global labelNameLengthLimit value (Prometheus >= 2.45.0) or the enforcedLabelNameLengthLimit value (Prometheus < v2.45.0).
                        If Prometheus version is >= 2.45.0 and the `enforcedLabelNameLengthLimit` is greater than the `labelNameLengthLimit`, the `labelNameLengthLimit` will be set to `enforcedLabelNameLengthLimit`.
                      * Scrape objects with a labelNameLengthLimit value less than or equal to enforcedLabelNameLengthLimit keep their specific value.
                      * Scrape objects with a labelNameLengthLimit value greater than enforcedLabelNameLengthLimit are set to enforcedLabelNameLengthLimit.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "enforcedLabelValueLengthLimit" = {
                      "description" = <<-EOT
                      enforcedLabelValueLengthLimit when not null defines a global limit on the length
                      of labels value per sample. The value overrides any `spec.labelValueLengthLimit` set by
                      ServiceMonitor, PodMonitor, Probe objects unless `spec.labelValueLengthLimit` is
                      greater than zero and less than `spec.enforcedLabelValueLengthLimit`.
                      
                      It requires Prometheus >= v2.27.0.
                      
                      When both `enforcedLabelValueLengthLimit` and `labelValueLengthLimit` are defined and greater than zero, the following rules apply:
                      * Scrape objects without a defined labelValueLengthLimit value will inherit the global labelValueLengthLimit value (Prometheus >= 2.45.0) or the enforcedLabelValueLengthLimit value (Prometheus < v2.45.0).
                        If Prometheus version is >= 2.45.0 and the `enforcedLabelValueLengthLimit` is greater than the `labelValueLengthLimit`, the `labelValueLengthLimit` will be set to `enforcedLabelValueLengthLimit`.
                      * Scrape objects with a labelValueLengthLimit value less than or equal to enforcedLabelValueLengthLimit keep their specific value.
                      * Scrape objects with a labelValueLengthLimit value greater than enforcedLabelValueLengthLimit are set to enforcedLabelValueLengthLimit.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "enforcedNamespaceLabel" = {
                      "description" = <<-EOT
                      enforcedNamespaceLabel when not empty, a label will be added to:
                      
                      1. All metrics scraped from `ServiceMonitor`, `PodMonitor`, `Probe` and `ScrapeConfig` objects.
                      2. All metrics generated from recording rules defined in `PrometheusRule` objects.
                      3. All alerts generated from alerting rules defined in `PrometheusRule` objects.
                      4. All vector selectors of PromQL expressions defined in `PrometheusRule` objects.
                      
                      The label will not added for objects referenced in `spec.excludedFromEnforcement`.
                      
                      The label's name is this field's value.
                      The label's value is the namespace of the `ServiceMonitor`,
                      `PodMonitor`, `Probe`, `PrometheusRule` or `ScrapeConfig` object.
                      EOT
                      "type" = "string"
                    }
                    "enforcedSampleLimit" = {
                      "description" = <<-EOT
                      enforcedSampleLimit when defined specifies a global limit on the number
                      of scraped samples that will be accepted. This overrides any
                      `spec.sampleLimit` set by ServiceMonitor, PodMonitor, Probe objects
                      unless `spec.sampleLimit` is greater than zero and less than
                      `spec.enforcedSampleLimit`.
                      
                      It is meant to be used by admins to keep the overall number of
                      samples/series under a desired limit.
                      
                      When both `enforcedSampleLimit` and `sampleLimit` are defined and greater than zero, the following rules apply:
                      * Scrape objects without a defined sampleLimit value will inherit the global sampleLimit value (Prometheus >= 2.45.0) or the enforcedSampleLimit value (Prometheus < v2.45.0).
                        If Prometheus version is >= 2.45.0 and the `enforcedSampleLimit` is greater than the `sampleLimit`, the `sampleLimit` will be set to `enforcedSampleLimit`.
                      * Scrape objects with a sampleLimit value less than or equal to enforcedSampleLimit keep their specific value.
                      * Scrape objects with a sampleLimit value greater than enforcedSampleLimit are set to enforcedSampleLimit.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "enforcedTargetLimit" = {
                      "description" = <<-EOT
                      enforcedTargetLimit when defined specifies a global limit on the number
                      of scraped targets. The value overrides any `spec.targetLimit` set by
                      ServiceMonitor, PodMonitor, Probe objects unless `spec.targetLimit` is
                      greater than zero and less than `spec.enforcedTargetLimit`.
                      
                      It is meant to be used by admins to to keep the overall number of
                      targets under a desired limit.
                      
                      When both `enforcedTargetLimit` and `targetLimit` are defined and greater than zero, the following rules apply:
                      * Scrape objects without a defined targetLimit value will inherit the global targetLimit value (Prometheus >= 2.45.0) or the enforcedTargetLimit value (Prometheus < v2.45.0).
                        If Prometheus version is >= 2.45.0 and the `enforcedTargetLimit` is greater than the `targetLimit`, the `targetLimit` will be set to `enforcedTargetLimit`.
                      * Scrape objects with a targetLimit value less than or equal to enforcedTargetLimit keep their specific value.
                      * Scrape objects with a targetLimit value greater than enforcedTargetLimit are set to enforcedTargetLimit.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "excludedFromEnforcement" = {
                      "description" = <<-EOT
                      excludedFromEnforcement defines the list of references to PodMonitor, ServiceMonitor, Probe and PrometheusRule objects
                      to be excluded from enforcing a namespace label of origin.
                      
                      It is only applicable if `spec.enforcedNamespaceLabel` set to true.
                      EOT
                      "items" = {
                        "description" = "ObjectReference references a PodMonitor, ServiceMonitor, Probe or PrometheusRule object."
                        "properties" = {
                          "group" = {
                            "default" = "monitoring.coreos.com"
                            "description" = "group of the referent. When not specified, it defaults to `monitoring.coreos.com`"
                            "enum" = [
                              "monitoring.coreos.com",
                            ]
                            "type" = "string"
                          }
                          "name" = {
                            "description" = "name of the referent. When not set, all resources in the namespace are matched."
                            "type" = "string"
                          }
                          "namespace" = {
                            "description" = <<-EOT
                            namespace of the referent.
                            More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
                            EOT
                            "minLength" = 1
                            "type" = "string"
                          }
                          "resource" = {
                            "description" = "resource of the referent."
                            "enum" = [
                              "prometheusrules",
                              "servicemonitors",
                              "podmonitors",
                              "probes",
                              "scrapeconfigs",
                            ]
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "namespace",
                          "resource",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "externalLabels" = {
                      "additionalProperties" = {
                        "type" = "string"
                      }
                      "description" = <<-EOT
                      externalLabels defines the labels to add to any time series or alerts when communicating with
                      external systems (federation, remote storage, Alertmanager).
                      Labels defined by `spec.replicaExternalLabelName` and
                      `spec.prometheusExternalLabelName` take precedence over this list.
                      EOT
                      "type" = "object"
                    }
                    "externalUrl" = {
                      "description" = <<-EOT
                      externalUrl defines the external URL under which the Prometheus service is externally
                      available. This is necessary to generate correct URLs (for instance if
                      Prometheus is accessible behind an Ingress resource).
                      EOT
                      "type" = "string"
                    }
                    "hostAliases" = {
                      "description" = <<-EOT
                      hostAliases defines the optional list of hosts and IPs that will be injected into the Pod's
                      hosts file if specified.
                      EOT
                      "items" = {
                        "description" = <<-EOT
                        HostAlias holds the mapping between IP and hostnames that will be injected as an entry in the
                        pod's hosts file.
                        EOT
                        "properties" = {
                          "hostnames" = {
                            "description" = "hostnames defines hostnames for the above IP address."
                            "items" = {
                              "type" = "string"
                            }
                            "type" = "array"
                          }
                          "ip" = {
                            "description" = "ip defines the IP address of the host file entry."
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "hostnames",
                          "ip",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-map-keys" = [
                        "ip",
                      ]
                      "x-kubernetes-list-type" = "map"
                    }
                    "hostNetwork" = {
                      "description" = <<-EOT
                      hostNetwork defines the host's network namespace if true.
                      
                      Make sure to understand the security implications if you want to enable
                      it (https://kubernetes.io/docs/concepts/configuration/overview/ ).
                      
                      When hostNetwork is enabled, this will set the DNS policy to
                      `ClusterFirstWithHostNet` automatically (unless `.spec.DNSPolicy` is set
                      to a different value).
                      EOT
                      "type" = "boolean"
                    }
                    "hostUsers" = {
                      "description" = <<-EOT
                      hostUsers supports the user space in Kubernetes.
                      
                      More info: https://kubernetes.io/docs/tasks/configure-pod-container/user-namespaces/
                      
                      The feature requires at least Kubernetes 1.28 with the `UserNamespacesSupport` feature gate enabled.
                      Starting Kubernetes 1.33, the feature is enabled by default.
                      EOT
                      "type" = "boolean"
                    }
                    "ignoreNamespaceSelectors" = {
                      "description" = <<-EOT
                      ignoreNamespaceSelectors when true, `spec.namespaceSelector` from all PodMonitor, ServiceMonitor
                      and Probe objects will be ignored. They will only discover targets
                      within the namespace of the PodMonitor, ServiceMonitor and Probe
                      object.
                      EOT
                      "type" = "boolean"
                    }
                    "image" = {
                      "description" = <<-EOT
                      image defines the container image name for Prometheus. If specified, it takes precedence
                      over the `spec.baseImage`, `spec.tag` and `spec.sha` fields.
                      
                      Specifying `spec.version` is still necessary to ensure the Prometheus
                      Operator knows which version of Prometheus is being configured.
                      
                      If neither `spec.image` nor `spec.baseImage` are defined, the operator
                      will use the latest upstream version of Prometheus available at the time
                      when the operator was released.
                      EOT
                      "type" = "string"
                    }
                    "imagePullPolicy" = {
                      "description" = <<-EOT
                      imagePullPolicy defines the image pull policy for the 'prometheus', 'init-config-reloader' and 'config-reloader' containers.
                      See https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy for more details.
                      EOT
                      "enum" = [
                        "",
                        "Always",
                        "Never",
                        "IfNotPresent",
                      ]
                      "type" = "string"
                    }
                    "imagePullSecrets" = {
                      "description" = <<-EOT
                      imagePullSecrets defines an optional list of references to Secrets in the same namespace
                      to use for pulling images from registries.
                      See http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod
                      EOT
                      "items" = {
                        "description" = <<-EOT
                        LocalObjectReference contains enough information to let you locate the
                        referenced object inside the same namespace.
                        EOT
                        "properties" = {
                          "name" = {
                            "default" = ""
                            "description" = <<-EOT
                            Name of the referent.
                            This field is effectively required, but due to backwards compatibility is
                            allowed to be empty. Instances of this type with an empty value here are
                            almost certainly wrong.
                            More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                            EOT
                            "type" = "string"
                          }
                        }
                        "type" = "object"
                        "x-kubernetes-map-type" = "atomic"
                      }
                      "type" = "array"
                    }
                    "initContainers" = {
                      "description" = <<-EOT
                      initContainers allows injecting initContainers to the Pod definition. Those
                      can be used to e.g. fetch secrets for injection into the Prometheus
                      configuration from external sources. Any errors during the execution of
                      an initContainer will lead to a restart of the Pod. More info:
                      https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
                      InitContainers described here modify an operator generated init
                      containers if they share the same name and modifications are done via a
                      strategic merge patch.
                      
                      The names of init container name managed by the operator are:
                      * `init-config-reloader`.
                      
                      Overriding init containers which are managed by the operator require
                      careful testing, especially when upgrading to a new version of the
                      operator.
                      EOT
                      "items" = {
                        "description" = "A single application container that you want to run within a pod."
                        "properties" = {
                          "args" = {
                            "description" = <<-EOT
                            Arguments to the entrypoint.
                            The container image's CMD is used if this is not provided.
                            Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
                            cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
                            to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
                            produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
                            of whether the variable exists or not. Cannot be updated.
                            More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
                            EOT
                            "items" = {
                              "type" = "string"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "command" = {
                            "description" = <<-EOT
                            Entrypoint array. Not executed within a shell.
                            The container image's ENTRYPOINT is used if this is not provided.
                            Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
                            cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
                            to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
                            produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
                            of whether the variable exists or not. Cannot be updated.
                            More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
                            EOT
                            "items" = {
                              "type" = "string"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "env" = {
                            "description" = <<-EOT
                            List of environment variables to set in the container.
                            Cannot be updated.
                            EOT
                            "items" = {
                              "description" = "EnvVar represents an environment variable present in a Container."
                              "properties" = {
                                "name" = {
                                  "description" = <<-EOT
                                  Name of the environment variable.
                                  May consist of any printable ASCII characters except '='.
                                  EOT
                                  "type" = "string"
                                }
                                "value" = {
                                  "description" = <<-EOT
                                  Variable references $(VAR_NAME) are expanded
                                  using the previously defined environment variables in the container and
                                  any service environment variables. If a variable cannot be resolved,
                                  the reference in the input string will be unchanged. Double $$ are reduced
                                  to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.
                                  "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)".
                                  Escaped references will never be expanded, regardless of whether the variable
                                  exists or not.
                                  Defaults to "".
                                  EOT
                                  "type" = "string"
                                }
                                "valueFrom" = {
                                  "description" = "Source for the environment variable's value. Cannot be used if value is not empty."
                                  "properties" = {
                                    "configMapKeyRef" = {
                                      "description" = "Selects a key of a ConfigMap."
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
                                    "fieldRef" = {
                                      "description" = <<-EOT
                                      Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,
                                      spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.
                                      EOT
                                      "properties" = {
                                        "apiVersion" = {
                                          "description" = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
                                          "type" = "string"
                                        }
                                        "fieldPath" = {
                                          "description" = "Path of the field to select in the specified API version."
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "fieldPath",
                                      ]
                                      "type" = "object"
                                      "x-kubernetes-map-type" = "atomic"
                                    }
                                    "fileKeyRef" = {
                                      "description" = <<-EOT
                                      FileKeyRef selects a key of the env file.
                                      Requires the EnvFiles feature gate to be enabled.
                                      EOT
                                      "properties" = {
                                        "key" = {
                                          "description" = <<-EOT
                                          The key within the env file. An invalid key will prevent the pod from starting.
                                          The keys defined within a source may consist of any printable ASCII characters except '='.
                                          During Alpha stage of the EnvFiles feature gate, the key size is limited to 128 characters.
                                          EOT
                                          "type" = "string"
                                        }
                                        "optional" = {
                                          "default" = false
                                          "description" = <<-EOT
                                          Specify whether the file or its key must be defined. If the file or key
                                          does not exist, then the env var is not published.
                                          If optional is set to true and the specified key does not exist,
                                          the environment variable will not be set in the Pod's containers.
                                          
                                          If optional is set to false and the specified key does not exist,
                                          an error will be returned during Pod creation.
                                          EOT
                                          "type" = "boolean"
                                        }
                                        "path" = {
                                          "description" = <<-EOT
                                          The path within the volume from which to select the file.
                                          Must be relative and may not contain the '..' path or start with '..'.
                                          EOT
                                          "type" = "string"
                                        }
                                        "volumeName" = {
                                          "description" = "The name of the volume mount containing the env file."
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "key",
                                        "path",
                                        "volumeName",
                                      ]
                                      "type" = "object"
                                      "x-kubernetes-map-type" = "atomic"
                                    }
                                    "resourceFieldRef" = {
                                      "description" = <<-EOT
                                      Selects a resource of the container: only resources limits and requests
                                      (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.
                                      EOT
                                      "properties" = {
                                        "containerName" = {
                                          "description" = "Container name: required for volumes, optional for env vars"
                                          "type" = "string"
                                        }
                                        "divisor" = {
                                          "anyOf" = [
                                            {
                                              "type" = "integer"
                                            },
                                            {
                                              "type" = "string"
                                            },
                                          ]
                                          "description" = "Specifies the output format of the exposed resources, defaults to \"1\""
                                          "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                          "x-kubernetes-int-or-string" = true
                                        }
                                        "resource" = {
                                          "description" = "Required: resource to select"
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "resource",
                                      ]
                                      "type" = "object"
                                      "x-kubernetes-map-type" = "atomic"
                                    }
                                    "secretKeyRef" = {
                                      "description" = "Selects a key of a secret in the pod's namespace"
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
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "name",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "envFrom" = {
                            "description" = <<-EOT
                            List of sources to populate environment variables in the container.
                            The keys defined within a source may consist of any printable ASCII characters except '='.
                            When a key exists in multiple
                            sources, the value associated with the last source will take precedence.
                            Values defined by an Env with a duplicate key will take precedence.
                            Cannot be updated.
                            EOT
                            "items" = {
                              "description" = "EnvFromSource represents the source of a set of ConfigMaps or Secrets"
                              "properties" = {
                                "configMapRef" = {
                                  "description" = "The ConfigMap to select from"
                                  "properties" = {
                                    "name" = {
                                      "default" = ""
                                      "description" = <<-EOT
                                      Name of the referent.
                                      This field is effectively required, but due to backwards compatibility is
                                      allowed to be empty. Instances of this type with an empty value here are
                                      almost certainly wrong.
                                      More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                      EOT
                                      "type" = "string"
                                    }
                                    "optional" = {
                                      "description" = "Specify whether the ConfigMap must be defined"
                                      "type" = "boolean"
                                    }
                                  }
                                  "type" = "object"
                                  "x-kubernetes-map-type" = "atomic"
                                }
                                "prefix" = {
                                  "description" = <<-EOT
                                  Optional text to prepend to the name of each environment variable.
                                  May consist of any printable ASCII characters except '='.
                                  EOT
                                  "type" = "string"
                                }
                                "secretRef" = {
                                  "description" = "The Secret to select from"
                                  "properties" = {
                                    "name" = {
                                      "default" = ""
                                      "description" = <<-EOT
                                      Name of the referent.
                                      This field is effectively required, but due to backwards compatibility is
                                      allowed to be empty. Instances of this type with an empty value here are
                                      almost certainly wrong.
                                      More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                      EOT
                                      "type" = "string"
                                    }
                                    "optional" = {
                                      "description" = "Specify whether the Secret must be defined"
                                      "type" = "boolean"
                                    }
                                  }
                                  "type" = "object"
                                  "x-kubernetes-map-type" = "atomic"
                                }
                              }
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "image" = {
                            "description" = <<-EOT
                            Container image name.
                            More info: https://kubernetes.io/docs/concepts/containers/images
                            This field is optional to allow higher level config management to default or override
                            container images in workload controllers like Deployments and StatefulSets.
                            EOT
                            "type" = "string"
                          }
                          "imagePullPolicy" = {
                            "description" = <<-EOT
                            Image pull policy.
                            One of Always, Never, IfNotPresent.
                            Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
                            Cannot be updated.
                            More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
                            EOT
                            "type" = "string"
                          }
                          "lifecycle" = {
                            "description" = <<-EOT
                            Actions that the management system should take in response to container lifecycle events.
                            Cannot be updated.
                            EOT
                            "properties" = {
                              "postStart" = {
                                "description" = <<-EOT
                                PostStart is called immediately after a container is created. If the handler fails,
                                the container is terminated and restarted according to its restart policy.
                                Other management of the container blocks until the hook completes.
                                More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
                                EOT
                                "properties" = {
                                  "exec" = {
                                    "description" = "Exec specifies a command to execute in the container."
                                    "properties" = {
                                      "command" = {
                                        "description" = <<-EOT
                                        Command is the command line to execute inside the container, the working directory for the
                                        command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
                                        not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
                                        a shell, you need to explicitly call out to that shell.
                                        Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
                                        EOT
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "httpGet" = {
                                    "description" = "HTTPGet specifies an HTTP GET request to perform."
                                    "properties" = {
                                      "host" = {
                                        "description" = <<-EOT
                                        Host name to connect to, defaults to the pod IP. You probably want to set
                                        "Host" in httpHeaders instead.
                                        EOT
                                        "type" = "string"
                                      }
                                      "httpHeaders" = {
                                        "description" = "Custom headers to set in the request. HTTP allows repeated headers."
                                        "items" = {
                                          "description" = "HTTPHeader describes a custom header to be used in HTTP probes"
                                          "properties" = {
                                            "name" = {
                                              "description" = <<-EOT
                                              The header field name.
                                              This will be canonicalized upon output, so case-variant names will be understood as the same header.
                                              EOT
                                              "type" = "string"
                                            }
                                            "value" = {
                                              "description" = "The header field value"
                                              "type" = "string"
                                            }
                                          }
                                          "required" = [
                                            "name",
                                            "value",
                                          ]
                                          "type" = "object"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                      "path" = {
                                        "description" = "Path to access on the HTTP server."
                                        "type" = "string"
                                      }
                                      "port" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "description" = <<-EOT
                                        Name or number of the port to access on the container.
                                        Number must be in the range 1 to 65535.
                                        Name must be an IANA_SVC_NAME.
                                        EOT
                                        "x-kubernetes-int-or-string" = true
                                      }
                                      "protocol" = {
                                        "description" = <<-EOT
                                        Protocol selects the wire protocol for the probe connection.
                                        Nil defaults to HTTP/1.1.
                                        EOT
                                        "type" = "string"
                                      }
                                      "scheme" = {
                                        "description" = <<-EOT
                                        Scheme to use for connecting to the host.
                                        Defaults to HTTP.
                                        EOT
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "port",
                                    ]
                                    "type" = "object"
                                  }
                                  "sleep" = {
                                    "description" = "Sleep represents a duration that the container should sleep."
                                    "properties" = {
                                      "seconds" = {
                                        "description" = "Seconds is the number of seconds to sleep."
                                        "format" = "int64"
                                        "type" = "integer"
                                      }
                                    }
                                    "required" = [
                                      "seconds",
                                    ]
                                    "type" = "object"
                                  }
                                  "tcpSocket" = {
                                    "description" = <<-EOT
                                    Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept
                                    for backward compatibility. There is no validation of this field and
                                    lifecycle hooks will fail at runtime when it is specified.
                                    EOT
                                    "properties" = {
                                      "host" = {
                                        "description" = "Optional: Host name to connect to, defaults to the pod IP."
                                        "type" = "string"
                                      }
                                      "port" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "description" = <<-EOT
                                        Number or name of the port to access on the container.
                                        Number must be in the range 1 to 65535.
                                        Name must be an IANA_SVC_NAME.
                                        EOT
                                        "x-kubernetes-int-or-string" = true
                                      }
                                    }
                                    "required" = [
                                      "port",
                                    ]
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                              "preStop" = {
                                "description" = <<-EOT
                                PreStop is called immediately before a container is terminated due to an
                                API request or management event such as liveness/startup probe failure,
                                preemption, resource contention, etc. The handler is not called if the
                                container crashes or exits. The Pod's termination grace period countdown begins before the
                                PreStop hook is executed. Regardless of the outcome of the handler, the
                                container will eventually terminate within the Pod's termination grace
                                period (unless delayed by finalizers). Other management of the container blocks until the hook completes
                                or until the termination grace period is reached.
                                More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
                                EOT
                                "properties" = {
                                  "exec" = {
                                    "description" = "Exec specifies a command to execute in the container."
                                    "properties" = {
                                      "command" = {
                                        "description" = <<-EOT
                                        Command is the command line to execute inside the container, the working directory for the
                                        command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
                                        not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
                                        a shell, you need to explicitly call out to that shell.
                                        Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
                                        EOT
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "httpGet" = {
                                    "description" = "HTTPGet specifies an HTTP GET request to perform."
                                    "properties" = {
                                      "host" = {
                                        "description" = <<-EOT
                                        Host name to connect to, defaults to the pod IP. You probably want to set
                                        "Host" in httpHeaders instead.
                                        EOT
                                        "type" = "string"
                                      }
                                      "httpHeaders" = {
                                        "description" = "Custom headers to set in the request. HTTP allows repeated headers."
                                        "items" = {
                                          "description" = "HTTPHeader describes a custom header to be used in HTTP probes"
                                          "properties" = {
                                            "name" = {
                                              "description" = <<-EOT
                                              The header field name.
                                              This will be canonicalized upon output, so case-variant names will be understood as the same header.
                                              EOT
                                              "type" = "string"
                                            }
                                            "value" = {
                                              "description" = "The header field value"
                                              "type" = "string"
                                            }
                                          }
                                          "required" = [
                                            "name",
                                            "value",
                                          ]
                                          "type" = "object"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                      "path" = {
                                        "description" = "Path to access on the HTTP server."
                                        "type" = "string"
                                      }
                                      "port" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "description" = <<-EOT
                                        Name or number of the port to access on the container.
                                        Number must be in the range 1 to 65535.
                                        Name must be an IANA_SVC_NAME.
                                        EOT
                                        "x-kubernetes-int-or-string" = true
                                      }
                                      "protocol" = {
                                        "description" = <<-EOT
                                        Protocol selects the wire protocol for the probe connection.
                                        Nil defaults to HTTP/1.1.
                                        EOT
                                        "type" = "string"
                                      }
                                      "scheme" = {
                                        "description" = <<-EOT
                                        Scheme to use for connecting to the host.
                                        Defaults to HTTP.
                                        EOT
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "port",
                                    ]
                                    "type" = "object"
                                  }
                                  "sleep" = {
                                    "description" = "Sleep represents a duration that the container should sleep."
                                    "properties" = {
                                      "seconds" = {
                                        "description" = "Seconds is the number of seconds to sleep."
                                        "format" = "int64"
                                        "type" = "integer"
                                      }
                                    }
                                    "required" = [
                                      "seconds",
                                    ]
                                    "type" = "object"
                                  }
                                  "tcpSocket" = {
                                    "description" = <<-EOT
                                    Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept
                                    for backward compatibility. There is no validation of this field and
                                    lifecycle hooks will fail at runtime when it is specified.
                                    EOT
                                    "properties" = {
                                      "host" = {
                                        "description" = "Optional: Host name to connect to, defaults to the pod IP."
                                        "type" = "string"
                                      }
                                      "port" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "description" = <<-EOT
                                        Number or name of the port to access on the container.
                                        Number must be in the range 1 to 65535.
                                        Name must be an IANA_SVC_NAME.
                                        EOT
                                        "x-kubernetes-int-or-string" = true
                                      }
                                    }
                                    "required" = [
                                      "port",
                                    ]
                                    "type" = "object"
                                  }
                                }
                                "type" = "object"
                              }
                              "stopSignal" = {
                                "description" = <<-EOT
                                StopSignal defines which signal will be sent to a container when it is being stopped.
                                If not specified, the default is defined by the container runtime in use.
                                StopSignal can only be set for Pods with a non-empty .spec.os.name
                                EOT
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "livenessProbe" = {
                            "description" = <<-EOT
                            Periodic probe of container liveness.
                            Container will be restarted if the probe fails.
                            Cannot be updated.
                            More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                            EOT
                            "properties" = {
                              "exec" = {
                                "description" = "Exec specifies a command to execute in the container."
                                "properties" = {
                                  "command" = {
                                    "description" = <<-EOT
                                    Command is the command line to execute inside the container, the working directory for the
                                    command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
                                    not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
                                    a shell, you need to explicitly call out to that shell.
                                    Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
                                    EOT
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                }
                                "type" = "object"
                              }
                              "failureThreshold" = {
                                "description" = <<-EOT
                                Minimum consecutive failures for the probe to be considered failed after having succeeded.
                                Defaults to 3. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "grpc" = {
                                "description" = "GRPC specifies a GRPC HealthCheckRequest."
                                "properties" = {
                                  "mode" = {
                                    "description" = <<-EOT
                                    mode specifies the connection mode for the gRPC health probe.
                                    Set to "TLS" to use TLS without certificate verification.
                                    Set to "Plaintext" to use a plaintext (insecure) connection explicitly.
                                    If not specified, the probe uses a plaintext (insecure) connection.
                                    EOT
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "description" = "Port number of the gRPC service. Number must be in the range 1 to 65535."
                                    "format" = "int32"
                                    "type" = "integer"
                                  }
                                  "service" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Service is the name of the service to place in the gRPC HealthCheckRequest
                                    (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
                                    
                                    If this is not specified, the default behavior is defined by gRPC.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "httpGet" = {
                                "description" = "HTTPGet specifies an HTTP GET request to perform."
                                "properties" = {
                                  "host" = {
                                    "description" = <<-EOT
                                    Host name to connect to, defaults to the pod IP. You probably want to set
                                    "Host" in httpHeaders instead.
                                    EOT
                                    "type" = "string"
                                  }
                                  "httpHeaders" = {
                                    "description" = "Custom headers to set in the request. HTTP allows repeated headers."
                                    "items" = {
                                      "description" = "HTTPHeader describes a custom header to be used in HTTP probes"
                                      "properties" = {
                                        "name" = {
                                          "description" = <<-EOT
                                          The header field name.
                                          This will be canonicalized upon output, so case-variant names will be understood as the same header.
                                          EOT
                                          "type" = "string"
                                        }
                                        "value" = {
                                          "description" = "The header field value"
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "name",
                                        "value",
                                      ]
                                      "type" = "object"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "path" = {
                                    "description" = "Path to access on the HTTP server."
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = <<-EOT
                                    Name or number of the port to access on the container.
                                    Number must be in the range 1 to 65535.
                                    Name must be an IANA_SVC_NAME.
                                    EOT
                                    "x-kubernetes-int-or-string" = true
                                  }
                                  "protocol" = {
                                    "description" = <<-EOT
                                    Protocol selects the wire protocol for the probe connection.
                                    Nil defaults to HTTP/1.1.
                                    EOT
                                    "type" = "string"
                                  }
                                  "scheme" = {
                                    "description" = <<-EOT
                                    Scheme to use for connecting to the host.
                                    Defaults to HTTP.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "initialDelaySeconds" = {
                                "description" = <<-EOT
                                Number of seconds after the container has started before liveness probes are initiated.
                                More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "periodSeconds" = {
                                "description" = <<-EOT
                                How often (in seconds) to perform the probe.
                                Default to 10 seconds. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "successThreshold" = {
                                "description" = <<-EOT
                                Minimum consecutive successes for the probe to be considered successful after having failed.
                                Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "tcpSocket" = {
                                "description" = "TCPSocket specifies a connection to a TCP port."
                                "properties" = {
                                  "host" = {
                                    "description" = "Optional: Host name to connect to, defaults to the pod IP."
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = <<-EOT
                                    Number or name of the port to access on the container.
                                    Number must be in the range 1 to 65535.
                                    Name must be an IANA_SVC_NAME.
                                    EOT
                                    "x-kubernetes-int-or-string" = true
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "terminationGracePeriodSeconds" = {
                                "description" = <<-EOT
                                Optional duration in seconds the pod needs to terminate gracefully upon probe failure.
                                The grace period is the duration in seconds after the processes running in the pod are sent
                                a termination signal and the time when the processes are forcibly halted with a kill signal.
                                Set this value longer than the expected cleanup time for your process.
                                If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this
                                value overrides the value provided by the pod spec.
                                Value must be non-negative integer. The value zero indicates stop immediately via
                                the kill signal (no opportunity to shut down).
                                This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.
                                Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "timeoutSeconds" = {
                                "description" = <<-EOT
                                Number of seconds after which the probe times out.
                                Defaults to 1 second. Minimum value is 1.
                                More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                            }
                            "type" = "object"
                          }
                          "name" = {
                            "description" = <<-EOT
                            Name of the container specified as a DNS_LABEL.
                            Each container in a pod must have a unique name (DNS_LABEL).
                            Cannot be updated.
                            EOT
                            "type" = "string"
                          }
                          "ports" = {
                            "description" = <<-EOT
                            List of ports to expose from the container. Not specifying a port here
                            DOES NOT prevent that port from being exposed. Any port which is
                            listening on the default "0.0.0.0" address inside a container will be
                            accessible from the network.
                            Modifying this array with strategic merge patch may corrupt the data.
                            For more information See https://github.com/kubernetes/kubernetes/issues/108255.
                            Cannot be updated.
                            EOT
                            "items" = {
                              "description" = "ContainerPort represents a network port in a single container."
                              "properties" = {
                                "containerPort" = {
                                  "description" = <<-EOT
                                  Number of port to expose on the pod's IP address.
                                  This must be a valid port number, 0 < x < 65536.
                                  EOT
                                  "format" = "int32"
                                  "type" = "integer"
                                }
                                "hostIP" = {
                                  "description" = "What host IP to bind the external port to."
                                  "type" = "string"
                                }
                                "hostPort" = {
                                  "description" = <<-EOT
                                  Number of port to expose on the host.
                                  If specified, this must be a valid port number, 0 < x < 65536.
                                  If HostNetwork is specified, this must match ContainerPort.
                                  Most containers do not need this.
                                  EOT
                                  "format" = "int32"
                                  "type" = "integer"
                                }
                                "name" = {
                                  "description" = <<-EOT
                                  If specified, this must be an IANA_SVC_NAME and unique within the pod. Each
                                  named port in a pod must have a unique name. Name for the port that can be
                                  referred to by services.
                                  EOT
                                  "type" = "string"
                                }
                                "protocol" = {
                                  "default" = "TCP"
                                  "description" = <<-EOT
                                  Protocol for port. Must be UDP, TCP, or SCTP.
                                  Defaults to "TCP".
                                  EOT
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "containerPort",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "containerPort",
                              "protocol",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "readinessProbe" = {
                            "description" = <<-EOT
                            Periodic probe of container service readiness.
                            Container will be removed from service endpoints if the probe fails.
                            Cannot be updated.
                            More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                            EOT
                            "properties" = {
                              "exec" = {
                                "description" = "Exec specifies a command to execute in the container."
                                "properties" = {
                                  "command" = {
                                    "description" = <<-EOT
                                    Command is the command line to execute inside the container, the working directory for the
                                    command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
                                    not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
                                    a shell, you need to explicitly call out to that shell.
                                    Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
                                    EOT
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                }
                                "type" = "object"
                              }
                              "failureThreshold" = {
                                "description" = <<-EOT
                                Minimum consecutive failures for the probe to be considered failed after having succeeded.
                                Defaults to 3. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "grpc" = {
                                "description" = "GRPC specifies a GRPC HealthCheckRequest."
                                "properties" = {
                                  "mode" = {
                                    "description" = <<-EOT
                                    mode specifies the connection mode for the gRPC health probe.
                                    Set to "TLS" to use TLS without certificate verification.
                                    Set to "Plaintext" to use a plaintext (insecure) connection explicitly.
                                    If not specified, the probe uses a plaintext (insecure) connection.
                                    EOT
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "description" = "Port number of the gRPC service. Number must be in the range 1 to 65535."
                                    "format" = "int32"
                                    "type" = "integer"
                                  }
                                  "service" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Service is the name of the service to place in the gRPC HealthCheckRequest
                                    (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
                                    
                                    If this is not specified, the default behavior is defined by gRPC.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "httpGet" = {
                                "description" = "HTTPGet specifies an HTTP GET request to perform."
                                "properties" = {
                                  "host" = {
                                    "description" = <<-EOT
                                    Host name to connect to, defaults to the pod IP. You probably want to set
                                    "Host" in httpHeaders instead.
                                    EOT
                                    "type" = "string"
                                  }
                                  "httpHeaders" = {
                                    "description" = "Custom headers to set in the request. HTTP allows repeated headers."
                                    "items" = {
                                      "description" = "HTTPHeader describes a custom header to be used in HTTP probes"
                                      "properties" = {
                                        "name" = {
                                          "description" = <<-EOT
                                          The header field name.
                                          This will be canonicalized upon output, so case-variant names will be understood as the same header.
                                          EOT
                                          "type" = "string"
                                        }
                                        "value" = {
                                          "description" = "The header field value"
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "name",
                                        "value",
                                      ]
                                      "type" = "object"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "path" = {
                                    "description" = "Path to access on the HTTP server."
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = <<-EOT
                                    Name or number of the port to access on the container.
                                    Number must be in the range 1 to 65535.
                                    Name must be an IANA_SVC_NAME.
                                    EOT
                                    "x-kubernetes-int-or-string" = true
                                  }
                                  "protocol" = {
                                    "description" = <<-EOT
                                    Protocol selects the wire protocol for the probe connection.
                                    Nil defaults to HTTP/1.1.
                                    EOT
                                    "type" = "string"
                                  }
                                  "scheme" = {
                                    "description" = <<-EOT
                                    Scheme to use for connecting to the host.
                                    Defaults to HTTP.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "initialDelaySeconds" = {
                                "description" = <<-EOT
                                Number of seconds after the container has started before liveness probes are initiated.
                                More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "periodSeconds" = {
                                "description" = <<-EOT
                                How often (in seconds) to perform the probe.
                                Default to 10 seconds. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "successThreshold" = {
                                "description" = <<-EOT
                                Minimum consecutive successes for the probe to be considered successful after having failed.
                                Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "tcpSocket" = {
                                "description" = "TCPSocket specifies a connection to a TCP port."
                                "properties" = {
                                  "host" = {
                                    "description" = "Optional: Host name to connect to, defaults to the pod IP."
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = <<-EOT
                                    Number or name of the port to access on the container.
                                    Number must be in the range 1 to 65535.
                                    Name must be an IANA_SVC_NAME.
                                    EOT
                                    "x-kubernetes-int-or-string" = true
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "terminationGracePeriodSeconds" = {
                                "description" = <<-EOT
                                Optional duration in seconds the pod needs to terminate gracefully upon probe failure.
                                The grace period is the duration in seconds after the processes running in the pod are sent
                                a termination signal and the time when the processes are forcibly halted with a kill signal.
                                Set this value longer than the expected cleanup time for your process.
                                If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this
                                value overrides the value provided by the pod spec.
                                Value must be non-negative integer. The value zero indicates stop immediately via
                                the kill signal (no opportunity to shut down).
                                This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.
                                Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "timeoutSeconds" = {
                                "description" = <<-EOT
                                Number of seconds after which the probe times out.
                                Defaults to 1 second. Minimum value is 1.
                                More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                            }
                            "type" = "object"
                          }
                          "resizePolicy" = {
                            "description" = <<-EOT
                            Resources resize policy for the container.
                            This field cannot be set on ephemeral containers.
                            EOT
                            "items" = {
                              "description" = "ContainerResizePolicy represents resource resize policy for the container."
                              "properties" = {
                                "resourceName" = {
                                  "description" = <<-EOT
                                  Name of the resource to which this resource resize policy applies.
                                  Supported values: cpu, memory.
                                  EOT
                                  "type" = "string"
                                }
                                "restartPolicy" = {
                                  "description" = <<-EOT
                                  Restart policy to apply when specified resource is resized.
                                  If not specified, it defaults to NotRequired.
                                  EOT
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "resourceName",
                                "restartPolicy",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "resources" = {
                            "description" = <<-EOT
                            Compute Resources required by this container.
                            Cannot be updated.
                            More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                            EOT
                            "properties" = {
                              "claims" = {
                                "description" = <<-EOT
                                Claims lists the names of resources, defined in spec.resourceClaims,
                                that are used by this container.
                                
                                This field depends on the
                                DynamicResourceAllocation feature gate.
                                
                                This field is immutable. It can only be set for containers.
                                EOT
                                "items" = {
                                  "description" = "ResourceClaim references one entry in PodSpec.ResourceClaims."
                                  "properties" = {
                                    "name" = {
                                      "description" = <<-EOT
                                      Name must match the name of one entry in pod.spec.resourceClaims of
                                      the Pod where this field is used. It makes that resource available
                                      inside a container.
                                      EOT
                                      "type" = "string"
                                    }
                                    "request" = {
                                      "description" = <<-EOT
                                      Request is the name chosen for a request in the referenced claim.
                                      If empty, everything from the claim is made available, otherwise
                                      only the result of this request.
                                      EOT
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                                "x-kubernetes-list-map-keys" = [
                                  "name",
                                ]
                                "x-kubernetes-list-type" = "map"
                              }
                              "limits" = {
                                "additionalProperties" = {
                                  "anyOf" = [
                                    {
                                      "type" = "integer"
                                    },
                                    {
                                      "type" = "string"
                                    },
                                  ]
                                  "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                  "x-kubernetes-int-or-string" = true
                                }
                                "description" = <<-EOT
                                Limits describes the maximum amount of compute resources allowed.
                                More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                                EOT
                                "type" = "object"
                              }
                              "requests" = {
                                "additionalProperties" = {
                                  "anyOf" = [
                                    {
                                      "type" = "integer"
                                    },
                                    {
                                      "type" = "string"
                                    },
                                  ]
                                  "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                  "x-kubernetes-int-or-string" = true
                                }
                                "description" = <<-EOT
                                Requests describes the minimum amount of compute resources required.
                                If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
                                otherwise to an implementation-defined value. Requests cannot exceed Limits.
                                More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                                EOT
                                "type" = "object"
                              }
                            }
                            "type" = "object"
                          }
                          "restartPolicy" = {
                            "description" = <<-EOT
                            RestartPolicy defines the restart behavior of individual containers in a pod.
                            This overrides the pod-level restart policy. When this field is not specified,
                            the restart behavior is defined by the Pod's restart policy and the container type.
                            Additionally, setting the RestartPolicy as "Always" for the init container will
                            have the following effect:
                            this init container will be continually restarted on
                            exit until all regular containers have terminated. Once all regular
                            containers have completed, all init containers with restartPolicy "Always"
                            will be shut down. This lifecycle differs from normal init containers and
                            is often referred to as a "sidecar" container. Although this init
                            container still starts in the init container sequence, it does not wait
                            for the container to complete before proceeding to the next init
                            container. Instead, the next init container starts immediately after this
                            init container is started, or after any startupProbe has successfully
                            completed.
                            EOT
                            "type" = "string"
                          }
                          "restartPolicyRules" = {
                            "description" = <<-EOT
                            Represents a list of rules to be checked to determine if the
                            container should be restarted on exit. The rules are evaluated in
                            order. Once a rule matches a container exit condition, the remaining
                            rules are ignored. If no rule matches the container exit condition,
                            the Container-level restart policy determines the whether the container
                            is restarted or not. Constraints on the rules:
                            - At most 20 rules are allowed.
                            - Rules can have the same action.
                            - Identical rules are not forbidden in validations.
                            When rules are specified, container MUST set RestartPolicy explicitly
                            even it if matches the Pod's RestartPolicy.
                            EOT
                            "items" = {
                              "description" = "ContainerRestartRule describes how a container exit is handled."
                              "properties" = {
                                "action" = {
                                  "description" = <<-EOT
                                  Specifies the action taken on a container exit if the requirements
                                  are satisfied. The only possible value is "Restart" to restart the
                                  container.
                                  EOT
                                  "type" = "string"
                                }
                                "exitCodes" = {
                                  "description" = "Represents the exit codes to check on container exits."
                                  "properties" = {
                                    "operator" = {
                                      "description" = <<-EOT
                                      Represents the relationship between the container exit code(s) and the
                                      specified values. Possible values are:
                                      - In: the requirement is satisfied if the container exit code is in the
                                        set of specified values.
                                      - NotIn: the requirement is satisfied if the container exit code is
                                        not in the set of specified values.
                                      EOT
                                      "type" = "string"
                                    }
                                    "values" = {
                                      "description" = <<-EOT
                                      Specifies the set of values to check for container exit codes.
                                      At most 255 elements are allowed.
                                      EOT
                                      "items" = {
                                        "format" = "int32"
                                        "type" = "integer"
                                      }
                                      "type" = "array"
                                      "x-kubernetes-list-type" = "set"
                                    }
                                  }
                                  "required" = [
                                    "operator",
                                  ]
                                  "type" = "object"
                                }
                              }
                              "required" = [
                                "action",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "securityContext" = {
                            "description" = <<-EOT
                            SecurityContext defines the security options the container should be run with.
                            If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.
                            More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
                            EOT
                            "properties" = {
                              "allowPrivilegeEscalation" = {
                                "description" = <<-EOT
                                AllowPrivilegeEscalation controls whether a process can gain more
                                privileges than its parent process. This bool directly controls if
                                the no_new_privs flag will be set on the container process.
                                AllowPrivilegeEscalation is true always when the container is:
                                1) run as Privileged
                                2) has CAP_SYS_ADMIN
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "type" = "boolean"
                              }
                              "appArmorProfile" = {
                                "description" = <<-EOT
                                appArmorProfile is the AppArmor options to use by this container. If set, this profile
                                overrides the pod's appArmorProfile.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "properties" = {
                                  "localhostProfile" = {
                                    "description" = <<-EOT
                                    localhostProfile indicates a profile loaded on the node that should be used.
                                    The profile must be preconfigured on the node to work.
                                    Must match the loaded name of the profile.
                                    Must be set if and only if type is "Localhost".
                                    EOT
                                    "type" = "string"
                                  }
                                  "type" = {
                                    "description" = <<-EOT
                                    type indicates which kind of AppArmor profile will be applied.
                                    Valid options are:
                                      Localhost - a profile pre-loaded on the node.
                                      RuntimeDefault - the container runtime's default profile.
                                      Unconfined - no AppArmor enforcement.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "type",
                                ]
                                "type" = "object"
                              }
                              "capabilities" = {
                                "description" = <<-EOT
                                The capabilities to add/drop when running containers.
                                Defaults to the default set of capabilities granted by the container runtime.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "properties" = {
                                  "add" = {
                                    "description" = "Added capabilities"
                                    "items" = {
                                      "description" = "Capability represent POSIX capabilities type"
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "drop" = {
                                    "description" = "Removed capabilities"
                                    "items" = {
                                      "description" = "Capability represent POSIX capabilities type"
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                }
                                "type" = "object"
                              }
                              "privileged" = {
                                "description" = <<-EOT
                                Run container in privileged mode.
                                Processes in privileged containers are essentially equivalent to root on the host.
                                Defaults to false.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "type" = "boolean"
                              }
                              "procMount" = {
                                "description" = <<-EOT
                                procMount denotes the type of proc mount to use for the containers.
                                The default value is Default which uses the container runtime defaults for
                                readonly paths and masked paths.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "type" = "string"
                              }
                              "readOnlyRootFilesystem" = {
                                "description" = <<-EOT
                                Whether this container has a read-only root filesystem.
                                Default is false.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "type" = "boolean"
                              }
                              "runAsGroup" = {
                                "description" = <<-EOT
                                The GID to run the entrypoint of the container process.
                                Uses runtime default if unset.
                                May also be set in PodSecurityContext.  If set in both SecurityContext and
                                PodSecurityContext, the value specified in SecurityContext takes precedence.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "runAsNonRoot" = {
                                "description" = <<-EOT
                                Indicates that the container must run as a non-root user.
                                If true, the Kubelet will validate the image at runtime to ensure that it
                                does not run as UID 0 (root) and fail to start the container if it does.
                                If unset or false, no such validation will be performed.
                                May also be set in PodSecurityContext.  If set in both SecurityContext and
                                PodSecurityContext, the value specified in SecurityContext takes precedence.
                                EOT
                                "type" = "boolean"
                              }
                              "runAsUser" = {
                                "description" = <<-EOT
                                The UID to run the entrypoint of the container process.
                                Defaults to user specified in image metadata if unspecified.
                                May also be set in PodSecurityContext.  If set in both SecurityContext and
                                PodSecurityContext, the value specified in SecurityContext takes precedence.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "seLinuxOptions" = {
                                "description" = <<-EOT
                                The SELinux context to be applied to the container.
                                If unspecified, the container runtime will allocate a random SELinux context for each
                                container.  May also be set in PodSecurityContext.  If set in both SecurityContext and
                                PodSecurityContext, the value specified in SecurityContext takes precedence.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "properties" = {
                                  "level" = {
                                    "description" = "Level is SELinux level label that applies to the container."
                                    "type" = "string"
                                  }
                                  "role" = {
                                    "description" = "Role is a SELinux role label that applies to the container."
                                    "type" = "string"
                                  }
                                  "type" = {
                                    "description" = "Type is a SELinux type label that applies to the container."
                                    "type" = "string"
                                  }
                                  "user" = {
                                    "description" = "User is a SELinux user label that applies to the container."
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "seccompProfile" = {
                                "description" = <<-EOT
                                The seccomp options to use by this container. If seccomp options are
                                provided at both the pod & container level, the container options
                                override the pod options.
                                Note that this field cannot be set when spec.os.name is windows.
                                EOT
                                "properties" = {
                                  "localhostProfile" = {
                                    "description" = <<-EOT
                                    localhostProfile indicates a profile defined in a file on the node should be used.
                                    The profile must be preconfigured on the node to work.
                                    Must be a descending path, relative to the kubelet's configured seccomp profile location.
                                    Must be set if type is "Localhost". Must NOT be set for any other type.
                                    EOT
                                    "type" = "string"
                                  }
                                  "type" = {
                                    "description" = <<-EOT
                                    type indicates which kind of seccomp profile will be applied.
                                    Valid options are:
                                    
                                    Localhost - a profile defined in a file on the node should be used.
                                    RuntimeDefault - the container runtime default profile should be used.
                                    Unconfined - no profile should be applied.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "type",
                                ]
                                "type" = "object"
                              }
                              "windowsOptions" = {
                                "description" = <<-EOT
                                The Windows specific settings applied to all containers.
                                If unspecified, the options from the PodSecurityContext will be used.
                                If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                                Note that this field cannot be set when spec.os.name is linux.
                                EOT
                                "properties" = {
                                  "gmsaCredentialSpec" = {
                                    "description" = <<-EOT
                                    GMSACredentialSpec is where the GMSA admission webhook
                                    (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the
                                    GMSA credential spec named by the GMSACredentialSpecName field.
                                    EOT
                                    "type" = "string"
                                  }
                                  "gmsaCredentialSpecName" = {
                                    "description" = "GMSACredentialSpecName is the name of the GMSA credential spec to use."
                                    "type" = "string"
                                  }
                                  "hostProcess" = {
                                    "description" = <<-EOT
                                    HostProcess determines if a container should be run as a 'Host Process' container.
                                    All of a Pod's containers must have the same effective HostProcess value
                                    (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).
                                    In addition, if HostProcess is true then HostNetwork must also be set to true.
                                    EOT
                                    "type" = "boolean"
                                  }
                                  "runAsUserName" = {
                                    "description" = <<-EOT
                                    The UserName in Windows to run the entrypoint of the container process.
                                    Defaults to the user specified in image metadata if unspecified.
                                    May also be set in PodSecurityContext. If set in both SecurityContext and
                                    PodSecurityContext, the value specified in SecurityContext takes precedence.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                            }
                            "type" = "object"
                          }
                          "startupProbe" = {
                            "description" = <<-EOT
                            StartupProbe indicates that the Pod has successfully initialized.
                            If specified, no other probes are executed until this completes successfully.
                            If this probe fails, the Pod will be restarted, just as if the livenessProbe failed.
                            This can be used to provide different probe parameters at the beginning of a Pod's lifecycle,
                            when it might take a long time to load data or warm a cache, than during steady-state operation.
                            This cannot be updated.
                            More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                            EOT
                            "properties" = {
                              "exec" = {
                                "description" = "Exec specifies a command to execute in the container."
                                "properties" = {
                                  "command" = {
                                    "description" = <<-EOT
                                    Command is the command line to execute inside the container, the working directory for the
                                    command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
                                    not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
                                    a shell, you need to explicitly call out to that shell.
                                    Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
                                    EOT
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                }
                                "type" = "object"
                              }
                              "failureThreshold" = {
                                "description" = <<-EOT
                                Minimum consecutive failures for the probe to be considered failed after having succeeded.
                                Defaults to 3. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "grpc" = {
                                "description" = "GRPC specifies a GRPC HealthCheckRequest."
                                "properties" = {
                                  "mode" = {
                                    "description" = <<-EOT
                                    mode specifies the connection mode for the gRPC health probe.
                                    Set to "TLS" to use TLS without certificate verification.
                                    Set to "Plaintext" to use a plaintext (insecure) connection explicitly.
                                    If not specified, the probe uses a plaintext (insecure) connection.
                                    EOT
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "description" = "Port number of the gRPC service. Number must be in the range 1 to 65535."
                                    "format" = "int32"
                                    "type" = "integer"
                                  }
                                  "service" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Service is the name of the service to place in the gRPC HealthCheckRequest
                                    (see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
                                    
                                    If this is not specified, the default behavior is defined by gRPC.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "httpGet" = {
                                "description" = "HTTPGet specifies an HTTP GET request to perform."
                                "properties" = {
                                  "host" = {
                                    "description" = <<-EOT
                                    Host name to connect to, defaults to the pod IP. You probably want to set
                                    "Host" in httpHeaders instead.
                                    EOT
                                    "type" = "string"
                                  }
                                  "httpHeaders" = {
                                    "description" = "Custom headers to set in the request. HTTP allows repeated headers."
                                    "items" = {
                                      "description" = "HTTPHeader describes a custom header to be used in HTTP probes"
                                      "properties" = {
                                        "name" = {
                                          "description" = <<-EOT
                                          The header field name.
                                          This will be canonicalized upon output, so case-variant names will be understood as the same header.
                                          EOT
                                          "type" = "string"
                                        }
                                        "value" = {
                                          "description" = "The header field value"
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "name",
                                        "value",
                                      ]
                                      "type" = "object"
                                    }
                                    "type" = "array"
                                    "x-kubernetes-list-type" = "atomic"
                                  }
                                  "path" = {
                                    "description" = "Path to access on the HTTP server."
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = <<-EOT
                                    Name or number of the port to access on the container.
                                    Number must be in the range 1 to 65535.
                                    Name must be an IANA_SVC_NAME.
                                    EOT
                                    "x-kubernetes-int-or-string" = true
                                  }
                                  "protocol" = {
                                    "description" = <<-EOT
                                    Protocol selects the wire protocol for the probe connection.
                                    Nil defaults to HTTP/1.1.
                                    EOT
                                    "type" = "string"
                                  }
                                  "scheme" = {
                                    "description" = <<-EOT
                                    Scheme to use for connecting to the host.
                                    Defaults to HTTP.
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "initialDelaySeconds" = {
                                "description" = <<-EOT
                                Number of seconds after the container has started before liveness probes are initiated.
                                More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "periodSeconds" = {
                                "description" = <<-EOT
                                How often (in seconds) to perform the probe.
                                Default to 10 seconds. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "successThreshold" = {
                                "description" = <<-EOT
                                Minimum consecutive successes for the probe to be considered successful after having failed.
                                Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "tcpSocket" = {
                                "description" = "TCPSocket specifies a connection to a TCP port."
                                "properties" = {
                                  "host" = {
                                    "description" = "Optional: Host name to connect to, defaults to the pod IP."
                                    "type" = "string"
                                  }
                                  "port" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "description" = <<-EOT
                                    Number or name of the port to access on the container.
                                    Number must be in the range 1 to 65535.
                                    Name must be an IANA_SVC_NAME.
                                    EOT
                                    "x-kubernetes-int-or-string" = true
                                  }
                                }
                                "required" = [
                                  "port",
                                ]
                                "type" = "object"
                              }
                              "terminationGracePeriodSeconds" = {
                                "description" = <<-EOT
                                Optional duration in seconds the pod needs to terminate gracefully upon probe failure.
                                The grace period is the duration in seconds after the processes running in the pod are sent
                                a termination signal and the time when the processes are forcibly halted with a kill signal.
                                Set this value longer than the expected cleanup time for your process.
                                If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this
                                value overrides the value provided by the pod spec.
                                Value must be non-negative integer. The value zero indicates stop immediately via
                                the kill signal (no opportunity to shut down).
                                This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.
                                Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "timeoutSeconds" = {
                                "description" = <<-EOT
                                Number of seconds after which the probe times out.
                                Defaults to 1 second. Minimum value is 1.
                                More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                            }
                            "type" = "object"
                          }
                          "stdin" = {
                            "description" = <<-EOT
                            Whether this container should allocate a buffer for stdin in the container runtime. If this
                            is not set, reads from stdin in the container will always result in EOF.
                            Default is false.
                            EOT
                            "type" = "boolean"
                          }
                          "stdinOnce" = {
                            "description" = <<-EOT
                            Whether the container runtime should close the stdin channel after it has been opened by
                            a single attach. When stdin is true the stdin stream will remain open across multiple attach
                            sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the
                            first client attaches to stdin, and then remains open and accepts data until the client disconnects,
                            at which time stdin is closed and remains closed until the container is restarted. If this
                            flag is false, a container processes that reads from stdin will never receive an EOF.
                            Default is false
                            EOT
                            "type" = "boolean"
                          }
                          "terminationMessagePath" = {
                            "description" = <<-EOT
                            Optional: Path at which the file to which the container's termination message
                            will be written is mounted into the container's filesystem.
                            Message written is intended to be brief final status, such as an assertion failure message.
                            Will be truncated by the node if greater than 4096 bytes. The total message length across
                            all containers will be limited to 12kb.
                            Defaults to /dev/termination-log.
                            Cannot be updated.
                            EOT
                            "type" = "string"
                          }
                          "terminationMessagePolicy" = {
                            "description" = <<-EOT
                            Indicate how the termination message should be populated. File will use the contents of
                            terminationMessagePath to populate the container status message on both success and failure.
                            FallbackToLogsOnError will use the last chunk of container log output if the termination
                            message file is empty and the container exited with an error.
                            The log output is limited to 2048 bytes or 80 lines, whichever is smaller.
                            Defaults to File.
                            Cannot be updated.
                            EOT
                            "type" = "string"
                          }
                          "tty" = {
                            "description" = <<-EOT
                            Whether this container should allocate a TTY for itself, also requires 'stdin' to be true.
                            Default is false.
                            EOT
                            "type" = "boolean"
                          }
                          "volumeDevices" = {
                            "description" = "volumeDevices is the list of block devices to be used by the container."
                            "items" = {
                              "description" = "volumeDevice describes a mapping of a raw block device within a container."
                              "properties" = {
                                "devicePath" = {
                                  "description" = "devicePath is the path inside of the container that the device will be mapped to."
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "name must match the name of a persistentVolumeClaim in the pod"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "devicePath",
                                "name",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "devicePath",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "volumeMounts" = {
                            "description" = <<-EOT
                            Pod volumes to mount into the container's filesystem.
                            Cannot be updated.
                            EOT
                            "items" = {
                              "description" = "VolumeMount describes a mounting of a Volume within a container."
                              "properties" = {
                                "bindMountOptions" = {
                                  "description" = <<-EOT
                                  bindMountOptions is the list of additional bind mount options to apply when
                                  mounting this volume into the container. Allowed values are noexec,
                                  nodev, and nosuid. These are Linux mount options and have no effect on
                                  Windows nodes.
                                  This field is not supported with image volumes.
                                  This is an alpha field and requires enabling the VolumeBindMountOptions feature gate.
                                  EOT
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                  "x-kubernetes-list-type" = "set"
                                }
                                "mountPath" = {
                                  "description" = "Path within the container at which the volume should be mounted."
                                  "type" = "string"
                                }
                                "mountPropagation" = {
                                  "description" = <<-EOT
                                  mountPropagation determines how mounts are propagated from the host
                                  to container and the other way around.
                                  When not set, MountPropagationNone is used.
                                  This field is beta in 1.10.
                                  When RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation must be None or unspecified
                                  (which defaults to None).
                                  EOT
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "This must match the Name of a Volume."
                                  "type" = "string"
                                }
                                "readOnly" = {
                                  "description" = <<-EOT
                                  Mounted read-only if true, read-write otherwise (false or unspecified).
                                  Defaults to false.
                                  EOT
                                  "type" = "boolean"
                                }
                                "recursiveReadOnly" = {
                                  "description" = <<-EOT
                                  RecursiveReadOnly specifies whether read-only mounts should be handled
                                  recursively.
                                  
                                  If ReadOnly is false, this field has no meaning and must be unspecified.
                                  
                                  If ReadOnly is true, and this field is set to Disabled, the mount is not made
                                  recursively read-only.  If this field is set to IfPossible, the mount is made
                                  recursively read-only, if it is supported by the container runtime.  If this
                                  field is set to Enabled, the mount is made recursively read-only if it is
                                  supported by the container runtime, otherwise the pod will not be started and
                                  an error will be generated to indicate the reason.
                                  
                                  If this field is set to IfPossible or Enabled, MountPropagation must be set to
                                  None (or be unspecified, which defaults to None).
                                  
                                  If this field is not specified, it is treated as an equivalent of Disabled.
                                  EOT
                                  "type" = "string"
                                }
                                "subPath" = {
                                  "description" = <<-EOT
                                  Path within the volume from which the container's volume should be mounted.
                                  Defaults to "" (volume's root).
                                  EOT
                                  "type" = "string"
                                }
                                "subPathExpr" = {
                                  "description" = <<-EOT
                                  Expanded path within the volume from which the container's volume should be mounted.
                                  Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment.
                                  Defaults to "" (volume's root).
                                  SubPathExpr and SubPath are mutually exclusive.
                                  EOT
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "mountPath",
                                "name",
                              ]
                              "type" = "object"
                            }
                            "type" = "array"
                            "x-kubernetes-list-map-keys" = [
                              "mountPath",
                            ]
                            "x-kubernetes-list-type" = "map"
                          }
                          "workingDir" = {
                            "description" = <<-EOT
                            Container's working directory.
                            If not specified, the container runtime's default will be used, which
                            might be configured in the container image.
                            Cannot be updated.
                            EOT
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "keepDroppedTargets" = {
                      "description" = <<-EOT
                      keepDroppedTargets defines the per-scrape limit on the number of targets dropped by relabeling
                      that will be kept in memory. 0 means no limit.
                      
                      It requires Prometheus >= v2.47.0.
                      
                      Note that the global limit only applies to scrape objects that don't specify an explicit limit value.
                      If you want to enforce a maximum limit for all scrape objects, refer to enforcedKeepDroppedTargets.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "labelLimit" = {
                      "description" = <<-EOT
                      labelLimit defines per-scrape limit on number of labels that will be accepted for a sample.
                      Only valid in Prometheus versions 2.45.0 and newer.
                      
                      Note that the global limit only applies to scrape objects that don't specify an explicit limit value.
                      If you want to enforce a maximum limit for all scrape objects, refer to enforcedLabelLimit.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "labelNameLengthLimit" = {
                      "description" = <<-EOT
                      labelNameLengthLimit defines the per-scrape limit on length of labels name that will be accepted for a sample.
                      Only valid in Prometheus versions 2.45.0 and newer.
                      
                      Note that the global limit only applies to scrape objects that don't specify an explicit limit value.
                      If you want to enforce a maximum limit for all scrape objects, refer to enforcedLabelNameLengthLimit.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "labelValueLengthLimit" = {
                      "description" = <<-EOT
                      labelValueLengthLimit defines the per-scrape limit on length of labels value that will be accepted for a sample.
                      Only valid in Prometheus versions 2.45.0 and newer.
                      
                      Note that the global limit only applies to scrape objects that don't specify an explicit limit value.
                      If you want to enforce a maximum limit for all scrape objects, refer to enforcedLabelValueLengthLimit.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "listenLocal" = {
                      "description" = <<-EOT
                      listenLocal when true, the Prometheus server listens on the loopback address
                      instead of the Pod IP's address.
                      EOT
                      "type" = "boolean"
                    }
                    "logFormat" = {
                      "description" = "logFormat for Log level for Prometheus and the config-reloader sidecar."
                      "enum" = [
                        "",
                        "logfmt",
                        "json",
                      ]
                      "type" = "string"
                    }
                    "logLevel" = {
                      "description" = "logLevel for Prometheus and the config-reloader sidecar."
                      "enum" = [
                        "",
                        "debug",
                        "info",
                        "warn",
                        "error",
                      ]
                      "type" = "string"
                    }
                    "maximumStartupDurationSeconds" = {
                      "description" = <<-EOT
                      maximumStartupDurationSeconds defines the maximum time that the `prometheus` container's startup probe will wait before being considered failed. The startup probe will return success after the WAL replay is complete.
                      If set, the value should be greater than 60 (seconds). Otherwise it will be equal to 900 seconds (15 minutes).
                      EOT
                      "format" = "int32"
                      "minimum" = 60
                      "type" = "integer"
                    }
                    "minReadySeconds" = {
                      "description" = <<-EOT
                      minReadySeconds defines the minimum number of seconds for which a newly created Pod should be ready
                      without any of its container crashing for it to be considered available.
                      
                      If unset, pods will be considered available as soon as they are ready.
                      EOT
                      "format" = "int32"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "mode" = {
                      "description" = <<-EOT
                      mode defines how the Prometheus operator deploys the PrometheusAgent pod(s).
                      
                      (Alpha) Using this field requires the `PrometheusAgentDaemonSet` feature gate to be enabled.
                      EOT
                      "enum" = [
                        "StatefulSet",
                        "DaemonSet",
                      ]
                      "type" = "string"
                    }
                    "nameEscapingScheme" = {
                      "description" = <<-EOT
                      nameEscapingScheme defines the character escaping scheme that will be requested when scraping
                      for metric and label names that do not conform to the legacy Prometheus
                      character set.
                      
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
                      
                      It requires Prometheus >= v2.55.0.
                      EOT
                      "enum" = [
                        "UTF8",
                        "Legacy",
                      ]
                      "type" = "string"
                    }
                    "nodeSelector" = {
                      "additionalProperties" = {
                        "type" = "string"
                      }
                      "description" = "nodeSelector defines on which Nodes the Pods are scheduled."
                      "type" = "object"
                    }
                    "otlp" = {
                      "description" = <<-EOT
                      otlp defines the settings related to the OTLP receiver feature.
                      It requires Prometheus >= v2.55.0.
                      EOT
                      "properties" = {
                        "convertHistogramsToNHCB" = {
                          "description" = <<-EOT
                          convertHistogramsToNHCB defines optional translation of OTLP explicit bucket histograms into native histograms with custom buckets.
                          It requires Prometheus >= v3.4.0.
                          EOT
                          "type" = "boolean"
                        }
                        "ignoreResourceAttributes" = {
                          "description" = <<-EOT
                          ignoreResourceAttributes defines the list of OpenTelemetry resource attributes to ignore when `promoteAllResourceAttributes` is true.
                          
                          It requires `promoteAllResourceAttributes` to be true.
                          It requires Prometheus >= v3.5.0.
                          EOT
                          "items" = {
                            "minLength" = 1
                            "type" = "string"
                          }
                          "minItems" = 1
                          "type" = "array"
                          "x-kubernetes-list-type" = "set"
                        }
                        "keepIdentifyingResourceAttributes" = {
                          "description" = <<-EOT
                          keepIdentifyingResourceAttributes enables adding `service.name`, `service.namespace` and `service.instance.id`
                          resource attributes to the `target_info` metric, on top of converting them into the `instance` and `job` labels.
                          
                          It requires Prometheus >= v3.1.0.
                          EOT
                          "type" = "boolean"
                        }
                        "labelNamePreserveMultipleUnderscores" = {
                          "description" = <<-EOT
                          labelNamePreserveMultipleUnderscores enables preserving of multiple consecutive underscores in label names when translation_strategy uses
                          underscore escaping.
                          When true (default), multiple consecutive underscores are preserved during label name sanitization.
                          
                          Notice: This one has no impact if `nameEscapingScheme` is `AllowUTF8`.
                          
                          It requires Prometheus >= v3.8.0.
                          EOT
                          "type" = "boolean"
                        }
                        "labelNameUnderscoreSanitization" = {
                          "description" = <<-EOT
                          labelNameUnderscoreSanitization controls whether to enable prepending of 'key_' to labels starting with '_'.
                          Reserved labels starting with '__' are not modified.
                          This is only relevant when translation_strategy uses underscore escaping (e.g., "UnderscoreEscapingWithSuffixes" or "UnderscoreEscapingWithoutSuffixes").
                          
                          Notice: This one has no impact if `nameEscapingScheme` is `AllowUTF8`.
                          
                          It requires Prometheus >= v3.8.0.
                          EOT
                          "type" = "boolean"
                        }
                        "promoteAllResourceAttributes" = {
                          "description" = <<-EOT
                          promoteAllResourceAttributes promotes all resource attributes to metric labels except the ones defined in `ignoreResourceAttributes`.
                          
                          Cannot be true when `promoteResourceAttributes` is defined.
                          It requires Prometheus >= v3.5.0.
                          EOT
                          "type" = "boolean"
                        }
                        "promoteResourceAttributes" = {
                          "description" = <<-EOT
                          promoteResourceAttributes defines the list of OpenTelemetry Attributes that should be promoted to metric labels, defaults to none.
                          Cannot be defined when `promoteAllResourceAttributes` is true.
                          EOT
                          "items" = {
                            "minLength" = 1
                            "type" = "string"
                          }
                          "minItems" = 1
                          "type" = "array"
                          "x-kubernetes-list-type" = "set"
                        }
                        "promoteScopeMetadata" = {
                          "description" = <<-EOT
                          promoteScopeMetadata controls whether to promote OpenTelemetry scope metadata (i.e. name, version, schema URL, and attributes) to metric labels.
                          As per the OpenTelemetry specification, the aforementioned scope metadata should be identifying, i.e. made into metric labels.
                          It requires Prometheus >= v3.6.0.
                          EOT
                          "type" = "boolean"
                        }
                        "translationStrategy" = {
                          "description" = <<-EOT
                          translationStrategy defines how the OTLP receiver endpoint translates the incoming metrics.
                          
                          It requires Prometheus >= v3.0.0.
                          EOT
                          "enum" = [
                            "NoUTF8EscapingWithSuffixes",
                            "UnderscoreEscapingWithSuffixes",
                            "NoTranslation",
                            "UnderscoreEscapingWithoutSuffixes",
                          ]
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "overrideHonorLabels" = {
                      "description" = <<-EOT
                      overrideHonorLabels when true, Prometheus resolves label conflicts by renaming the labels in the scraped data
                       to “exported_” for all targets created from ServiceMonitor, PodMonitor and
                      ScrapeConfig objects. Otherwise the HonorLabels field of the service or pod monitor applies.
                      In practice,`OverrideHonorLabels:true` enforces `honorLabels:false`
                      for all ServiceMonitor, PodMonitor and ScrapeConfig objects.
                      EOT
                      "type" = "boolean"
                    }
                    "overrideHonorTimestamps" = {
                      "description" = <<-EOT
                      overrideHonorTimestamps when true, Prometheus ignores the timestamps for all the targets created
                      from service and pod monitors.
                      Otherwise the HonorTimestamps field of the service or pod monitor applies.
                      EOT
                      "type" = "boolean"
                    }
                    "paused" = {
                      "description" = <<-EOT
                      paused defines when a Prometheus deployment is paused, no actions except for deletion
                      will be performed on the underlying objects.
                      EOT
                      "type" = "boolean"
                    }
                    "persistentVolumeClaimRetentionPolicy" = {
                      "description" = <<-EOT
                      persistentVolumeClaimRetentionPolicy defines the field controls if and how PVCs are deleted during the lifecycle of a StatefulSet.
                      The default behavior is all PVCs are retained.
                      This is an alpha field from kubernetes 1.23 until 1.26 and a beta field from 1.26.
                      It requires enabling the StatefulSetAutoDeletePVC feature gate.
                      EOT
                      "properties" = {
                        "whenDeleted" = {
                          "description" = <<-EOT
                          WhenDeleted specifies what happens to PVCs created from StatefulSet
                          VolumeClaimTemplates when the StatefulSet is deleted. The default policy
                          of `Retain` causes PVCs to not be affected by StatefulSet deletion. The
                          `Delete` policy causes those PVCs to be deleted.
                          EOT
                          "type" = "string"
                        }
                        "whenScaled" = {
                          "description" = <<-EOT
                          WhenScaled specifies what happens to PVCs created from StatefulSet
                          VolumeClaimTemplates when the StatefulSet is scaled down. The default
                          policy of `Retain` causes PVCs to not be affected by a scaledown. The
                          `Delete` policy causes the associated PVCs for any excess pods above
                          the replica count to be deleted.
                          EOT
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "podManagementPolicy" = {
                      "description" = <<-EOT
                      podManagementPolicy defines the policy for creating/deleting pods when
                      scaling up and down.
                      
                      Unlike the default StatefulSet behavior, the default policy is
                      `Parallel` to avoid manual intervention in case a pod gets stuck during
                      a rollout.
                      
                      Note that updating this value implies the recreation of the StatefulSet
                      which incurs a service outage.
                      EOT
                      "enum" = [
                        "OrderedReady",
                        "Parallel",
                      ]
                      "type" = "string"
                    }
                    "podMetadata" = {
                      "description" = <<-EOT
                      podMetadata defines labels and annotations which are propagated to the Prometheus pods.
                      
                      The following items are reserved and cannot be overridden:
                      * "prometheus" label, set to the name of the Prometheus object.
                      * "app.kubernetes.io/instance" label, set to the name of the Prometheus object.
                      * "app.kubernetes.io/managed-by" label, set to "prometheus-operator".
                      * "app.kubernetes.io/name" label, set to "prometheus".
                      * "app.kubernetes.io/version" label, set to the Prometheus version.
                      * "operator.prometheus.io/name" label, set to the name of the Prometheus object.
                      * "operator.prometheus.io/shard" label, set to the shard number of the Prometheus object.
                      * "kubectl.kubernetes.io/default-container" annotation, set to "prometheus".
                      EOT
                      "properties" = {
                        "annotations" = {
                          "additionalProperties" = {
                            "type" = "string"
                          }
                          "description" = <<-EOT
                          annotations defines an unstructured key value map stored with a resource that may be
                          set by external tools to store and retrieve arbitrary metadata. They are not
                          queryable and should be preserved when modifying objects.
                          More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
                          EOT
                          "type" = "object"
                        }
                        "labels" = {
                          "additionalProperties" = {
                            "type" = "string"
                          }
                          "description" = <<-EOT
                          labels define the map of string keys and values that can be used to organize and categorize
                          (scope and select) objects. May match selectors of replication controllers
                          and services.
                          More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
                          EOT
                          "type" = "object"
                        }
                        "name" = {
                          "description" = <<-EOT
                          name must be unique within a namespace. Is required when creating resources, although
                          some resources may allow a client to request the generation of an appropriate name
                          automatically. Name is primarily intended for creation idempotence and configuration
                          definition.
                          Cannot be updated.
                          More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/
                          EOT
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "podMonitorNamespaceSelector" = {
                      "description" = <<-EOT
                      podMonitorNamespaceSelector defines the namespaces to match for PodMonitors discovery. An empty label selector
                      matches all namespaces. A null label selector (default value) matches the current
                      namespace only.
                      EOT
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
                    "podMonitorSelector" = {
                      "description" = <<-EOT
                      podMonitorSelector defines the podMonitors to be selected for target discovery. An empty label selector
                      matches all objects. A null label selector matches no objects.
                      
                      If `spec.serviceMonitorSelector`, `spec.podMonitorSelector`, `spec.probeSelector`
                      and `spec.scrapeConfigSelector` are null, the Prometheus configuration is unmanaged.
                      The Prometheus operator will ensure that the Prometheus configuration's
                      Secret exists, but it is the responsibility of the user to provide the raw
                      gzipped Prometheus configuration under the `prometheus.yaml.gz` key.
                      This behavior is *deprecated* and will be removed in the next major version
                      of the custom resource definition. It is recommended to use
                      `spec.additionalScrapeConfigs` instead.
                      EOT
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
                    "podTargetLabels" = {
                      "description" = <<-EOT
                      podTargetLabels are appended to the `spec.podTargetLabels` field of all
                      PodMonitor and ServiceMonitor objects.
                      EOT
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "portName" = {
                      "default" = "web"
                      "description" = <<-EOT
                      portName used for the pods and governing service.
                      Default: "web"
                      EOT
                      "type" = "string"
                    }
                    "priorityClassName" = {
                      "description" = "priorityClassName assigned to the Pods."
                      "type" = "string"
                    }
                    "probeNamespaceSelector" = {
                      "description" = <<-EOT
                      probeNamespaceSelector defines the namespaces to match for Probe discovery. An empty label
                      selector matches all namespaces. A null label selector matches the
                      current namespace only.
                      EOT
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
                    "probeSelector" = {
                      "description" = <<-EOT
                      probeSelector defines the probes to be selected for target discovery. An empty label selector
                      matches all objects. A null label selector matches no objects.
                      
                      If `spec.serviceMonitorSelector`, `spec.podMonitorSelector`, `spec.probeSelector`
                      and `spec.scrapeConfigSelector` are null, the Prometheus configuration is unmanaged.
                      The Prometheus operator will ensure that the Prometheus configuration's
                      Secret exists, but it is the responsibility of the user to provide the raw
                      gzipped Prometheus configuration under the `prometheus.yaml.gz` key.
                      This behavior is *deprecated* and will be removed in the next major version
                      of the custom resource definition. It is recommended to use
                      `spec.additionalScrapeConfigs` instead.
                      EOT
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
                    "prometheusExternalLabelName" = {
                      "description" = <<-EOT
                      prometheusExternalLabelName defines the name of Prometheus external label used to denote the Prometheus instance
                      name. The external label will _not_ be added when the field is set to
                      the empty string (`""`).
                      
                      Default: "prometheus"
                      EOT
                      "type" = "string"
                    }
                    "reloadStrategy" = {
                      "description" = <<-EOT
                      reloadStrategy defines the strategy used to reload the Prometheus configuration.
                      If not specified, the configuration is reloaded using the /-/reload HTTP endpoint.
                      EOT
                      "enum" = [
                        "HTTP",
                        "ProcessSignal",
                      ]
                      "type" = "string"
                    }
                    "remoteWrite" = {
                      "description" = "remoteWrite defines the list of remote write configurations."
                      "items" = {
                        "description" = <<-EOT
                        RemoteWriteSpec defines the configuration to write samples from Prometheus
                        to a remote endpoint.
                        EOT
                        "properties" = {
                          "authorization" = {
                            "description" = <<-EOT
                            authorization section for the URL.
                            
                            It requires Prometheus >= v2.26.0 or Thanos >= v0.24.0.
                            
                            Cannot be set at the same time as `sigv4`, `basicAuth`, `oauth2`, or `azureAd`.
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
                              "credentialsFile" = {
                                "description" = "credentialsFile defines the file to read a secret from, mutually exclusive with `credentials`."
                                "type" = "string"
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
                          "azureAd" = {
                            "description" = <<-EOT
                            azureAd for the URL.
                            
                            It requires Prometheus >= v2.45.0 or Thanos >= v0.31.0.
                            
                            Cannot be set at the same time as `authorization`, `basicAuth`, `oauth2`, or `sigv4`.
                            EOT
                            "properties" = {
                              "cloud" = {
                                "description" = "cloud defines the Azure Cloud. Options are 'AzurePublic', 'AzureChina', or 'AzureGovernment'."
                                "enum" = [
                                  "AzureChina",
                                  "AzureGovernment",
                                  "AzurePublic",
                                ]
                                "type" = "string"
                              }
                              "managedIdentity" = {
                                "description" = <<-EOT
                                managedIdentity defines the Azure User-assigned Managed identity.
                                Cannot be set at the same time as `oauth`, `sdk` or `workloadIdentity`.
                                EOT
                                "properties" = {
                                  "clientId" = {
                                    "description" = <<-EOT
                                    clientId defines the Azure User-assigned Managed identity.
                                    
                                    For Prometheus >= 3.5.0 and Thanos >= 0.40.0, this field is allowed to be empty to support system-assigned managed identities.
                                    EOT
                                    "minLength" = 1
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "oauth" = {
                                "description" = <<-EOT
                                oauth defines the oauth config that is being used to authenticate.
                                Cannot be set at the same time as `managedIdentity`, `sdk` or `workloadIdentity`.
                                
                                It requires Prometheus >= v2.48.0 or Thanos >= v0.31.0.
                                EOT
                                "properties" = {
                                  "clientId" = {
                                    "description" = "clientId defines the clientId of the Azure Active Directory application that is being used to authenticate."
                                    "minLength" = 1
                                    "type" = "string"
                                  }
                                  "clientSecret" = {
                                    "description" = "clientSecret specifies a key of a Secret containing the client secret of the Azure Active Directory application that is being used to authenticate."
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
                                  "tenantId" = {
                                    "description" = "tenantId is the tenant ID of the Azure Active Directory application that is being used to authenticate."
                                    "minLength" = 1
                                    "pattern" = "^[0-9a-zA-Z-.]+$"
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "clientId",
                                  "clientSecret",
                                  "tenantId",
                                ]
                                "type" = "object"
                              }
                              "scope" = {
                                "description" = <<-EOT
                                scope is the custom OAuth 2.0 scope to request when acquiring tokens.
                                It requires Prometheus >= 3.9.0. Currently not supported by Thanos.
                                EOT
                                "pattern" = "^[\\w\\s:/.\\\\-]+$"
                                "type" = "string"
                              }
                              "sdk" = {
                                "description" = <<-EOT
                                sdk defines the Azure SDK config that is being used to authenticate.
                                See https://learn.microsoft.com/en-us/azure/developer/go/azure-sdk-authentication
                                Cannot be set at the same time as `oauth`, `managedIdentity` or `workloadIdentity`.
                                
                                It requires Prometheus >= v2.52.0 or Thanos >= v0.36.0.
                                EOT
                                "properties" = {
                                  "tenantId" = {
                                    "description" = "tenantId defines the tenant ID of the azure active directory application that is being used to authenticate."
                                    "pattern" = "^[0-9a-zA-Z-.]+$"
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "workloadIdentity" = {
                                "description" = <<-EOT
                                workloadIdentity defines the Azure Workload Identity authentication.
                                Cannot be set at the same time as `oauth`, `managedIdentity`, or `sdk`.
                                
                                It requires Prometheus >= 3.7.0. Currently not supported by Thanos.
                                EOT
                                "properties" = {
                                  "clientId" = {
                                    "description" = "clientId is the clientID of the Azure Active Directory application."
                                    "minLength" = 1
                                    "type" = "string"
                                  }
                                  "tenantId" = {
                                    "description" = "tenantId is the tenant ID of the Azure Active Directory application."
                                    "minLength" = 1
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "clientId",
                                  "tenantId",
                                ]
                                "type" = "object"
                              }
                            }
                            "type" = "object"
                          }
                          "basicAuth" = {
                            "description" = <<-EOT
                            basicAuth configuration for the URL.
                            
                            Cannot be set at the same time as `sigv4`, `authorization`, `oauth2`, or `azureAd`.
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
                          "bearerToken" = {
                            "description" = <<-EOT
                            bearerToken is deprecated: this will be removed in a future release.
                            *Warning: this field shouldn't be used because the token value appears
                            in clear-text. Prefer using `authorization`.*
                            EOT
                            "type" = "string"
                          }
                          "bearerTokenFile" = {
                            "description" = <<-EOT
                            bearerTokenFile defines the file from which to read bearer token for the URL.
                            
                            Deprecated: this will be removed in a future release. Prefer using `authorization`.
                            EOT
                            "type" = "string"
                          }
                          "enableHTTP2" = {
                            "description" = "enableHTTP2 defines whether to enable HTTP2."
                            "type" = "boolean"
                          }
                          "followRedirects" = {
                            "description" = <<-EOT
                            followRedirects defines whether HTTP requests follow HTTP 3xx redirects.
                            
                            It requires Prometheus >= v2.26.0 or Thanos >= v0.24.0.
                            EOT
                            "type" = "boolean"
                          }
                          "headers" = {
                            "additionalProperties" = {
                              "type" = "string"
                            }
                            "description" = <<-EOT
                            headers defines the custom HTTP headers to be sent along with each remote write request.
                            Be aware that headers that are set by Prometheus itself can't be overwritten.
                            
                            It requires Prometheus >= v2.25.0 or Thanos >= v0.24.0.
                            EOT
                            "type" = "object"
                          }
                          "messageVersion" = {
                            "description" = <<-EOT
                            messageVersion defines the Remote Write message's version to use when writing to the endpoint.
                            
                            `Version1.0` corresponds to the `prometheus.WriteRequest` protobuf message introduced in Remote Write 1.0.
                            `Version2.0` corresponds to the `io.prometheus.write.v2.Request` protobuf message introduced in Remote Write 2.0.
                            
                            When `Version2.0` is selected, Prometheus will automatically be
                            configured to append the metadata of scraped metrics to the WAL.
                            
                            Before setting this field, consult with your remote storage provider
                            what message version it supports.
                            
                            It requires Prometheus >= v2.54.0 or Thanos >= v0.37.0.
                            EOT
                            "enum" = [
                              "V1.0",
                              "V2.0",
                            ]
                            "type" = "string"
                          }
                          "metadataConfig" = {
                            "description" = <<-EOT
                            metadataConfig defines how to send a series metadata to the remote storage.
                            
                            When the field is empty, **no metadata** is sent. But when the field is
                            null, metadata is sent.
                            EOT
                            "properties" = {
                              "maxSamplesPerSend" = {
                                "description" = <<-EOT
                                maxSamplesPerSend defines the maximum number of metadata samples per send.
                                
                                It requires Prometheus >= v2.29.0.
                                EOT
                                "format" = "int32"
                                "minimum" = -1
                                "type" = "integer"
                              }
                              "send" = {
                                "description" = <<-EOT
                                send defines whether metric metadata is sent to the remote storage or not.
                                
                                The setting is ignored when Remote Write message's version 2.0 is used.
                                EOT
                                "type" = "boolean"
                              }
                              "sendInterval" = {
                                "description" = "sendInterval defines how frequently metric metadata is sent to the remote storage."
                                "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "name" = {
                            "description" = <<-EOT
                            name of the remote write queue, it must be unique if specified. The
                            name is used in metrics and logging in order to differentiate queues.
                            
                            It requires Prometheus >= v2.15.0 or Thanos >= 0.24.0.
                            EOT
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
                            oauth2 configuration for the URL.
                            
                            It requires Prometheus >= v2.27.0 or Thanos >= v0.24.0.
                            
                            Cannot be set at the same time as `sigv4`, `authorization`, `basicAuth`, or `azureAd`.
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
                          "queueConfig" = {
                            "description" = "queueConfig allows tuning of the remote write queue parameters."
                            "properties" = {
                              "batchSendDeadline" = {
                                "description" = "batchSendDeadline defines the maximum time a sample will wait in buffer."
                                "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                                "type" = "string"
                              }
                              "capacity" = {
                                "description" = <<-EOT
                                capacity defines the number of samples to buffer per shard before we start
                                dropping them.
                                EOT
                                "type" = "integer"
                              }
                              "maxBackoff" = {
                                "description" = "maxBackoff defines the maximum retry delay."
                                "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                                "type" = "string"
                              }
                              "maxRetries" = {
                                "description" = "maxRetries defines the maximum number of times to retry a batch on recoverable errors."
                                "type" = "integer"
                              }
                              "maxSamplesPerSend" = {
                                "description" = "maxSamplesPerSend defines the maximum number of samples per send."
                                "type" = "integer"
                              }
                              "maxShards" = {
                                "description" = "maxShards defines the maximum number of shards, i.e. amount of concurrency."
                                "type" = "integer"
                              }
                              "minBackoff" = {
                                "description" = "minBackoff defines the initial retry delay. Gets doubled for every retry."
                                "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                                "type" = "string"
                              }
                              "minShards" = {
                                "description" = "minShards defines the minimum number of shards, i.e. amount of concurrency."
                                "type" = "integer"
                              }
                              "retryOnRateLimit" = {
                                "description" = <<-EOT
                                retryOnRateLimit defines the retry upon receiving a 429 status code from the remote-write storage.
                                
                                This is an *experimental feature*, it may change in any upcoming release
                                in a breaking way.
                                EOT
                                "type" = "boolean"
                              }
                              "sampleAgeLimit" = {
                                "description" = <<-EOT
                                sampleAgeLimit drops samples older than the limit.
                                It requires Prometheus >= v2.50.0 or Thanos >= v0.32.0.
                                EOT
                                "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "remoteTimeout" = {
                            "description" = "remoteTimeout defines the timeout for requests to the remote write endpoint."
                            "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                            "type" = "string"
                          }
                          "roundRobinDNS" = {
                            "description" = <<-EOT
                            roundRobinDNS controls the DNS resolution behavior for remote-write connections.
                            When enabled:
                              - The remote-write mechanism will resolve the hostname via DNS.
                              - It will randomly select one of the resolved IP addresses and connect to it.
                            
                            When disabled (default behavior):
                              - The Go standard library will handle hostname resolution.
                              - It will attempt connections to each resolved IP address sequentially.
                            
                            Note: The connection timeout applies to the entire resolution and connection process.
                            
                            	If disabled, the timeout is distributed across all connection attempts.
                            
                            It requires Prometheus >= v3.1.0 or Thanos >= v0.38.0.
                            EOT
                            "type" = "boolean"
                          }
                          "sendExemplars" = {
                            "description" = <<-EOT
                            sendExemplars enables sending of exemplars over remote write. Note that
                            exemplar-storage itself must be enabled using the `spec.enableFeatures`
                            option for exemplars to be scraped in the first place.
                            
                            It requires Prometheus >= v2.27.0 or Thanos >= v0.24.0.
                            EOT
                            "type" = "boolean"
                          }
                          "sendNativeHistograms" = {
                            "description" = <<-EOT
                            sendNativeHistograms enables sending of native histograms, also known as sparse histograms
                            over remote write.
                            
                            It requires Prometheus >= v2.40.0 or Thanos >= v0.30.0.
                            EOT
                            "type" = "boolean"
                          }
                          "sigv4" = {
                            "description" = <<-EOT
                            sigv4 defines the AWS's Signature Verification 4 for the URL.
                            
                            It requires Prometheus >= v2.26.0 or Thanos >= v0.24.0.
                            
                            Cannot be set at the same time as `authorization`, `basicAuth`, `oauth2`, or `azureAd`.
                            EOT
                            "properties" = {
                              "accessKey" = {
                                "description" = <<-EOT
                                accessKey defines the AWS API key. If not specified, the environment variable
                                `AWS_ACCESS_KEY_ID` is used.
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
                              "externalId" = {
                                "description" = <<-EOT
                                externalId defines the external ID used when assuming an AWS role. Can only be used with roleArn.
                                It requires Prometheus >= v3.11.0 or Alertmanager >= v0.34.0. Currently not supported by Thanos.
                                EOT
                                "minLength" = 1
                                "type" = "string"
                              }
                              "profile" = {
                                "description" = "profile defines the named AWS profile used to authenticate."
                                "type" = "string"
                              }
                              "region" = {
                                "description" = "region defines the AWS region. If blank, the region from the default credentials chain used."
                                "type" = "string"
                              }
                              "roleArn" = {
                                "description" = "roleArn defines the named AWS profile used to authenticate."
                                "type" = "string"
                              }
                              "secretKey" = {
                                "description" = <<-EOT
                                secretKey defines the AWS API secret. If not specified, the environment
                                variable `AWS_SECRET_ACCESS_KEY` is used.
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
                              "useFIPSSTSEndpoint" = {
                                "description" = <<-EOT
                                useFIPSSTSEndpoint defines the FIPS mode for the AWS STS endpoint.
                                It requires Prometheus >= v2.54.0.
                                EOT
                                "type" = "boolean"
                              }
                            }
                            "type" = "object"
                            "x-kubernetes-validations" = [
                              {
                                "message" = "externalId can only be used when roleArn is specified"
                                "rule" = "!has(self.externalId) || has(self.roleArn)"
                              },
                            ]
                          }
                          "tlsConfig" = {
                            "description" = "tlsConfig to use for the URL."
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
                              "caFile" = {
                                "description" = "caFile defines the path to the CA cert in the Prometheus container to use for the targets."
                                "type" = "string"
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
                              "certFile" = {
                                "description" = "certFile defines the path to the client cert file in the Prometheus container for the targets."
                                "type" = "string"
                              }
                              "insecureSkipVerify" = {
                                "description" = "insecureSkipVerify defines how to disable target certificate validation."
                                "type" = "boolean"
                              }
                              "keyFile" = {
                                "description" = "keyFile defines the path to the client key file in the Prometheus container for the targets."
                                "type" = "string"
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
                            "description" = <<-EOT
                            url defines the URL of the endpoint to send samples to.
                            
                            It must use the HTTP or HTTPS scheme.
                            EOT
                            "pattern" = "^(http|https)://.+$"
                            "type" = "string"
                          }
                          "writeRelabelConfigs" = {
                            "description" = "writeRelabelConfigs defines the list of remote write relabel configurations."
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
                        }
                        "required" = [
                          "url",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "remoteWriteReceiverMessageVersions" = {
                      "description" = <<-EOT
                      remoteWriteReceiverMessageVersions list of the protobuf message versions to accept when receiving the
                      remote writes.
                      
                      It requires Prometheus >= v2.54.0.
                      EOT
                      "items" = {
                        "enum" = [
                          "V1.0",
                          "V2.0",
                        ]
                        "type" = "string"
                      }
                      "minItems" = 1
                      "type" = "array"
                      "x-kubernetes-list-type" = "set"
                    }
                    "replicaExternalLabelName" = {
                      "description" = <<-EOT
                      replicaExternalLabelName defines the name of Prometheus external label used to denote the replica name.
                      The external label will _not_ be added when the field is set to the
                      empty string (`""`).
                      
                      Default: "prometheus_replica"
                      EOT
                      "type" = "string"
                    }
                    "replicas" = {
                      "description" = <<-EOT
                      replicas defines the number of replicas of each shard to deploy for a Prometheus deployment.
                      `spec.replicas` multiplied by `spec.shards` is the total number of Pods
                      created.
                      
                      Default: 1
                      EOT
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "resources" = {
                      "description" = "resources defines the resources requests and limits of the 'prometheus' container."
                      "properties" = {
                        "claims" = {
                          "description" = <<-EOT
                          Claims lists the names of resources, defined in spec.resourceClaims,
                          that are used by this container.
                          
                          This field depends on the
                          DynamicResourceAllocation feature gate.
                          
                          This field is immutable. It can only be set for containers.
                          EOT
                          "items" = {
                            "description" = "ResourceClaim references one entry in PodSpec.ResourceClaims."
                            "properties" = {
                              "name" = {
                                "description" = <<-EOT
                                Name must match the name of one entry in pod.spec.resourceClaims of
                                the Pod where this field is used. It makes that resource available
                                inside a container.
                                EOT
                                "type" = "string"
                              }
                              "request" = {
                                "description" = <<-EOT
                                Request is the name chosen for a request in the referenced claim.
                                If empty, everything from the claim is made available, otherwise
                                only the result of this request.
                                EOT
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "name",
                            ]
                            "type" = "object"
                          }
                          "type" = "array"
                          "x-kubernetes-list-map-keys" = [
                            "name",
                          ]
                          "x-kubernetes-list-type" = "map"
                        }
                        "limits" = {
                          "additionalProperties" = {
                            "anyOf" = [
                              {
                                "type" = "integer"
                              },
                              {
                                "type" = "string"
                              },
                            ]
                            "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                            "x-kubernetes-int-or-string" = true
                          }
                          "description" = <<-EOT
                          Limits describes the maximum amount of compute resources allowed.
                          More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                          EOT
                          "type" = "object"
                        }
                        "requests" = {
                          "additionalProperties" = {
                            "anyOf" = [
                              {
                                "type" = "integer"
                              },
                              {
                                "type" = "string"
                              },
                            ]
                            "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                            "x-kubernetes-int-or-string" = true
                          }
                          "description" = <<-EOT
                          Requests describes the minimum amount of compute resources required.
                          If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
                          otherwise to an implementation-defined value. Requests cannot exceed Limits.
                          More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                          EOT
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "routePrefix" = {
                      "description" = <<-EOT
                      routePrefix defines the route prefix Prometheus registers HTTP handlers for.
                      
                      This is useful when using `spec.externalURL`, and a proxy is rewriting
                      HTTP routes of a request, and the actual ExternalURL is still true, but
                      the server serves requests under a different route prefix. For example
                      for use with `kubectl proxy`.
                      EOT
                      "type" = "string"
                    }
                    "runtime" = {
                      "description" = "runtime defines the values for the Prometheus process behavior"
                      "properties" = {
                        "goGC" = {
                          "description" = <<-EOT
                          goGC defines the Go garbage collection target percentage. Lowering this number may increase the CPU usage.
                          See: https://tip.golang.org/doc/gc-guide#GOGC
                          EOT
                          "format" = "int32"
                          "minimum" = -1
                          "type" = "integer"
                        }
                      }
                      "type" = "object"
                    }
                    "sampleLimit" = {
                      "description" = <<-EOT
                      sampleLimit defines per-scrape limit on number of scraped samples that will be accepted.
                      Only valid in Prometheus versions 2.45.0 and newer.
                      
                      Note that the global limit only applies to scrape objects that don't specify an explicit limit value.
                      If you want to enforce a maximum limit for all scrape objects, refer to enforcedSampleLimit.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "schedulerName" = {
                      "description" = "schedulerName defines the scheduler to use for Pod scheduling. If not specified, the default scheduler is used."
                      "minLength" = 1
                      "type" = "string"
                    }
                    "scrapeClasses" = {
                      "description" = <<-EOT
                      scrapeClasses defines the list of scrape classes to expose to scraping objects such as
                      PodMonitors, ServiceMonitors, Probes and ScrapeConfigs.
                      
                      This is an *experimental feature*, it may change in any upcoming release
                      in a breaking way.
                      EOT
                      "items" = {
                        "properties" = {
                          "attachMetadata" = {
                            "description" = <<-EOT
                            attachMetadata defines additional metadata to the discovered targets.
                            When the scrape object defines its own configuration, it takes
                            precedence over the scrape class configuration.
                            EOT
                            "properties" = {
                              "node" = {
                                "description" = <<-EOT
                                node when set to true, Prometheus attaches node metadata to the discovered
                                targets.
                                
                                The Prometheus service account must have the `list` and `watch`
                                permissions on the `Nodes` objects.
                                
                                Node metadata labels are not automatically added to scraped metrics. They are
                                exposed as `__meta_kubernetes_node_*` labels and can be copied to timeseries
                                with relabeling configuration.
                                EOT
                                "type" = "boolean"
                              }
                            }
                            "type" = "object"
                          }
                          "authorization" = {
                            "description" = <<-EOT
                            authorization section for the ScrapeClass.
                            It will only apply if the scrape resource doesn't specify any Authorization.
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
                              "credentialsFile" = {
                                "description" = "credentialsFile defines the file to read a secret from, mutually exclusive with `credentials`."
                                "type" = "string"
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
                          "default" = {
                            "description" = <<-EOT
                            default defines that the scrape applies to all scrape objects that
                            don't configure an explicit scrape class name.
                            
                            Only one scrape class can be set as the default.
                            EOT
                            "type" = "boolean"
                          }
                          "fallbackScrapeProtocol" = {
                            "description" = <<-EOT
                            fallbackScrapeProtocol defines the protocol to use if a scrape returns blank, unparseable, or otherwise invalid Content-Type.
                            It will only apply if the scrape resource doesn't specify any FallbackScrapeProtocol
                            
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
                          "metricRelabelings" = {
                            "description" = <<-EOT
                            metricRelabelings defines the relabeling rules to apply to all samples before ingestion.
                            
                            The Operator adds the scrape class metric relabelings defined here.
                            Then the Operator adds the target-specific metric relabelings defined in ServiceMonitors, PodMonitors, Probes and ScrapeConfigs.
                            Then the Operator adds namespace enforcement relabeling rule, specified in '.spec.enforcedNamespaceLabel'.
                            
                            More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs
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
                          "name" = {
                            "description" = "name of the scrape class."
                            "minLength" = 1
                            "type" = "string"
                          }
                          "relabelings" = {
                            "description" = <<-EOT
                            relabelings defines the relabeling rules to apply to all scrape targets.
                            
                            The Operator automatically adds relabelings for a few standard Kubernetes fields
                            like `__meta_kubernetes_namespace` and `__meta_kubernetes_service_name`.
                            Then the Operator adds the scrape class relabelings defined here.
                            Then the Operator adds the target-specific relabelings defined in the scrape object.
                            
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
                          "tlsConfig" = {
                            "description" = <<-EOT
                            tlsConfig defines the TLS settings to use for the scrape. When the
                            scrape objects define their own CA, certificate and/or key, they take
                            precedence over the corresponding scrape class fields.
                            
                            For now only the `caFile`, `certFile` and `keyFile` fields are supported.
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
                              "caFile" = {
                                "description" = "caFile defines the path to the CA cert in the Prometheus container to use for the targets."
                                "type" = "string"
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
                              "certFile" = {
                                "description" = "certFile defines the path to the client cert file in the Prometheus container for the targets."
                                "type" = "string"
                              }
                              "insecureSkipVerify" = {
                                "description" = "insecureSkipVerify defines how to disable target certificate validation."
                                "type" = "boolean"
                              }
                              "keyFile" = {
                                "description" = "keyFile defines the path to the client key file in the Prometheus container for the targets."
                                "type" = "string"
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
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-map-keys" = [
                        "name",
                      ]
                      "x-kubernetes-list-type" = "map"
                    }
                    "scrapeClassicHistograms" = {
                      "description" = <<-EOT
                      scrapeClassicHistograms defines whether to scrape a classic histogram that is also exposed as a native histogram.
                      
                      Notice: `scrapeClassicHistograms` corresponds to the `always_scrape_classic_histograms` field in the Prometheus configuration.
                      
                      It requires Prometheus >= v3.5.0.
                      EOT
                      "type" = "boolean"
                    }
                    "scrapeConfigNamespaceSelector" = {
                      "description" = <<-EOT
                      scrapeConfigNamespaceSelector defines the namespaces to match for ScrapeConfig discovery. An empty label selector
                      matches all namespaces. A null label selector matches the current
                      namespace only.
                      
                      Note that the ScrapeConfig custom resource definition is currently at Alpha level
                      and will be graduated to Beta in a future release.
                      EOT
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
                    "scrapeConfigSelector" = {
                      "description" = <<-EOT
                      scrapeConfigSelector defines the scrapeConfigs to be selected for target discovery. An empty label
                      selector matches all objects. A null label selector matches no objects.
                      
                      If `spec.serviceMonitorSelector`, `spec.podMonitorSelector`, `spec.probeSelector`
                      and `spec.scrapeConfigSelector` are null, the Prometheus configuration is unmanaged.
                      The Prometheus operator will ensure that the Prometheus configuration's
                      Secret exists, but it is the responsibility of the user to provide the raw
                      gzipped Prometheus configuration under the `prometheus.yaml.gz` key.
                      This behavior is *deprecated* and will be removed in the next major version
                      of the custom resource definition. It is recommended to use
                      `spec.additionalScrapeConfigs` instead.
                      
                      Note that the ScrapeConfig custom resource definition is currently at Alpha level
                      and will be graduated to Beta in a future release.
                      EOT
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
                    "scrapeFailureLogFile" = {
                      "description" = <<-EOT
                      scrapeFailureLogFile defines the file to which scrape failures are logged.
                      Reloading the configuration will reopen the file.
                      
                      If the filename has an empty path, e.g. 'file.log', The Prometheus Pods
                      will mount the file into an emptyDir volume at `/var/log/prometheus`.
                      If a full path is provided, e.g. '/var/log/prometheus/file.log', you
                      must mount a volume in the specified directory and it must be writable.
                      It requires Prometheus >= v2.55.0.
                      EOT
                      "minLength" = 1
                      "type" = "string"
                    }
                    "scrapeInterval" = {
                      "default" = "30s"
                      "description" = <<-EOT
                      scrapeInterval defines interval between consecutive scrapes.
                      
                      Default: "30s"
                      EOT
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
                      
                      `PrometheusText1.0.0` requires Prometheus >= v3.0.0.
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
                      scrapeTimeout defines the number of seconds to wait until a scrape request times out.
                      The value cannot be greater than the scrape interval otherwise the operator will reject the resource.
                      EOT
                      "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                      "type" = "string"
                    }
                    "secrets" = {
                      "description" = <<-EOT
                      secrets defines a list of Secrets in the same namespace as the Prometheus
                      object, which shall be mounted into the Prometheus Pods.
                      Each Secret is added to the StatefulSet definition as a volume named `secret-<secret-name>`.
                      The Secrets are mounted into /etc/prometheus/secrets/<secret-name> in the 'prometheus' container.
                      EOT
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                      "x-kubernetes-list-type" = "set"
                    }
                    "securityContext" = {
                      "description" = <<-EOT
                      securityContext holds pod-level security attributes and common container settings.
                      This defaults to the default PodSecurityContext.
                      EOT
                      "properties" = {
                        "appArmorProfile" = {
                          "description" = <<-EOT
                          appArmorProfile is the AppArmor options to use by the containers in this pod.
                          Note that this field cannot be set when spec.os.name is windows.
                          EOT
                          "properties" = {
                            "localhostProfile" = {
                              "description" = <<-EOT
                              localhostProfile indicates a profile loaded on the node that should be used.
                              The profile must be preconfigured on the node to work.
                              Must match the loaded name of the profile.
                              Must be set if and only if type is "Localhost".
                              EOT
                              "type" = "string"
                            }
                            "type" = {
                              "description" = <<-EOT
                              type indicates which kind of AppArmor profile will be applied.
                              Valid options are:
                                Localhost - a profile pre-loaded on the node.
                                RuntimeDefault - the container runtime's default profile.
                                Unconfined - no AppArmor enforcement.
                              EOT
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "type",
                          ]
                          "type" = "object"
                        }
                        "fsGroup" = {
                          "description" = <<-EOT
                          A special supplemental group that applies to all containers in a pod.
                          Some volume types allow the Kubelet to change the ownership of that volume
                          to be owned by the pod:
                          
                          1. The owning GID will be the FSGroup
                          2. The setgid bit is set (new files created in the volume will be owned by FSGroup)
                          3. The permission bits are OR'd with rw-rw----
                          
                          If unset, the Kubelet will not modify the ownership and permissions of any volume.
                          Note that this field cannot be set when spec.os.name is windows.
                          EOT
                          "format" = "int64"
                          "type" = "integer"
                        }
                        "fsGroupChangePolicy" = {
                          "description" = <<-EOT
                          fsGroupChangePolicy defines behavior of changing ownership and permission of the volume
                          before being exposed inside Pod. This field will only apply to
                          volume types which support fsGroup based ownership(and permissions).
                          It will have no effect on ephemeral volume types such as: secret, configmaps
                          and emptydir.
                          Valid values are "OnRootMismatch" and "Always". If not specified, "Always" is used.
                          Note that this field cannot be set when spec.os.name is windows.
                          EOT
                          "type" = "string"
                        }
                        "runAsGroup" = {
                          "description" = <<-EOT
                          The GID to run the entrypoint of the container process.
                          Uses runtime default if unset.
                          May also be set in SecurityContext.  If set in both SecurityContext and
                          PodSecurityContext, the value specified in SecurityContext takes precedence
                          for that container.
                          Note that this field cannot be set when spec.os.name is windows.
                          EOT
                          "format" = "int64"
                          "type" = "integer"
                        }
                        "runAsNonRoot" = {
                          "description" = <<-EOT
                          Indicates that the container must run as a non-root user.
                          If true, the Kubelet will validate the image at runtime to ensure that it
                          does not run as UID 0 (root) and fail to start the container if it does.
                          If unset or false, no such validation will be performed.
                          May also be set in SecurityContext.  If set in both SecurityContext and
                          PodSecurityContext, the value specified in SecurityContext takes precedence.
                          EOT
                          "type" = "boolean"
                        }
                        "runAsUser" = {
                          "description" = <<-EOT
                          The UID to run the entrypoint of the container process.
                          Defaults to user specified in image metadata if unspecified.
                          May also be set in SecurityContext.  If set in both SecurityContext and
                          PodSecurityContext, the value specified in SecurityContext takes precedence
                          for that container.
                          Note that this field cannot be set when spec.os.name is windows.
                          EOT
                          "format" = "int64"
                          "type" = "integer"
                        }
                        "seLinuxChangePolicy" = {
                          "description" = <<-EOT
                          seLinuxChangePolicy defines how the container's SELinux label is applied to all volumes used by the Pod.
                          It has no effect on nodes that do not support SELinux or to volumes does not support SELinux.
                          Valid values are "MountOption" and "Recursive".
                          
                          "Recursive" means relabeling of all files on all Pod volumes by the container runtime.
                          This may be slow for large volumes, but allows mixing privileged and unprivileged Pods sharing the same volume on the same node.
                          
                          "MountOption" mounts all eligible Pod volumes with `-o context` mount option.
                          This requires all Pods that share the same volume to use the same SELinux label.
                          It is not possible to share the same volume among privileged and unprivileged Pods.
                          Eligible volumes are in-tree FibreChannel and iSCSI volumes, and all CSI volumes
                          whose CSI driver announces SELinux support by setting spec.seLinuxMount: true in their
                          CSIDriver instance. Other volumes are always re-labelled recursively.
                          
                          If not specified, "MountOption" is used.
                          
                          This field affects only Pods that have SELinux label set, either in PodSecurityContext or in SecurityContext of all containers.
                          
                          All Pods that use the same volume should use the same seLinuxChangePolicy, otherwise some pods can get stuck in ContainerCreating state.
                          Note that this field cannot be set when spec.os.name is windows.
                          EOT
                          "type" = "string"
                        }
                        "seLinuxOptions" = {
                          "description" = <<-EOT
                          The SELinux context to be applied to all containers.
                          If unspecified, the container runtime will allocate a random SELinux context for each
                          container.  May also be set in SecurityContext.  If set in
                          both SecurityContext and PodSecurityContext, the value specified in SecurityContext
                          takes precedence for that container.
                          Note that this field cannot be set when spec.os.name is windows.
                          EOT
                          "properties" = {
                            "level" = {
                              "description" = "Level is SELinux level label that applies to the container."
                              "type" = "string"
                            }
                            "role" = {
                              "description" = "Role is a SELinux role label that applies to the container."
                              "type" = "string"
                            }
                            "type" = {
                              "description" = "Type is a SELinux type label that applies to the container."
                              "type" = "string"
                            }
                            "user" = {
                              "description" = "User is a SELinux user label that applies to the container."
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                        "seccompProfile" = {
                          "description" = <<-EOT
                          The seccomp options to use by the containers in this pod.
                          Note that this field cannot be set when spec.os.name is windows.
                          EOT
                          "properties" = {
                            "localhostProfile" = {
                              "description" = <<-EOT
                              localhostProfile indicates a profile defined in a file on the node should be used.
                              The profile must be preconfigured on the node to work.
                              Must be a descending path, relative to the kubelet's configured seccomp profile location.
                              Must be set if type is "Localhost". Must NOT be set for any other type.
                              EOT
                              "type" = "string"
                            }
                            "type" = {
                              "description" = <<-EOT
                              type indicates which kind of seccomp profile will be applied.
                              Valid options are:
                              
                              Localhost - a profile defined in a file on the node should be used.
                              RuntimeDefault - the container runtime default profile should be used.
                              Unconfined - no profile should be applied.
                              EOT
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "type",
                          ]
                          "type" = "object"
                        }
                        "supplementalGroups" = {
                          "description" = <<-EOT
                          A list of groups applied to the first process run in each container, in
                          addition to the container's primary GID and fsGroup (if specified).  If
                          the SupplementalGroupsPolicy feature is enabled, the
                          supplementalGroupsPolicy field determines whether these are in addition
                          to or instead of any group memberships defined in the container image.
                          If unspecified, no additional groups are added, though group memberships
                          defined in the container image may still be used, depending on the
                          supplementalGroupsPolicy field.
                          Note that this field cannot be set when spec.os.name is windows.
                          EOT
                          "items" = {
                            "format" = "int64"
                            "type" = "integer"
                          }
                          "type" = "array"
                          "x-kubernetes-list-type" = "atomic"
                        }
                        "supplementalGroupsPolicy" = {
                          "description" = <<-EOT
                          Defines how supplemental groups of the first container processes are calculated.
                          Valid values are "Merge" and "Strict". If not specified, "Merge" is used.
                          (Alpha) Using the field requires the SupplementalGroupsPolicy feature gate to be enabled
                          and the container runtime must implement support for this feature.
                          Note that this field cannot be set when spec.os.name is windows.
                          EOT
                          "type" = "string"
                        }
                        "sysctls" = {
                          "description" = <<-EOT
                          Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported
                          sysctls (by the container runtime) might fail to launch.
                          Note that this field cannot be set when spec.os.name is windows.
                          EOT
                          "items" = {
                            "description" = "Sysctl defines a kernel parameter to be set"
                            "properties" = {
                              "name" = {
                                "description" = "Name of a property to set"
                                "type" = "string"
                              }
                              "value" = {
                                "description" = "Value of a property to set"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "name",
                              "value",
                            ]
                            "type" = "object"
                          }
                          "type" = "array"
                          "x-kubernetes-list-type" = "atomic"
                        }
                        "windowsOptions" = {
                          "description" = <<-EOT
                          The Windows specific settings applied to all containers.
                          If unspecified, the options within a container's SecurityContext will be used.
                          If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
                          Note that this field cannot be set when spec.os.name is linux.
                          EOT
                          "properties" = {
                            "gmsaCredentialSpec" = {
                              "description" = <<-EOT
                              GMSACredentialSpec is where the GMSA admission webhook
                              (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the
                              GMSA credential spec named by the GMSACredentialSpecName field.
                              EOT
                              "type" = "string"
                            }
                            "gmsaCredentialSpecName" = {
                              "description" = "GMSACredentialSpecName is the name of the GMSA credential spec to use."
                              "type" = "string"
                            }
                            "hostProcess" = {
                              "description" = <<-EOT
                              HostProcess determines if a container should be run as a 'Host Process' container.
                              All of a Pod's containers must have the same effective HostProcess value
                              (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).
                              In addition, if HostProcess is true then HostNetwork must also be set to true.
                              EOT
                              "type" = "boolean"
                            }
                            "runAsUserName" = {
                              "description" = <<-EOT
                              The UserName in Windows to run the entrypoint of the container process.
                              Defaults to the user specified in image metadata if unspecified.
                              May also be set in PodSecurityContext. If set in both SecurityContext and
                              PodSecurityContext, the value specified in SecurityContext takes precedence.
                              EOT
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "serviceAccountName" = {
                      "description" = <<-EOT
                      serviceAccountName is the name of the ServiceAccount to use to run the
                      Prometheus Pods.
                      EOT
                      "type" = "string"
                    }
                    "serviceDiscoveryRole" = {
                      "description" = <<-EOT
                      serviceDiscoveryRole defines the service discovery role used to discover targets from
                      `ServiceMonitor` objects and Alertmanager endpoints.
                      
                      If set, the value should be either "Endpoints" or "EndpointSlice".
                      If unset, the operator assumes the "Endpoints" role.
                      EOT
                      "enum" = [
                        "Endpoints",
                        "EndpointSlice",
                      ]
                      "type" = "string"
                    }
                    "serviceMonitorNamespaceSelector" = {
                      "description" = <<-EOT
                      serviceMonitorNamespaceSelector defines the namespaces to match for ServicedMonitors discovery. An empty label selector
                      matches all namespaces. A null label selector (default value) matches the current
                      namespace only.
                      EOT
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
                    "serviceMonitorSelector" = {
                      "description" = <<-EOT
                      serviceMonitorSelector defines the serviceMonitors to be selected for target discovery. An empty label
                      selector matches all objects. A null label selector matches no objects.
                      
                      If `spec.serviceMonitorSelector`, `spec.podMonitorSelector`, `spec.probeSelector`
                      and `spec.scrapeConfigSelector` are null, the Prometheus configuration is unmanaged.
                      The Prometheus operator will ensure that the Prometheus configuration's
                      Secret exists, but it is the responsibility of the user to provide the raw
                      gzipped Prometheus configuration under the `prometheus.yaml.gz` key.
                      This behavior is *deprecated* and will be removed in the next major version
                      of the custom resource definition. It is recommended to use
                      `spec.additionalScrapeConfigs` instead.
                      EOT
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
                    "serviceName" = {
                      "description" = <<-EOT
                      serviceName defines the name of the service name used by the underlying StatefulSet(s) as the governing service.
                      If defined, the Service  must be created before the Prometheus/PrometheusAgent resource in the same namespace and it must define a selector that matches the pod labels.
                      If empty, the operator will create and manage a headless service named `prometheus-operated` for Prometheus resources,
                      or `prometheus-agent-operated` for PrometheusAgent resources.
                      When deploying multiple Prometheus/PrometheusAgent resources in the same namespace, it is recommended to specify a different value for each.
                      See https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#stable-network-id for more details.
                      EOT
                      "minLength" = 1
                      "type" = "string"
                    }
                    "shardingStrategy" = {
                      "description" = <<-EOT
                      shardingStrategy defines the sharding strategy for distributing scraped targets across Prometheus shards.
                      
                      When not defined, the operator defaults to the 'Address' mode which distributes
                      targets based on a hash of the target address.
                      EOT
                      "properties" = {
                        "mode" = {
                          "description" = <<-EOT
                          mode defines the sharding mode. Can be 'Address' or 'Topology'.
                          
                          'Address' is the default mode and distributes targets across shards
                          based on a hash of the target address.
                          
                          'Topology' enables zone-aware sharding where each shard is assigned to a
                          specific topology zone and only scrapes targets in that zone.
                          (Alpha) Using the 'Topology' mode requires the `PrometheusTopologySharding`
                          feature gate to be enabled.
                          EOT
                          "enum" = [
                            "Address",
                            "Topology",
                          ]
                          "type" = "string"
                        }
                        "topology" = {
                          "description" = <<-EOT
                          topology defines the configuration for topology-aware sharding.
                          This field is only valid when mode is set to 'Topology'.
                          EOT
                          "properties" = {
                            "externalLabelName" = {
                              "description" = <<-EOT
                              externalLabelName defines the name of the Prometheus external label used
                              to communicate the topology zone assigned to the Prometheus instance.
                              If not defined, it defaults to "zone".
                              If set to the empty string, no external label is added to the Prometheus configuration.
                              EOT
                              "type" = "string"
                            }
                            "values" = {
                              "description" = <<-EOT
                              values defines the list of topology values (e.g. zone names) to be used
                              for sharding. The configured number of shards must be greater than or
                              equal to the number of values.
                              EOT
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                              "x-kubernetes-list-type" = "atomic"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                      "x-kubernetes-validations" = [
                        {
                          "message" = "topology can only be defined when mode is set to 'Topology'"
                          "rule" = "!has(self.topology) || (has(self.mode) && self.mode == 'Topology')"
                        },
                      ]
                    }
                    "shards" = {
                      "default" = 1
                      "description" = <<-EOT
                      shards defines the number of shards to distribute the scraped targets onto.
                      
                      `spec.replicas` multiplied by `spec.shards` is the total number of Pods
                      being created.
                      
                      When not defined, the operator assumes only one shard.
                      
                      Note that scaling down shards will not reshard data onto the remaining
                      instances, it must be manually moved. Increasing shards will not reshard
                      data either but it will continue to be available from the same
                      instances. To query globally, use either
                      * Thanos sidecar + querier for query federation and Thanos Ruler for rules.
                      * Remote-write to send metrics to a central location.
                      
                      By default, the sharding of targets is performed on:
                      * The `__address__` target's metadata label for PodMonitor,
                      ServiceMonitor and ScrapeConfig resources.
                      * The `__param_target__` label for Probe resources.
                      
                      Users can define their own sharding implementation by setting the
                      `__tmp_hash` label during the target discovery with relabeling
                      configuration (either in the monitoring resources or via scrape class).
                      
                      You can also disable sharding on a specific target by setting the
                      `__tmp_disable_sharding` label with relabeling configuration. When
                      the label value isn't empty, all Prometheus shards will scrape the target.
                      
                      Default: 1
                      EOT
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "storage" = {
                      "description" = "storage defines the storage used by Prometheus."
                      "properties" = {
                        "disableMountSubPath" = {
                          "description" = "disableMountSubPath deprecated: subPath usage will be removed in a future release."
                          "type" = "boolean"
                        }
                        "emptyDir" = {
                          "description" = <<-EOT
                          emptyDir to be used by the StatefulSet.
                          If specified, it takes precedence over `ephemeral` and `volumeClaimTemplate`.
                          More info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir
                          EOT
                          "properties" = {
                            "medium" = {
                              "description" = <<-EOT
                              medium represents what type of storage medium should back this directory.
                              The default is "" which means to use the node's default medium.
                              Must be an empty string (default) or Memory.
                              More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
                              EOT
                              "type" = "string"
                            }
                            "mode" = {
                              "description" = <<-EOT
                              mode specifies the permission bits for the emptyDir directory, in numeric
                              notation (e.g., 0755, 01777). Must be a value between 0000 and 01777.
                              If not specified, defaults to 0777.
                              This might be in conflict with other options that affect the file
                              mode, like fsGroup. If fsGroup is specified, the fsGroup permissions
                              will override the mode specified here.
                              This field has no effect on Windows.
                              This field is alpha and requires EmptyDirVolumeMode featuregate to be enabled.
                              EOT
                              "format" = "int32"
                              "type" = "integer"
                            }
                            "sizeLimit" = {
                              "anyOf" = [
                                {
                                  "type" = "integer"
                                },
                                {
                                  "type" = "string"
                                },
                              ]
                              "description" = <<-EOT
                              sizeLimit is the total amount of local storage required for this EmptyDir volume.
                              The size limit is also applicable for memory medium.
                              The maximum usage on memory medium EmptyDir would be the minimum value between
                              the SizeLimit specified here and the sum of memory limits of all containers in a pod.
                              The default is nil which means that the limit is undefined.
                              More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
                              EOT
                              "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                              "x-kubernetes-int-or-string" = true
                            }
                          }
                          "type" = "object"
                        }
                        "ephemeral" = {
                          "description" = <<-EOT
                          ephemeral to be used by the StatefulSet.
                          This is a beta field in k8s 1.21 and GA in 1.15.
                          For lower versions, starting with k8s 1.19, it requires enabling the GenericEphemeralVolume feature gate.
                          More info: https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/#generic-ephemeral-volumes
                          EOT
                          "properties" = {
                            "volumeClaimTemplate" = {
                              "description" = <<-EOT
                              Will be used to create a stand-alone PVC to provision the volume.
                              The pod in which this EphemeralVolumeSource is embedded will be the
                              owner of the PVC, i.e. the PVC will be deleted together with the
                              pod.  The name of the PVC will be `<pod name>-<volume name>` where
                              `<volume name>` is the name from the `PodSpec.Volumes` array
                              entry. Pod validation will reject the pod if the concatenated name
                              is not valid for a PVC (for example, too long).
                              
                              An existing PVC with that name that is not owned by the pod
                              will *not* be used for the pod to avoid using an unrelated
                              volume by mistake. Starting the pod is then blocked until
                              the unrelated PVC is removed. If such a pre-created PVC is
                              meant to be used by the pod, the PVC has to updated with an
                              owner reference to the pod once the pod exists. Normally
                              this should not be necessary, but it may be useful when
                              manually reconstructing a broken cluster.
                              
                              This field is read-only and no changes will be made by Kubernetes
                              to the PVC after it has been created.
                              
                              Required, must not be nil.
                              EOT
                              "properties" = {
                                "metadata" = {
                                  "description" = <<-EOT
                                  May contain labels and annotations that will be copied into the PVC
                                  when creating it. No other fields are allowed and will be rejected during
                                  validation.
                                  EOT
                                  "type" = "object"
                                }
                                "spec" = {
                                  "description" = <<-EOT
                                  The specification for the PersistentVolumeClaim. The entire content is
                                  copied unchanged into the PVC that gets created from this
                                  template. The same fields as in a PersistentVolumeClaim
                                  are also valid here.
                                  EOT
                                  "properties" = {
                                    "accessModes" = {
                                      "description" = <<-EOT
                                      accessModes contains the desired access modes the volume should have.
                                      More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
                                      EOT
                                      "items" = {
                                        "type" = "string"
                                      }
                                      "type" = "array"
                                      "x-kubernetes-list-type" = "atomic"
                                    }
                                    "dataSource" = {
                                      "description" = <<-EOT
                                      dataSource field can be used to specify either:
                                      * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)
                                      * An existing PVC (PersistentVolumeClaim)
                                      If the provisioner or an external controller can support the specified data source,
                                      it will create a new volume based on the contents of the specified data source.
                                      dataSource contents will be copied to dataSourceRef, and dataSourceRef contents will be
                                      copied to dataSource when dataSourceRef.namespace is not specified.
                                      If the namespace is specified, then dataSourceRef will not be copied to dataSource.
                                      EOT
                                      "properties" = {
                                        "apiGroup" = {
                                          "description" = <<-EOT
                                          APIGroup is the group for the resource being referenced.
                                          If APIGroup is not specified, the specified Kind must be in the core API group.
                                          For any other third-party types, APIGroup is required.
                                          EOT
                                          "type" = "string"
                                        }
                                        "kind" = {
                                          "description" = "Kind is the type of resource being referenced"
                                          "type" = "string"
                                        }
                                        "name" = {
                                          "description" = "Name is the name of resource being referenced"
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "kind",
                                        "name",
                                      ]
                                      "type" = "object"
                                      "x-kubernetes-map-type" = "atomic"
                                    }
                                    "dataSourceRef" = {
                                      "description" = <<-EOT
                                      dataSourceRef specifies the object from which to populate the volume with data, if a non-empty
                                      volume is desired. This may be any object from a non-empty API group (non
                                      core object) or a PersistentVolumeClaim object.
                                      When this field is specified, volume binding will only succeed if the type of
                                      the specified object matches some installed volume populator or dynamic
                                      provisioner.
                                      This field will replace the functionality of the dataSource field and as such
                                      if both fields are non-empty, they must have the same value. For backwards
                                      compatibility, when namespace isn't specified in dataSourceRef,
                                      both fields (dataSource and dataSourceRef) will be set to the same
                                      value automatically if one of them is empty and the other is non-empty.
                                      When namespace is specified in dataSourceRef,
                                      dataSource isn't set to the same value and must be empty.
                                      There are three important differences between dataSource and dataSourceRef:
                                      * While dataSource only allows two specific types of objects, dataSourceRef
                                        allows any non-core object, as well as PersistentVolumeClaim objects.
                                      * While dataSource ignores disallowed values (dropping them), dataSourceRef
                                        preserves all values, and generates an error if a disallowed value is
                                        specified.
                                      * While dataSource only allows local objects, dataSourceRef allows objects
                                        in any namespaces.
                                      (Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
                                      EOT
                                      "properties" = {
                                        "apiGroup" = {
                                          "description" = <<-EOT
                                          APIGroup is the group for the resource being referenced.
                                          If APIGroup is not specified, the specified Kind must be in the core API group.
                                          For any other third-party types, APIGroup is required.
                                          EOT
                                          "type" = "string"
                                        }
                                        "kind" = {
                                          "description" = "Kind is the type of resource being referenced"
                                          "type" = "string"
                                        }
                                        "name" = {
                                          "description" = "Name is the name of resource being referenced"
                                          "type" = "string"
                                        }
                                        "namespace" = {
                                          "description" = <<-EOT
                                          Namespace is the namespace of resource being referenced
                                          Note that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details.
                                          (Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
                                          EOT
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "kind",
                                        "name",
                                      ]
                                      "type" = "object"
                                    }
                                    "resources" = {
                                      "description" = <<-EOT
                                      resources represents the minimum resources the volume should have.
                                      Users are allowed to specify resource requirements
                                      that are lower than previous value but must still be higher than capacity recorded in the
                                      status field of the claim.
                                      More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources
                                      EOT
                                      "properties" = {
                                        "limits" = {
                                          "additionalProperties" = {
                                            "anyOf" = [
                                              {
                                                "type" = "integer"
                                              },
                                              {
                                                "type" = "string"
                                              },
                                            ]
                                            "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                            "x-kubernetes-int-or-string" = true
                                          }
                                          "description" = <<-EOT
                                          Limits describes the maximum amount of compute resources allowed.
                                          More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                                          EOT
                                          "type" = "object"
                                        }
                                        "requests" = {
                                          "additionalProperties" = {
                                            "anyOf" = [
                                              {
                                                "type" = "integer"
                                              },
                                              {
                                                "type" = "string"
                                              },
                                            ]
                                            "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                            "x-kubernetes-int-or-string" = true
                                          }
                                          "description" = <<-EOT
                                          Requests describes the minimum amount of compute resources required.
                                          If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
                                          otherwise to an implementation-defined value. Requests cannot exceed Limits.
                                          More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                                          EOT
                                          "type" = "object"
                                        }
                                      }
                                      "type" = "object"
                                    }
                                    "selector" = {
                                      "description" = "selector is a label query over volumes to consider for binding."
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
                                    "storageClassName" = {
                                      "description" = <<-EOT
                                      storageClassName is the name of the StorageClass required by the claim.
                                      More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
                                      EOT
                                      "type" = "string"
                                    }
                                    "volumeAttributesClassName" = {
                                      "description" = <<-EOT
                                      volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.
                                      If specified, the CSI driver will create or update the volume with the attributes defined
                                      in the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,
                                      it can be changed after the claim is created. An empty string or nil value indicates that no
                                      VolumeAttributesClass will be applied to the claim. If the claim enters an Infeasible error state,
                                      this field can be reset to its previous value (including nil) to cancel the modification.
                                      If the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be
                                      set to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource
                                      exists.
                                      More info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/
                                      EOT
                                      "type" = "string"
                                    }
                                    "volumeMode" = {
                                      "description" = <<-EOT
                                      volumeMode defines what type of volume is required by the claim.
                                      Value of Filesystem is implied when not included in claim spec.
                                      EOT
                                      "type" = "string"
                                    }
                                    "volumeName" = {
                                      "description" = "volumeName is the binding reference to the PersistentVolume backing this claim."
                                      "type" = "string"
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
                          "type" = "object"
                        }
                        "volumeClaimTemplate" = {
                          "description" = <<-EOT
                          volumeClaimTemplate defines the PVC spec to be used by the Prometheus StatefulSets.
                          The easiest way to use a volume that cannot be automatically provisioned
                          is to use a label selector alongside manually created PersistentVolumes.
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
                              "description" = "metadata defines EmbeddedMetadata contains metadata relevant to an EmbeddedResource."
                              "properties" = {
                                "annotations" = {
                                  "additionalProperties" = {
                                    "type" = "string"
                                  }
                                  "description" = <<-EOT
                                  annotations defines an unstructured key value map stored with a resource that may be
                                  set by external tools to store and retrieve arbitrary metadata. They are not
                                  queryable and should be preserved when modifying objects.
                                  More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
                                  EOT
                                  "type" = "object"
                                }
                                "labels" = {
                                  "additionalProperties" = {
                                    "type" = "string"
                                  }
                                  "description" = <<-EOT
                                  labels define the map of string keys and values that can be used to organize and categorize
                                  (scope and select) objects. May match selectors of replication controllers
                                  and services.
                                  More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
                                  EOT
                                  "type" = "object"
                                }
                                "name" = {
                                  "description" = <<-EOT
                                  name must be unique within a namespace. Is required when creating resources, although
                                  some resources may allow a client to request the generation of an appropriate name
                                  automatically. Name is primarily intended for creation idempotence and configuration
                                  definition.
                                  Cannot be updated.
                                  More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/
                                  EOT
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "spec" = {
                              "description" = <<-EOT
                              spec defines the specification of the  characteristics of a volume requested by a pod author.
                              More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
                              EOT
                              "properties" = {
                                "accessModes" = {
                                  "description" = <<-EOT
                                  accessModes contains the desired access modes the volume should have.
                                  More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
                                  EOT
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                  "x-kubernetes-list-type" = "atomic"
                                }
                                "dataSource" = {
                                  "description" = <<-EOT
                                  dataSource field can be used to specify either:
                                  * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)
                                  * An existing PVC (PersistentVolumeClaim)
                                  If the provisioner or an external controller can support the specified data source,
                                  it will create a new volume based on the contents of the specified data source.
                                  dataSource contents will be copied to dataSourceRef, and dataSourceRef contents will be
                                  copied to dataSource when dataSourceRef.namespace is not specified.
                                  If the namespace is specified, then dataSourceRef will not be copied to dataSource.
                                  EOT
                                  "properties" = {
                                    "apiGroup" = {
                                      "description" = <<-EOT
                                      APIGroup is the group for the resource being referenced.
                                      If APIGroup is not specified, the specified Kind must be in the core API group.
                                      For any other third-party types, APIGroup is required.
                                      EOT
                                      "type" = "string"
                                    }
                                    "kind" = {
                                      "description" = "Kind is the type of resource being referenced"
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name is the name of resource being referenced"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "kind",
                                    "name",
                                  ]
                                  "type" = "object"
                                  "x-kubernetes-map-type" = "atomic"
                                }
                                "dataSourceRef" = {
                                  "description" = <<-EOT
                                  dataSourceRef specifies the object from which to populate the volume with data, if a non-empty
                                  volume is desired. This may be any object from a non-empty API group (non
                                  core object) or a PersistentVolumeClaim object.
                                  When this field is specified, volume binding will only succeed if the type of
                                  the specified object matches some installed volume populator or dynamic
                                  provisioner.
                                  This field will replace the functionality of the dataSource field and as such
                                  if both fields are non-empty, they must have the same value. For backwards
                                  compatibility, when namespace isn't specified in dataSourceRef,
                                  both fields (dataSource and dataSourceRef) will be set to the same
                                  value automatically if one of them is empty and the other is non-empty.
                                  When namespace is specified in dataSourceRef,
                                  dataSource isn't set to the same value and must be empty.
                                  There are three important differences between dataSource and dataSourceRef:
                                  * While dataSource only allows two specific types of objects, dataSourceRef
                                    allows any non-core object, as well as PersistentVolumeClaim objects.
                                  * While dataSource ignores disallowed values (dropping them), dataSourceRef
                                    preserves all values, and generates an error if a disallowed value is
                                    specified.
                                  * While dataSource only allows local objects, dataSourceRef allows objects
                                    in any namespaces.
                                  (Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
                                  EOT
                                  "properties" = {
                                    "apiGroup" = {
                                      "description" = <<-EOT
                                      APIGroup is the group for the resource being referenced.
                                      If APIGroup is not specified, the specified Kind must be in the core API group.
                                      For any other third-party types, APIGroup is required.
                                      EOT
                                      "type" = "string"
                                    }
                                    "kind" = {
                                      "description" = "Kind is the type of resource being referenced"
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "description" = "Name is the name of resource being referenced"
                                      "type" = "string"
                                    }
                                    "namespace" = {
                                      "description" = <<-EOT
                                      Namespace is the namespace of resource being referenced
                                      Note that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details.
                                      (Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
                                      EOT
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "kind",
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "resources" = {
                                  "description" = <<-EOT
                                  resources represents the minimum resources the volume should have.
                                  Users are allowed to specify resource requirements
                                  that are lower than previous value but must still be higher than capacity recorded in the
                                  status field of the claim.
                                  More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources
                                  EOT
                                  "properties" = {
                                    "limits" = {
                                      "additionalProperties" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                        "x-kubernetes-int-or-string" = true
                                      }
                                      "description" = <<-EOT
                                      Limits describes the maximum amount of compute resources allowed.
                                      More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                                      EOT
                                      "type" = "object"
                                    }
                                    "requests" = {
                                      "additionalProperties" = {
                                        "anyOf" = [
                                          {
                                            "type" = "integer"
                                          },
                                          {
                                            "type" = "string"
                                          },
                                        ]
                                        "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                        "x-kubernetes-int-or-string" = true
                                      }
                                      "description" = <<-EOT
                                      Requests describes the minimum amount of compute resources required.
                                      If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
                                      otherwise to an implementation-defined value. Requests cannot exceed Limits.
                                      More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                                      EOT
                                      "type" = "object"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "selector" = {
                                  "description" = "selector is a label query over volumes to consider for binding."
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
                                "storageClassName" = {
                                  "description" = <<-EOT
                                  storageClassName is the name of the StorageClass required by the claim.
                                  More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
                                  EOT
                                  "type" = "string"
                                }
                                "volumeAttributesClassName" = {
                                  "description" = <<-EOT
                                  volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.
                                  If specified, the CSI driver will create or update the volume with the attributes defined
                                  in the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,
                                  it can be changed after the claim is created. An empty string or nil value indicates that no
                                  VolumeAttributesClass will be applied to the claim. If the claim enters an Infeasible error state,
                                  this field can be reset to its previous value (including nil) to cancel the modification.
                                  If the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be
                                  set to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource
                                  exists.
                                  More info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/
                                  EOT
                                  "type" = "string"
                                }
                                "volumeMode" = {
                                  "description" = <<-EOT
                                  volumeMode defines what type of volume is required by the claim.
                                  Value of Filesystem is implied when not included in claim spec.
                                  EOT
                                  "type" = "string"
                                }
                                "volumeName" = {
                                  "description" = "volumeName is the binding reference to the PersistentVolume backing this claim."
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "status" = {
                              "description" = "status is deprecated: this field is never set."
                              "properties" = {
                                "accessModes" = {
                                  "description" = <<-EOT
                                  accessModes contains the actual access modes the volume backing the PVC has.
                                  More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
                                  EOT
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                  "x-kubernetes-list-type" = "atomic"
                                }
                                "allocatedResourceStatuses" = {
                                  "additionalProperties" = {
                                    "description" = <<-EOT
                                    When a controller receives persistentvolume claim update with ClaimResourceStatus for a resource
                                    that it does not recognizes, then it should ignore that update and let other controllers
                                    handle it.
                                    EOT
                                    "type" = "string"
                                  }
                                  "description" = <<-EOT
                                  allocatedResourceStatuses stores status of resource being resized for the given PVC.
                                  Key names follow standard Kubernetes label syntax. Valid values are either:
                                  	* Un-prefixed keys:
                                  		- storage - the capacity of the volume.
                                  	* Custom resources must use implementation-defined prefixed names such as "example.com/my-custom-resource"
                                  Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered
                                  reserved and hence may not be used.
                                  
                                  ClaimResourceStatus can be in any of following states:
                                  	- ControllerResizeInProgress:
                                  		State set when resize controller starts resizing the volume in control-plane.
                                  	- ControllerResizeFailed:
                                  		State set when resize has failed in resize controller with a terminal error.
                                  	- NodeResizePending:
                                  		State set when resize controller has finished resizing the volume but further resizing of
                                  		volume is needed on the node.
                                  	- NodeResizeInProgress:
                                  		State set when kubelet starts resizing the volume.
                                  	- NodeResizeFailed:
                                  		State set when resizing has failed in kubelet with a terminal error. Transient errors don't set
                                  		NodeResizeFailed.
                                  For example: if expanding a PVC for more capacity - this field can be one of the following states:
                                  	- pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeInProgress"
                                       - pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeFailed"
                                       - pvc.status.allocatedResourceStatus['storage'] = "NodeResizePending"
                                       - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeInProgress"
                                       - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeFailed"
                                  When this field is not set, it means that no resize operation is in progress for the given PVC.
                                  
                                  A controller that receives PVC update with previously unknown resourceName or ClaimResourceStatus
                                  should ignore the update for the purpose it was designed. For example - a controller that
                                  only is responsible for resizing capacity of the volume, should ignore PVC updates that change other valid
                                  resources associated with PVC.
                                  EOT
                                  "type" = "object"
                                  "x-kubernetes-map-type" = "granular"
                                }
                                "allocatedResources" = {
                                  "additionalProperties" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                    "x-kubernetes-int-or-string" = true
                                  }
                                  "description" = <<-EOT
                                  allocatedResources tracks the resources allocated to a PVC including its capacity.
                                  Key names follow standard Kubernetes label syntax. Valid values are either:
                                  	* Un-prefixed keys:
                                  		- storage - the capacity of the volume.
                                  	* Custom resources must use implementation-defined prefixed names such as "example.com/my-custom-resource"
                                  Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered
                                  reserved and hence may not be used.
                                  
                                  Capacity reported here may be larger than the actual capacity when a volume expansion operation
                                  is requested.
                                  For storage quota, the larger value from allocatedResources and PVC.spec.resources is used.
                                  If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation.
                                  If a volume expansion capacity request is lowered, allocatedResources is only
                                  lowered if there are no expansion operations in progress and if the actual volume capacity
                                  is equal or lower than the requested capacity.
                                  
                                  A controller that receives PVC update with previously unknown resourceName
                                  should ignore the update for the purpose it was designed. For example - a controller that
                                  only is responsible for resizing capacity of the volume, should ignore PVC updates that change other valid
                                  resources associated with PVC.
                                  EOT
                                  "type" = "object"
                                }
                                "capacity" = {
                                  "additionalProperties" = {
                                    "anyOf" = [
                                      {
                                        "type" = "integer"
                                      },
                                      {
                                        "type" = "string"
                                      },
                                    ]
                                    "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                    "x-kubernetes-int-or-string" = true
                                  }
                                  "description" = "capacity represents the actual resources of the underlying volume."
                                  "type" = "object"
                                }
                                "conditions" = {
                                  "description" = <<-EOT
                                  conditions is the current Condition of persistent volume claim. If underlying persistent volume is being
                                  resized then the Condition will be set to 'Resizing'.
                                  EOT
                                  "items" = {
                                    "description" = "PersistentVolumeClaimCondition contains details about state of pvc"
                                    "properties" = {
                                      "lastProbeTime" = {
                                        "description" = "lastProbeTime is the time we probed the condition."
                                        "format" = "date-time"
                                        "type" = "string"
                                      }
                                      "lastTransitionTime" = {
                                        "description" = "lastTransitionTime is the time the condition transitioned from one status to another."
                                        "format" = "date-time"
                                        "type" = "string"
                                      }
                                      "message" = {
                                        "description" = "message is the human-readable message indicating details about last transition."
                                        "type" = "string"
                                      }
                                      "reason" = {
                                        "description" = <<-EOT
                                        reason is a unique, this should be a short, machine understandable string that gives the reason
                                        for condition's last transition. If it reports "Resizing" that means the underlying
                                        persistent volume is being resized.
                                        EOT
                                        "type" = "string"
                                      }
                                      "status" = {
                                        "description" = <<-EOT
                                        Status is the status of the condition.
                                        Can be True, False, Unknown.
                                        More info: https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=state%20of%20pvc-,conditions.status,-(string)%2C%20required
                                        EOT
                                        "type" = "string"
                                      }
                                      "type" = {
                                        "description" = <<-EOT
                                        Type is the type of the condition.
                                        More info: https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=set%20to%20%27ResizeStarted%27.-,PersistentVolumeClaimCondition,-contains%20details%20about
                                        EOT
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
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
                                "currentVolumeAttributesClassName" = {
                                  "description" = <<-EOT
                                  currentVolumeAttributesClassName is the current name of the VolumeAttributesClass the PVC is using.
                                  When unset, there is no VolumeAttributeClass applied to this PersistentVolumeClaim
                                  EOT
                                  "type" = "string"
                                }
                                "healthStatus" = {
                                  "description" = <<-EOT
                                  healthStatus contains the latest controller-reported health information
                                  for the volume bound to this claim.
                                  EOT
                                  "properties" = {
                                    "healthConditions" = {
                                      "description" = <<-EOT
                                      conditions is the set of adverse conditions reported by
                                      the CSI controller plugin. An empty list means no adverse condition.
                                      At most 16 conditions may be reported.
                                      EOT
                                      "items" = {
                                        "description" = "VolumeHealthCondition represents an adverse health condition reported for a volume."
                                        "properties" = {
                                          "message" = {
                                            "description" = <<-EOT
                                            message is a human-readable description.
                                            Maximum permitted length of a message is 1024 bytes.
                                            EOT
                                            "type" = "string"
                                          }
                                          "reason" = {
                                            "description" = <<-EOT
                                            reason is a brief CamelCase machine-parseable reason.
                                            Together with status it forms the unique identity of a condition entry.
                                            Maximum permitted length of a reason is 256 bytes.
                                            EOT
                                            "type" = "string"
                                          }
                                          "status" = {
                                            "description" = <<-EOT
                                            status is the machine-parseable health category.
                                            Possible values:
                                            - "Inaccessible": the volume cannot be accessed.
                                            - "DataLoss": data loss has been detected on the volume.
                                            - "Degraded": the volume is functioning with reduced capability.
                                            EOT
                                            "enum" = [
                                              "DataLoss",
                                              "Degraded",
                                              "Inaccessible",
                                            ]
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "reason",
                                          "status",
                                        ]
                                        "type" = "object"
                                      }
                                      "type" = "array"
                                      "x-kubernetes-list-map-keys" = [
                                        "status",
                                        "reason",
                                      ]
                                      "x-kubernetes-list-type" = "map"
                                    }
                                    "lastTransitionTime" = {
                                      "description" = "lastTransitionTime is when the current set of conditions first appeared."
                                      "format" = "date-time"
                                      "type" = "string"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "modifyVolumeStatus" = {
                                  "description" = <<-EOT
                                  ModifyVolumeStatus represents the status object of ControllerModifyVolume operation.
                                  When this is unset, there is no ModifyVolume operation being attempted.
                                  EOT
                                  "properties" = {
                                    "status" = {
                                      "description" = <<-EOT
                                      status is the status of the ControllerModifyVolume operation. It can be in any of following states:
                                       - Pending
                                         Pending indicates that the PersistentVolumeClaim cannot be modified due to unmet requirements, such as
                                         the specified VolumeAttributesClass not existing.
                                       - InProgress
                                         InProgress indicates that the volume is being modified.
                                       - Infeasible
                                        Infeasible indicates that the request has been rejected as invalid by the CSI driver. To
                                      	  resolve the error, a valid VolumeAttributesClass needs to be specified.
                                      Note: New statuses can be added in the future. Consumers should check for unknown statuses and fail appropriately.
                                      EOT
                                      "type" = "string"
                                    }
                                    "targetVolumeAttributesClassName" = {
                                      "description" = "targetVolumeAttributesClassName is the name of the VolumeAttributesClass the PVC currently being reconciled"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "status",
                                  ]
                                  "type" = "object"
                                }
                                "phase" = {
                                  "description" = "phase represents the current phase of PersistentVolumeClaim."
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "targetLimit" = {
                      "description" = <<-EOT
                      targetLimit defines a limit on the number of scraped targets that will be accepted.
                      Only valid in Prometheus versions 2.45.0 and newer.
                      
                      Note that the global limit only applies to scrape objects that don't specify an explicit limit value.
                      If you want to enforce a maximum limit for all scrape objects, refer to enforcedTargetLimit.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "terminationGracePeriodSeconds" = {
                      "description" = <<-EOT
                      terminationGracePeriodSeconds defines the optional duration in seconds the pod needs to terminate gracefully.
                      Value must be non-negative integer. The value zero indicates stop immediately via
                      the kill signal (no opportunity to shut down) which may lead to data corruption.
                      
                      Defaults to 600 seconds.
                      EOT
                      "format" = "int64"
                      "minimum" = 0
                      "type" = "integer"
                    }
                    "tolerations" = {
                      "description" = "tolerations defines the Pods' tolerations if specified."
                      "items" = {
                        "description" = <<-EOT
                        The pod this Toleration is attached to tolerates any taint that matches
                        the triple <key,value,effect> using the matching operator <operator>.
                        EOT
                        "properties" = {
                          "effect" = {
                            "description" = <<-EOT
                            Effect indicates the taint effect to match. Empty means match all taint effects.
                            When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.
                            EOT
                            "type" = "string"
                          }
                          "key" = {
                            "description" = <<-EOT
                            Key is the taint key that the toleration applies to. Empty means match all taint keys.
                            If the key is empty, operator must be Exists; this combination means to match all values and all keys.
                            EOT
                            "type" = "string"
                          }
                          "operator" = {
                            "description" = <<-EOT
                            Operator represents a key's relationship to the value.
                            Valid operators are Exists, Equal, Lt, and Gt. Defaults to Equal.
                            Exists is equivalent to wildcard for value, so that a pod can
                            tolerate all taints of a particular category.
                            Lt and Gt perform numeric comparisons (requires feature gate TaintTolerationComparisonOperators).
                            EOT
                            "type" = "string"
                          }
                          "tolerationSeconds" = {
                            "description" = <<-EOT
                            TolerationSeconds represents the period of time the toleration (which must be
                            of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default,
                            it is not set, which means tolerate the taint forever (do not evict). Zero and
                            negative values will be treated as 0 (evict immediately) by the system.
                            EOT
                            "format" = "int64"
                            "type" = "integer"
                          }
                          "value" = {
                            "description" = <<-EOT
                            Value is the taint value the toleration matches to.
                            If the operator is Exists, the value should be empty, otherwise just a regular string.
                            EOT
                            "type" = "string"
                          }
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "topologySpreadConstraints" = {
                      "description" = "topologySpreadConstraints defines the pod's topology spread constraints if specified."
                      "items" = {
                        "properties" = {
                          "additionalLabelSelectors" = {
                            "description" = "additionalLabelSelectors Defines what Prometheus Operator managed labels should be added to labelSelector on the topologySpreadConstraint."
                            "enum" = [
                              "OnResource",
                              "OnShard",
                            ]
                            "type" = "string"
                          }
                          "labelSelector" = {
                            "description" = <<-EOT
                            LabelSelector is used to find matching pods.
                            Pods that match this label selector are counted to determine the number of pods
                            in their corresponding topology domain.
                            EOT
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
                          "matchLabelKeys" = {
                            "description" = <<-EOT
                            MatchLabelKeys is a set of pod label keys to select the pods over which
                            spreading will be calculated. The keys are used to lookup values from the
                            incoming pod labels, those key-value labels are ANDed with labelSelector
                            to select the group of existing pods over which spreading will be calculated
                            for the incoming pod. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector.
                            MatchLabelKeys cannot be set when LabelSelector isn't set.
                            Keys that don't exist in the incoming pod labels will
                            be ignored. A null or empty list means only match against labelSelector.
                            
                            This is a beta field and requires the MatchLabelKeysInPodTopologySpread feature gate to be enabled (enabled by default).
                            EOT
                            "items" = {
                              "type" = "string"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "atomic"
                          }
                          "maxSkew" = {
                            "description" = <<-EOT
                            MaxSkew describes the degree to which pods may be unevenly distributed.
                            When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference
                            between the number of matching pods in the target topology and the global minimum.
                            The global minimum is the minimum number of matching pods in an eligible domain
                            or zero if the number of eligible domains is less than MinDomains.
                            For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same
                            labelSelector spread as 2/2/1:
                            In this case, the global minimum is 1.
                            | zone1 | zone2 | zone3 |
                            |  P P  |  P P  |   P   |
                            - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2;
                            scheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2)
                            violate MaxSkew(1).
                            - if MaxSkew is 2, incoming pod can be scheduled onto any zone.
                            When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence
                            to topologies that satisfy it.
                            It's a required field. Default value is 1 and 0 is not allowed.
                            EOT
                            "format" = "int32"
                            "type" = "integer"
                          }
                          "minDomains" = {
                            "description" = <<-EOT
                            MinDomains indicates a minimum number of eligible domains.
                            When the number of eligible domains with matching topology keys is less than minDomains,
                            Pod Topology Spread treats "global minimum" as 0, and then the calculation of Skew is performed.
                            And when the number of eligible domains with matching topology keys equals or greater than minDomains,
                            this value has no effect on scheduling.
                            As a result, when the number of eligible domains is less than minDomains,
                            scheduler won't schedule more than maxSkew Pods to those domains.
                            If value is nil, the constraint behaves as if MinDomains is equal to 1.
                            Valid values are integers greater than 0.
                            When value is not nil, WhenUnsatisfiable must be DoNotSchedule.
                            
                            For example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same
                            labelSelector spread as 2/2/2:
                            | zone1 | zone2 | zone3 |
                            |  P P  |  P P  |  P P  |
                            The number of domains is less than 5(MinDomains), so "global minimum" is treated as 0.
                            In this situation, new pod with the same labelSelector cannot be scheduled,
                            because computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones,
                            it will violate MaxSkew.
                            EOT
                            "format" = "int32"
                            "type" = "integer"
                          }
                          "nodeAffinityPolicy" = {
                            "description" = <<-EOT
                            NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector
                            when calculating pod topology spread skew. Options are:
                            - Honor: only nodes matching nodeAffinity/nodeSelector are included in the calculations.
                            - Ignore: nodeAffinity/nodeSelector are ignored. All nodes are included in the calculations.
                            
                            If this value is nil, the behavior is equivalent to the Honor policy.
                            EOT
                            "type" = "string"
                          }
                          "nodeTaintsPolicy" = {
                            "description" = <<-EOT
                            NodeTaintsPolicy indicates how we will treat node taints when calculating
                            pod topology spread skew. Options are:
                            - Honor: nodes without taints, along with tainted nodes for which the incoming pod
                            has a toleration, are included.
                            - Ignore: node taints are ignored. All nodes are included.
                            
                            If this value is nil, the behavior is equivalent to the Ignore policy.
                            EOT
                            "type" = "string"
                          }
                          "topologyKey" = {
                            "description" = <<-EOT
                            TopologyKey is the key of node labels. Nodes that have a label with this key
                            and identical values are considered to be in the same topology.
                            We consider each <key, value> as a "bucket", and try to put balanced number
                            of pods into each bucket.
                            We define a domain as a particular instance of a topology.
                            Also, we define an eligible domain as a domain whose nodes meet the requirements of
                            nodeAffinityPolicy and nodeTaintsPolicy.
                            e.g. If TopologyKey is "kubernetes.io/hostname", each Node is a domain of that topology.
                            And, if TopologyKey is "topology.kubernetes.io/zone", each zone is a domain of that topology.
                            It's a required field.
                            EOT
                            "type" = "string"
                          }
                          "whenUnsatisfiable" = {
                            "description" = <<-EOT
                            WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy
                            the spread constraint.
                            - DoNotSchedule (default) tells the scheduler not to schedule it.
                            - ScheduleAnyway tells the scheduler to schedule the pod in any location,
                              but giving higher precedence to topologies that would help reduce the
                              skew.
                            A constraint is considered "Unsatisfiable" for an incoming pod
                            if and only if every possible node assignment for that pod would violate
                            "MaxSkew" on some topology.
                            For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same
                            labelSelector spread as 3/1/1:
                            | zone1 | zone2 | zone3 |
                            | P P P |   P   |   P   |
                            If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled
                            to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies
                            MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler
                            won't make it *more* imbalanced.
                            It's a required field.
                            EOT
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "maxSkew",
                          "topologyKey",
                          "whenUnsatisfiable",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "tracingConfig" = {
                      "description" = <<-EOT
                      tracingConfig defines tracing in Prometheus.
                      
                      This is an *experimental feature*, it may change in any upcoming release
                      in a breaking way.
                      EOT
                      "properties" = {
                        "clientType" = {
                          "description" = "clientType defines the client used to export the traces. Supported values are `HTTP` and `GRPC`."
                          "enum" = [
                            "http",
                            "grpc",
                            "HTTP",
                            "GRPC",
                          ]
                          "type" = "string"
                        }
                        "compression" = {
                          "description" = "compression key for supported compression types. The only supported value is `Gzip`."
                          "enum" = [
                            "gzip",
                            "Gzip",
                          ]
                          "type" = "string"
                        }
                        "endpoint" = {
                          "description" = "endpoint to send the traces to. Should be provided in format <host>:<port>."
                          "minLength" = 1
                          "type" = "string"
                        }
                        "headers" = {
                          "additionalProperties" = {
                            "type" = "string"
                          }
                          "description" = "headers defines the key-value pairs to be used as headers associated with gRPC or HTTP requests."
                          "type" = "object"
                        }
                        "insecure" = {
                          "description" = "insecure if disabled, the client will use a secure connection."
                          "type" = "boolean"
                        }
                        "samplingFraction" = {
                          "anyOf" = [
                            {
                              "type" = "integer"
                            },
                            {
                              "type" = "string"
                            },
                          ]
                          "description" = "samplingFraction defines the probability a given trace will be sampled. Must be a float from 0 through 1."
                          "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                          "x-kubernetes-int-or-string" = true
                        }
                        "timeout" = {
                          "description" = "timeout defines the maximum time the exporter will wait for each batch export."
                          "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                          "type" = "string"
                        }
                        "tlsConfig" = {
                          "description" = "tlsConfig to use when sending traces."
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
                            "caFile" = {
                              "description" = "caFile defines the path to the CA cert in the Prometheus container to use for the targets."
                              "type" = "string"
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
                            "certFile" = {
                              "description" = "certFile defines the path to the client cert file in the Prometheus container for the targets."
                              "type" = "string"
                            }
                            "insecureSkipVerify" = {
                              "description" = "insecureSkipVerify defines how to disable target certificate validation."
                              "type" = "boolean"
                            }
                            "keyFile" = {
                              "description" = "keyFile defines the path to the client key file in the Prometheus container for the targets."
                              "type" = "string"
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
                        "endpoint",
                      ]
                      "type" = "object"
                    }
                    "tsdb" = {
                      "description" = <<-EOT
                      tsdb defines the runtime reloadable configuration of the timeseries database(TSDB).
                      It requires Prometheus >= v2.39.0 or PrometheusAgent >= v2.54.0.
                      EOT
                      "properties" = {
                        "chunkEncoding" = {
                          "description" = <<-EOT
                          chunkEncoding configures per-chunk-type encoding overrides.
                          
                          It requires Prometheus >= v3.13.0.
                          
                          Notice: Setting "Xor" is incompatible with --enable-feature=st-storage
                          (XOR chunks do not store start timestamps).
                          EOT
                          "properties" = {
                            "floats" = {
                              "description" = <<-EOT
                              floats selects the encoding used for float chunks.
                              Valid values are "Xor" and "Xor2".
                              
                              Notice:
                               * Setting "Xor" is incompatible with --enable-feature=st-storage
                              (XOR chunks do not store start timestamps).
                               * Setting "Xor2" automatically adds the `xor2-encoding` feature flag.
                              
                              It requires Prometheus >= v3.13.0.
                              EOT
                              "enum" = [
                                "Xor",
                                "Xor2",
                              ]
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                        "outOfOrderTimeWindow" = {
                          "description" = <<-EOT
                          outOfOrderTimeWindow defines how old an out-of-order/out-of-bounds sample can be with
                          respect to the TSDB max time.
                          
                          An out-of-order/out-of-bounds sample is ingested into the TSDB as long as
                          the timestamp of the sample is >= (TSDB.MaxTime - outOfOrderTimeWindow).
                          
                          This is an *experimental feature*, it may change in any upcoming release
                          in a breaking way.
                          
                          It requires Prometheus >= v2.39.0 or PrometheusAgent >= v2.54.0.
                          EOT
                          "pattern" = "^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
                          "type" = "string"
                        }
                        "staleSeriesCompactionThreshold" = {
                          "anyOf" = [
                            {
                              "type" = "integer"
                            },
                            {
                              "type" = "string"
                            },
                          ]
                          "description" = <<-EOT
                          staleSeriesCompactionThreshold configures the trigger point for compacting
                          stale series from memory into persistent blocks and removing those stale
                          series from memory.
                          
                          The threshold is a number between 0.0 and 1.0. It represents the ratio of
                          stale series in memory to the total series in memory. The stale series
                          compaction is triggered when this ratio crosses the configured threshold.
                          It may not trigger the stale series compaction if the usual head compaction
                          is about to happen soon.
                          
                          If set to 0, stale series compaction is disabled.
                          
                          It requires Prometheus >= v3.10.0.
                          EOT
                          "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                          "x-kubernetes-int-or-string" = true
                        }
                      }
                      "type" = "object"
                    }
                    "updateStrategy" = {
                      "description" = <<-EOT
                      updateStrategy indicates the strategy that will be employed to update
                      Pods in the StatefulSet when a revision is made to statefulset's Pod
                      Template.
                      
                      The default strategy is RollingUpdate.
                      EOT
                      "properties" = {
                        "rollingUpdate" = {
                          "description" = "rollingUpdate is used to communicate parameters when type is RollingUpdate."
                          "properties" = {
                            "maxUnavailable" = {
                              "anyOf" = [
                                {
                                  "type" = "integer"
                                },
                                {
                                  "type" = "string"
                                },
                              ]
                              "description" = <<-EOT
                              maxUnavailable is the maximum number of pods that can be unavailable
                              during the update. The value can be an absolute number (ex: 5) or a
                              percentage of desired pods (ex: 10%). Absolute number is calculated from
                              percentage by rounding up. This can not be 0.  Defaults to 1. This field
                              is alpha-level and is only honored by servers that enable the
                              MaxUnavailableStatefulSet feature. The field applies to all pods in the
                              range 0 to Replicas-1.  That means if there is any unavailable pod in
                              the range 0 to Replicas-1, it will be counted towards MaxUnavailable.
                              EOT
                              "x-kubernetes-int-or-string" = true
                            }
                          }
                          "type" = "object"
                        }
                        "type" = {
                          "description" = <<-EOT
                          type indicates the type of the StatefulSetUpdateStrategy.
                          
                          Default is RollingUpdate.
                          EOT
                          "enum" = [
                            "OnDelete",
                            "RollingUpdate",
                          ]
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "type",
                      ]
                      "type" = "object"
                      "x-kubernetes-validations" = [
                        {
                          "message" = "rollingUpdate requires type to be RollingUpdate"
                          "rule" = "!(self.type != 'RollingUpdate' && has(self.rollingUpdate))"
                        },
                      ]
                    }
                    "version" = {
                      "description" = <<-EOT
                      version of Prometheus being deployed. The operator uses this information
                      to generate the Prometheus StatefulSet + configuration files.
                      
                      If not specified, the operator assumes the latest upstream version of
                      Prometheus available at the time when the version of the operator was
                      released.
                      EOT
                      "type" = "string"
                    }
                    "volumeMounts" = {
                      "description" = <<-EOT
                      volumeMounts allows the configuration of additional VolumeMounts.
                      
                      VolumeMounts will be appended to other VolumeMounts in the 'prometheus'
                      container, that are generated as a result of StorageSpec objects.
                      EOT
                      "items" = {
                        "description" = "VolumeMount describes a mounting of a Volume within a container."
                        "properties" = {
                          "bindMountOptions" = {
                            "description" = <<-EOT
                            bindMountOptions is the list of additional bind mount options to apply when
                            mounting this volume into the container. Allowed values are noexec,
                            nodev, and nosuid. These are Linux mount options and have no effect on
                            Windows nodes.
                            This field is not supported with image volumes.
                            This is an alpha field and requires enabling the VolumeBindMountOptions feature gate.
                            EOT
                            "items" = {
                              "type" = "string"
                            }
                            "type" = "array"
                            "x-kubernetes-list-type" = "set"
                          }
                          "mountPath" = {
                            "description" = "Path within the container at which the volume should be mounted."
                            "type" = "string"
                          }
                          "mountPropagation" = {
                            "description" = <<-EOT
                            mountPropagation determines how mounts are propagated from the host
                            to container and the other way around.
                            When not set, MountPropagationNone is used.
                            This field is beta in 1.10.
                            When RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation must be None or unspecified
                            (which defaults to None).
                            EOT
                            "type" = "string"
                          }
                          "name" = {
                            "description" = "This must match the Name of a Volume."
                            "type" = "string"
                          }
                          "readOnly" = {
                            "description" = <<-EOT
                            Mounted read-only if true, read-write otherwise (false or unspecified).
                            Defaults to false.
                            EOT
                            "type" = "boolean"
                          }
                          "recursiveReadOnly" = {
                            "description" = <<-EOT
                            RecursiveReadOnly specifies whether read-only mounts should be handled
                            recursively.
                            
                            If ReadOnly is false, this field has no meaning and must be unspecified.
                            
                            If ReadOnly is true, and this field is set to Disabled, the mount is not made
                            recursively read-only.  If this field is set to IfPossible, the mount is made
                            recursively read-only, if it is supported by the container runtime.  If this
                            field is set to Enabled, the mount is made recursively read-only if it is
                            supported by the container runtime, otherwise the pod will not be started and
                            an error will be generated to indicate the reason.
                            
                            If this field is set to IfPossible or Enabled, MountPropagation must be set to
                            None (or be unspecified, which defaults to None).
                            
                            If this field is not specified, it is treated as an equivalent of Disabled.
                            EOT
                            "type" = "string"
                          }
                          "subPath" = {
                            "description" = <<-EOT
                            Path within the volume from which the container's volume should be mounted.
                            Defaults to "" (volume's root).
                            EOT
                            "type" = "string"
                          }
                          "subPathExpr" = {
                            "description" = <<-EOT
                            Expanded path within the volume from which the container's volume should be mounted.
                            Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment.
                            Defaults to "" (volume's root).
                            SubPathExpr and SubPath are mutually exclusive.
                            EOT
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "mountPath",
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "volumes" = {
                      "description" = <<-EOT
                      volumes allows the configuration of additional volumes on the output
                      StatefulSet definition. Volumes specified will be appended to other
                      volumes that are generated as a result of StorageSpec objects.
                      EOT
                      "items" = {
                        "description" = "Volume represents a named volume in a pod that may be accessed by any container in the pod."
                        "properties" = {
                          "awsElasticBlockStore" = {
                            "description" = <<-EOT
                            awsElasticBlockStore represents an AWS Disk resource that is attached to a
                            kubelet's host machine and then exposed to the pod.
                            Deprecated: AWSElasticBlockStore is deprecated. All operations for the in-tree
                            awsElasticBlockStore type are redirected to the ebs.csi.aws.com CSI driver.
                            More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
                            EOT
                            "properties" = {
                              "fsType" = {
                                "description" = <<-EOT
                                fsType is the filesystem type of the volume that you want to mount.
                                Tip: Ensure that the filesystem type is supported by the host operating system.
                                Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
                                EOT
                                "type" = "string"
                              }
                              "partition" = {
                                "description" = <<-EOT
                                partition is the partition in the volume that you want to mount.
                                If omitted, the default is to mount by volume name.
                                Examples: For volume /dev/sda1, you specify the partition as "1".
                                Similarly, the volume partition for /dev/sda is "0" (or you can leave the property empty).
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly value true will force the readOnly setting in VolumeMounts.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
                                EOT
                                "type" = "boolean"
                              }
                              "volumeID" = {
                                "description" = <<-EOT
                                volumeID is unique ID of the persistent disk resource in AWS (Amazon EBS volume).
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
                                EOT
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "volumeID",
                            ]
                            "type" = "object"
                          }
                          "azureDisk" = {
                            "description" = <<-EOT
                            azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.
                            Deprecated: AzureDisk is deprecated. All operations for the in-tree azureDisk type
                            are redirected to the disk.csi.azure.com CSI driver.
                            EOT
                            "properties" = {
                              "cachingMode" = {
                                "description" = "cachingMode is the Host Caching mode: None, Read Only, Read Write."
                                "type" = "string"
                              }
                              "diskName" = {
                                "description" = "diskName is the Name of the data disk in the blob storage"
                                "type" = "string"
                              }
                              "diskURI" = {
                                "description" = "diskURI is the URI of data disk in the blob storage"
                                "type" = "string"
                              }
                              "fsType" = {
                                "default" = "ext4"
                                "description" = <<-EOT
                                fsType is Filesystem type to mount.
                                Must be a filesystem type supported by the host operating system.
                                Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                                EOT
                                "type" = "string"
                              }
                              "kind" = {
                                "description" = "kind expected values are Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared"
                                "type" = "string"
                              }
                              "readOnly" = {
                                "default" = false
                                "description" = <<-EOT
                                readOnly Defaults to false (read/write). ReadOnly here will force
                                the ReadOnly setting in VolumeMounts.
                                EOT
                                "type" = "boolean"
                              }
                            }
                            "required" = [
                              "diskName",
                              "diskURI",
                            ]
                            "type" = "object"
                          }
                          "azureFile" = {
                            "description" = <<-EOT
                            azureFile represents an Azure File Service mount on the host and bind mount to the pod.
                            Deprecated: AzureFile is deprecated. All operations for the in-tree azureFile type
                            are redirected to the file.csi.azure.com CSI driver.
                            EOT
                            "properties" = {
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly defaults to false (read/write). ReadOnly here will force
                                the ReadOnly setting in VolumeMounts.
                                EOT
                                "type" = "boolean"
                              }
                              "secretName" = {
                                "description" = "secretName is the  name of secret that contains Azure Storage Account Name and Key"
                                "type" = "string"
                              }
                              "shareName" = {
                                "description" = "shareName is the azure share Name"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "secretName",
                              "shareName",
                            ]
                            "type" = "object"
                          }
                          "cephfs" = {
                            "description" = <<-EOT
                            cephFS represents a Ceph FS mount on the host that shares a pod's lifetime.
                            Deprecated: CephFS is deprecated and the in-tree cephfs type is no longer supported.
                            EOT
                            "properties" = {
                              "monitors" = {
                                "description" = <<-EOT
                                monitors is Required: Monitors is a collection of Ceph monitors
                                More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                                EOT
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                                "x-kubernetes-list-type" = "atomic"
                              }
                              "path" = {
                                "description" = "path is Optional: Used as the mounted root, rather than the full Ceph tree, default is /"
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly is Optional: Defaults to false (read/write). ReadOnly here will force
                                the ReadOnly setting in VolumeMounts.
                                More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                                EOT
                                "type" = "boolean"
                              }
                              "secretFile" = {
                                "description" = <<-EOT
                                secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret
                                More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                                EOT
                                "type" = "string"
                              }
                              "secretRef" = {
                                "description" = <<-EOT
                                secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty.
                                More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                                EOT
                                "properties" = {
                                  "name" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Name of the referent.
                                    This field is effectively required, but due to backwards compatibility is
                                    allowed to be empty. Instances of this type with an empty value here are
                                    almost certainly wrong.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                                "x-kubernetes-map-type" = "atomic"
                              }
                              "user" = {
                                "description" = <<-EOT
                                user is optional: User is the rados user name, default is admin
                                More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
                                EOT
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "monitors",
                            ]
                            "type" = "object"
                          }
                          "cinder" = {
                            "description" = <<-EOT
                            cinder represents a cinder volume attached and mounted on kubelets host machine.
                            Deprecated: Cinder is deprecated. All operations for the in-tree cinder type
                            are redirected to the cinder.csi.openstack.org CSI driver.
                            More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                            EOT
                            "properties" = {
                              "fsType" = {
                                "description" = <<-EOT
                                fsType is the filesystem type to mount.
                                Must be a filesystem type supported by the host operating system.
                                Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                                More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                                EOT
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly defaults to false (read/write). ReadOnly here will force
                                the ReadOnly setting in VolumeMounts.
                                More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                                EOT
                                "type" = "boolean"
                              }
                              "secretRef" = {
                                "description" = <<-EOT
                                secretRef is optional: points to a secret object containing parameters used to connect
                                to OpenStack.
                                EOT
                                "properties" = {
                                  "name" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Name of the referent.
                                    This field is effectively required, but due to backwards compatibility is
                                    allowed to be empty. Instances of this type with an empty value here are
                                    almost certainly wrong.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                                "x-kubernetes-map-type" = "atomic"
                              }
                              "volumeID" = {
                                "description" = <<-EOT
                                volumeID used to identify the volume in cinder.
                                More info: https://examples.k8s.io/mysql-cinder-pd/README.md
                                EOT
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "volumeID",
                            ]
                            "type" = "object"
                          }
                          "configMap" = {
                            "description" = "configMap represents a configMap that should populate this volume"
                            "properties" = {
                              "defaultMode" = {
                                "description" = <<-EOT
                                defaultMode is optional: mode bits used to set permissions on created files by default.
                                Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
                                YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
                                Defaults to 0644.
                                Directories within the path are not affected by this setting.
                                This might be in conflict with other options that affect the file
                                mode, like fsGroup, and the result can be other mode bits set.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "defaultUser" = {
                                "description" = <<-EOT
                                defaultUser is Optional: The owner UID of the created files by default.
                                The defaultUser field is only used as a fallback when the item-level user field is unset.
                                (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "items" = {
                                "description" = <<-EOT
                                items if unspecified, each key-value pair in the Data field of the referenced
                                ConfigMap will be projected into the volume as a file whose name is the
                                key and content is the value. If specified, the listed keys will be
                                projected into the specified paths, and unlisted keys will not be
                                present. If a key is specified which is not present in the ConfigMap,
                                the volume setup will error unless it is marked optional. Paths must be
                                relative and may not contain the '..' path or start with '..'.
                                EOT
                                "items" = {
                                  "description" = "Maps a string key to a path within a volume."
                                  "properties" = {
                                    "key" = {
                                      "description" = "key is the key to project."
                                      "type" = "string"
                                    }
                                    "mode" = {
                                      "description" = <<-EOT
                                      mode is Optional: mode bits used to set permissions on this file.
                                      Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
                                      YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
                                      If not specified, the volume defaultMode will be used.
                                      This might be in conflict with other options that affect the file
                                      mode, like fsGroup, and the result can be other mode bits set.
                                      EOT
                                      "format" = "int32"
                                      "type" = "integer"
                                    }
                                    "path" = {
                                      "description" = <<-EOT
                                      path is the relative path of the file to map the key to.
                                      May not be an absolute path.
                                      May not contain the path element '..'.
                                      May not start with the string '..'.
                                      EOT
                                      "type" = "string"
                                    }
                                    "user" = {
                                      "description" = <<-EOT
                                      user is Optional: The owner UID of the created file.
                                      If specified, the item-level user field takes precedence over defaultUser.
                                      (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                      EOT
                                      "format" = "int64"
                                      "type" = "integer"
                                    }
                                  }
                                  "required" = [
                                    "key",
                                    "path",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                                "x-kubernetes-list-type" = "atomic"
                              }
                              "name" = {
                                "default" = ""
                                "description" = <<-EOT
                                Name of the referent.
                                This field is effectively required, but due to backwards compatibility is
                                allowed to be empty. Instances of this type with an empty value here are
                                almost certainly wrong.
                                More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                EOT
                                "type" = "string"
                              }
                              "optional" = {
                                "description" = "optional specify whether the ConfigMap or its keys must be defined"
                                "type" = "boolean"
                              }
                            }
                            "type" = "object"
                            "x-kubernetes-map-type" = "atomic"
                          }
                          "csi" = {
                            "description" = "csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers."
                            "properties" = {
                              "driver" = {
                                "description" = <<-EOT
                                driver is the name of the CSI driver that handles this volume.
                                Consult with your admin for the correct name as registered in the cluster.
                                EOT
                                "type" = "string"
                              }
                              "fsType" = {
                                "description" = <<-EOT
                                fsType to mount. Ex. "ext4", "xfs", "ntfs".
                                If not provided, the empty value is passed to the associated CSI driver
                                which will determine the default filesystem to apply.
                                EOT
                                "type" = "string"
                              }
                              "nodePublishSecretRef" = {
                                "description" = <<-EOT
                                nodePublishSecretRef is a reference to the secret object containing
                                sensitive information to pass to the CSI driver to complete the CSI
                                NodePublishVolume and NodeUnpublishVolume calls.
                                This field is optional, and  may be empty if no secret is required. If the
                                secret object contains more than one secret, all secret references are passed.
                                EOT
                                "properties" = {
                                  "name" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Name of the referent.
                                    This field is effectively required, but due to backwards compatibility is
                                    allowed to be empty. Instances of this type with an empty value here are
                                    almost certainly wrong.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                                "x-kubernetes-map-type" = "atomic"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly specifies a read-only configuration for the volume.
                                Defaults to false (read/write).
                                EOT
                                "type" = "boolean"
                              }
                              "volumeAttributes" = {
                                "additionalProperties" = {
                                  "type" = "string"
                                }
                                "description" = <<-EOT
                                volumeAttributes stores driver-specific properties that are passed to the CSI
                                driver. Consult your driver's documentation for supported values.
                                EOT
                                "type" = "object"
                              }
                            }
                            "required" = [
                              "driver",
                            ]
                            "type" = "object"
                          }
                          "downwardAPI" = {
                            "description" = "downwardAPI represents downward API about the pod that should populate this volume"
                            "properties" = {
                              "defaultMode" = {
                                "description" = <<-EOT
                                Optional: mode bits to use on created files by default. Must be a
                                Optional: mode bits used to set permissions on created files by default.
                                Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
                                YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
                                Defaults to 0644.
                                Directories within the path are not affected by this setting.
                                This might be in conflict with other options that affect the file
                                mode, like fsGroup, and the result can be other mode bits set.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "defaultUser" = {
                                "description" = <<-EOT
                                defaultUser is Optional: The owner UID of the created files by default.
                                The defaultUser field is only used as a fallback when the item-level user field is unset.
                                (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "items" = {
                                "description" = "Items is a list of downward API volume file"
                                "items" = {
                                  "description" = "DownwardAPIVolumeFile represents information to create the file containing the pod field"
                                  "properties" = {
                                    "fieldRef" = {
                                      "description" = "Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported."
                                      "properties" = {
                                        "apiVersion" = {
                                          "description" = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
                                          "type" = "string"
                                        }
                                        "fieldPath" = {
                                          "description" = "Path of the field to select in the specified API version."
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "fieldPath",
                                      ]
                                      "type" = "object"
                                      "x-kubernetes-map-type" = "atomic"
                                    }
                                    "mode" = {
                                      "description" = <<-EOT
                                      Optional: mode bits used to set permissions on this file, must be an octal value
                                      between 0000 and 0777 or a decimal value between 0 and 511.
                                      YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
                                      If not specified, the volume defaultMode will be used.
                                      This might be in conflict with other options that affect the file
                                      mode, like fsGroup, and the result can be other mode bits set.
                                      EOT
                                      "format" = "int32"
                                      "type" = "integer"
                                    }
                                    "path" = {
                                      "description" = "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
                                      "type" = "string"
                                    }
                                    "resourceFieldRef" = {
                                      "description" = <<-EOT
                                      Selects a resource of the container: only resources limits and requests
                                      (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.
                                      EOT
                                      "properties" = {
                                        "containerName" = {
                                          "description" = "Container name: required for volumes, optional for env vars"
                                          "type" = "string"
                                        }
                                        "divisor" = {
                                          "anyOf" = [
                                            {
                                              "type" = "integer"
                                            },
                                            {
                                              "type" = "string"
                                            },
                                          ]
                                          "description" = "Specifies the output format of the exposed resources, defaults to \"1\""
                                          "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                          "x-kubernetes-int-or-string" = true
                                        }
                                        "resource" = {
                                          "description" = "Required: resource to select"
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "resource",
                                      ]
                                      "type" = "object"
                                      "x-kubernetes-map-type" = "atomic"
                                    }
                                    "user" = {
                                      "description" = <<-EOT
                                      user is Optional: The owner UID of the created file.
                                      If specified, the item-level user field takes precedence over defaultUser.
                                      (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                      EOT
                                      "format" = "int64"
                                      "type" = "integer"
                                    }
                                  }
                                  "required" = [
                                    "path",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                                "x-kubernetes-list-type" = "atomic"
                              }
                            }
                            "type" = "object"
                          }
                          "emptyDir" = {
                            "description" = <<-EOT
                            emptyDir represents a temporary directory that shares a pod's lifetime.
                            More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
                            EOT
                            "properties" = {
                              "medium" = {
                                "description" = <<-EOT
                                medium represents what type of storage medium should back this directory.
                                The default is "" which means to use the node's default medium.
                                Must be an empty string (default) or Memory.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
                                EOT
                                "type" = "string"
                              }
                              "mode" = {
                                "description" = <<-EOT
                                mode specifies the permission bits for the emptyDir directory, in numeric
                                notation (e.g., 0755, 01777). Must be a value between 0000 and 01777.
                                If not specified, defaults to 0777.
                                This might be in conflict with other options that affect the file
                                mode, like fsGroup. If fsGroup is specified, the fsGroup permissions
                                will override the mode specified here.
                                This field has no effect on Windows.
                                This field is alpha and requires EmptyDirVolumeMode featuregate to be enabled.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "sizeLimit" = {
                                "anyOf" = [
                                  {
                                    "type" = "integer"
                                  },
                                  {
                                    "type" = "string"
                                  },
                                ]
                                "description" = <<-EOT
                                sizeLimit is the total amount of local storage required for this EmptyDir volume.
                                The size limit is also applicable for memory medium.
                                The maximum usage on memory medium EmptyDir would be the minimum value between
                                the SizeLimit specified here and the sum of memory limits of all containers in a pod.
                                The default is nil which means that the limit is undefined.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
                                EOT
                                "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                "x-kubernetes-int-or-string" = true
                              }
                            }
                            "type" = "object"
                          }
                          "ephemeral" = {
                            "description" = <<-EOT
                            ephemeral represents a volume that is handled by a cluster storage driver.
                            The volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts,
                            and deleted when the pod is removed.
                            
                            Use this if:
                            a) the volume is only needed while the pod runs,
                            b) features of normal volumes like restoring from snapshot or capacity
                               tracking are needed,
                            c) the storage driver is specified through a storage class, and
                            d) the storage driver supports dynamic volume provisioning through
                               a PersistentVolumeClaim (see EphemeralVolumeSource for more
                               information on the connection between this volume type
                               and PersistentVolumeClaim).
                            
                            Use PersistentVolumeClaim or one of the vendor-specific
                            APIs for volumes that persist for longer than the lifecycle
                            of an individual pod.
                            
                            Use CSI for light-weight local ephemeral volumes if the CSI driver is meant to
                            be used that way - see the documentation of the driver for
                            more information.
                            
                            A pod can use both types of ephemeral volumes and
                            persistent volumes at the same time.
                            EOT
                            "properties" = {
                              "volumeClaimTemplate" = {
                                "description" = <<-EOT
                                Will be used to create a stand-alone PVC to provision the volume.
                                The pod in which this EphemeralVolumeSource is embedded will be the
                                owner of the PVC, i.e. the PVC will be deleted together with the
                                pod.  The name of the PVC will be `<pod name>-<volume name>` where
                                `<volume name>` is the name from the `PodSpec.Volumes` array
                                entry. Pod validation will reject the pod if the concatenated name
                                is not valid for a PVC (for example, too long).
                                
                                An existing PVC with that name that is not owned by the pod
                                will *not* be used for the pod to avoid using an unrelated
                                volume by mistake. Starting the pod is then blocked until
                                the unrelated PVC is removed. If such a pre-created PVC is
                                meant to be used by the pod, the PVC has to updated with an
                                owner reference to the pod once the pod exists. Normally
                                this should not be necessary, but it may be useful when
                                manually reconstructing a broken cluster.
                                
                                This field is read-only and no changes will be made by Kubernetes
                                to the PVC after it has been created.
                                
                                Required, must not be nil.
                                EOT
                                "properties" = {
                                  "metadata" = {
                                    "description" = <<-EOT
                                    May contain labels and annotations that will be copied into the PVC
                                    when creating it. No other fields are allowed and will be rejected during
                                    validation.
                                    EOT
                                    "type" = "object"
                                  }
                                  "spec" = {
                                    "description" = <<-EOT
                                    The specification for the PersistentVolumeClaim. The entire content is
                                    copied unchanged into the PVC that gets created from this
                                    template. The same fields as in a PersistentVolumeClaim
                                    are also valid here.
                                    EOT
                                    "properties" = {
                                      "accessModes" = {
                                        "description" = <<-EOT
                                        accessModes contains the desired access modes the volume should have.
                                        More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
                                        EOT
                                        "items" = {
                                          "type" = "string"
                                        }
                                        "type" = "array"
                                        "x-kubernetes-list-type" = "atomic"
                                      }
                                      "dataSource" = {
                                        "description" = <<-EOT
                                        dataSource field can be used to specify either:
                                        * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)
                                        * An existing PVC (PersistentVolumeClaim)
                                        If the provisioner or an external controller can support the specified data source,
                                        it will create a new volume based on the contents of the specified data source.
                                        dataSource contents will be copied to dataSourceRef, and dataSourceRef contents will be
                                        copied to dataSource when dataSourceRef.namespace is not specified.
                                        If the namespace is specified, then dataSourceRef will not be copied to dataSource.
                                        EOT
                                        "properties" = {
                                          "apiGroup" = {
                                            "description" = <<-EOT
                                            APIGroup is the group for the resource being referenced.
                                            If APIGroup is not specified, the specified Kind must be in the core API group.
                                            For any other third-party types, APIGroup is required.
                                            EOT
                                            "type" = "string"
                                          }
                                          "kind" = {
                                            "description" = "Kind is the type of resource being referenced"
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name is the name of resource being referenced"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "kind",
                                          "name",
                                        ]
                                        "type" = "object"
                                        "x-kubernetes-map-type" = "atomic"
                                      }
                                      "dataSourceRef" = {
                                        "description" = <<-EOT
                                        dataSourceRef specifies the object from which to populate the volume with data, if a non-empty
                                        volume is desired. This may be any object from a non-empty API group (non
                                        core object) or a PersistentVolumeClaim object.
                                        When this field is specified, volume binding will only succeed if the type of
                                        the specified object matches some installed volume populator or dynamic
                                        provisioner.
                                        This field will replace the functionality of the dataSource field and as such
                                        if both fields are non-empty, they must have the same value. For backwards
                                        compatibility, when namespace isn't specified in dataSourceRef,
                                        both fields (dataSource and dataSourceRef) will be set to the same
                                        value automatically if one of them is empty and the other is non-empty.
                                        When namespace is specified in dataSourceRef,
                                        dataSource isn't set to the same value and must be empty.
                                        There are three important differences between dataSource and dataSourceRef:
                                        * While dataSource only allows two specific types of objects, dataSourceRef
                                          allows any non-core object, as well as PersistentVolumeClaim objects.
                                        * While dataSource ignores disallowed values (dropping them), dataSourceRef
                                          preserves all values, and generates an error if a disallowed value is
                                          specified.
                                        * While dataSource only allows local objects, dataSourceRef allows objects
                                          in any namespaces.
                                        (Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
                                        EOT
                                        "properties" = {
                                          "apiGroup" = {
                                            "description" = <<-EOT
                                            APIGroup is the group for the resource being referenced.
                                            If APIGroup is not specified, the specified Kind must be in the core API group.
                                            For any other third-party types, APIGroup is required.
                                            EOT
                                            "type" = "string"
                                          }
                                          "kind" = {
                                            "description" = "Kind is the type of resource being referenced"
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "description" = "Name is the name of resource being referenced"
                                            "type" = "string"
                                          }
                                          "namespace" = {
                                            "description" = <<-EOT
                                            Namespace is the namespace of resource being referenced
                                            Note that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details.
                                            (Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
                                            EOT
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "kind",
                                          "name",
                                        ]
                                        "type" = "object"
                                      }
                                      "resources" = {
                                        "description" = <<-EOT
                                        resources represents the minimum resources the volume should have.
                                        Users are allowed to specify resource requirements
                                        that are lower than previous value but must still be higher than capacity recorded in the
                                        status field of the claim.
                                        More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources
                                        EOT
                                        "properties" = {
                                          "limits" = {
                                            "additionalProperties" = {
                                              "anyOf" = [
                                                {
                                                  "type" = "integer"
                                                },
                                                {
                                                  "type" = "string"
                                                },
                                              ]
                                              "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                              "x-kubernetes-int-or-string" = true
                                            }
                                            "description" = <<-EOT
                                            Limits describes the maximum amount of compute resources allowed.
                                            More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                                            EOT
                                            "type" = "object"
                                          }
                                          "requests" = {
                                            "additionalProperties" = {
                                              "anyOf" = [
                                                {
                                                  "type" = "integer"
                                                },
                                                {
                                                  "type" = "string"
                                                },
                                              ]
                                              "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                              "x-kubernetes-int-or-string" = true
                                            }
                                            "description" = <<-EOT
                                            Requests describes the minimum amount of compute resources required.
                                            If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
                                            otherwise to an implementation-defined value. Requests cannot exceed Limits.
                                            More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
                                            EOT
                                            "type" = "object"
                                          }
                                        }
                                        "type" = "object"
                                      }
                                      "selector" = {
                                        "description" = "selector is a label query over volumes to consider for binding."
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
                                      "storageClassName" = {
                                        "description" = <<-EOT
                                        storageClassName is the name of the StorageClass required by the claim.
                                        More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
                                        EOT
                                        "type" = "string"
                                      }
                                      "volumeAttributesClassName" = {
                                        "description" = <<-EOT
                                        volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.
                                        If specified, the CSI driver will create or update the volume with the attributes defined
                                        in the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,
                                        it can be changed after the claim is created. An empty string or nil value indicates that no
                                        VolumeAttributesClass will be applied to the claim. If the claim enters an Infeasible error state,
                                        this field can be reset to its previous value (including nil) to cancel the modification.
                                        If the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be
                                        set to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource
                                        exists.
                                        More info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/
                                        EOT
                                        "type" = "string"
                                      }
                                      "volumeMode" = {
                                        "description" = <<-EOT
                                        volumeMode defines what type of volume is required by the claim.
                                        Value of Filesystem is implied when not included in claim spec.
                                        EOT
                                        "type" = "string"
                                      }
                                      "volumeName" = {
                                        "description" = "volumeName is the binding reference to the PersistentVolume backing this claim."
                                        "type" = "string"
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
                            "type" = "object"
                          }
                          "fc" = {
                            "description" = "fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod."
                            "properties" = {
                              "fsType" = {
                                "description" = <<-EOT
                                fsType is the filesystem type to mount.
                                Must be a filesystem type supported by the host operating system.
                                Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                                EOT
                                "type" = "string"
                              }
                              "lun" = {
                                "description" = "lun is Optional: FC target lun number"
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly is Optional: Defaults to false (read/write). ReadOnly here will force
                                the ReadOnly setting in VolumeMounts.
                                EOT
                                "type" = "boolean"
                              }
                              "targetWWNs" = {
                                "description" = "targetWWNs is Optional: FC target worldwide names (WWNs)"
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                                "x-kubernetes-list-type" = "atomic"
                              }
                              "wwids" = {
                                "description" = <<-EOT
                                wwids Optional: FC volume world wide identifiers (wwids)
                                Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously.
                                EOT
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                                "x-kubernetes-list-type" = "atomic"
                              }
                            }
                            "type" = "object"
                          }
                          "flexVolume" = {
                            "description" = <<-EOT
                            flexVolume represents a generic volume resource that is
                            provisioned/attached using an exec based plugin.
                            Deprecated: FlexVolume is deprecated. Consider using a CSIDriver instead.
                            EOT
                            "properties" = {
                              "driver" = {
                                "description" = "driver is the name of the driver to use for this volume."
                                "type" = "string"
                              }
                              "fsType" = {
                                "description" = <<-EOT
                                fsType is the filesystem type to mount.
                                Must be a filesystem type supported by the host operating system.
                                Ex. "ext4", "xfs", "ntfs". The default filesystem depends on FlexVolume script.
                                EOT
                                "type" = "string"
                              }
                              "options" = {
                                "additionalProperties" = {
                                  "type" = "string"
                                }
                                "description" = "options is Optional: this field holds extra command options if any."
                                "type" = "object"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly is Optional: defaults to false (read/write). ReadOnly here will force
                                the ReadOnly setting in VolumeMounts.
                                EOT
                                "type" = "boolean"
                              }
                              "secretRef" = {
                                "description" = <<-EOT
                                secretRef is Optional: secretRef is reference to the secret object containing
                                sensitive information to pass to the plugin scripts. This may be
                                empty if no secret object is specified. If the secret object
                                contains more than one secret, all secrets are passed to the plugin
                                scripts.
                                EOT
                                "properties" = {
                                  "name" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Name of the referent.
                                    This field is effectively required, but due to backwards compatibility is
                                    allowed to be empty. Instances of this type with an empty value here are
                                    almost certainly wrong.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                                "x-kubernetes-map-type" = "atomic"
                              }
                            }
                            "required" = [
                              "driver",
                            ]
                            "type" = "object"
                          }
                          "flocker" = {
                            "description" = <<-EOT
                            flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running.
                            Deprecated: Flocker is deprecated and the in-tree flocker type is no longer supported.
                            EOT
                            "properties" = {
                              "datasetName" = {
                                "description" = <<-EOT
                                datasetName is Name of the dataset stored as metadata -> name on the dataset for Flocker
                                should be considered as deprecated
                                EOT
                                "type" = "string"
                              }
                              "datasetUUID" = {
                                "description" = "datasetUUID is the UUID of the dataset. This is unique identifier of a Flocker dataset"
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "gcePersistentDisk" = {
                            "description" = <<-EOT
                            gcePersistentDisk represents a GCE Disk resource that is attached to a
                            kubelet's host machine and then exposed to the pod.
                            Deprecated: GCEPersistentDisk is deprecated. All operations for the in-tree
                            gcePersistentDisk type are redirected to the pd.csi.storage.gke.io CSI driver.
                            More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
                            EOT
                            "properties" = {
                              "fsType" = {
                                "description" = <<-EOT
                                fsType is filesystem type of the volume that you want to mount.
                                Tip: Ensure that the filesystem type is supported by the host operating system.
                                Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
                                EOT
                                "type" = "string"
                              }
                              "partition" = {
                                "description" = <<-EOT
                                partition is the partition in the volume that you want to mount.
                                If omitted, the default is to mount by volume name.
                                Examples: For volume /dev/sda1, you specify the partition as "1".
                                Similarly, the volume partition for /dev/sda is "0" (or you can leave the property empty).
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "pdName" = {
                                "description" = <<-EOT
                                pdName is unique name of the PD resource in GCE. Used to identify the disk in GCE.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
                                EOT
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly here will force the ReadOnly setting in VolumeMounts.
                                Defaults to false.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
                                EOT
                                "type" = "boolean"
                              }
                            }
                            "required" = [
                              "pdName",
                            ]
                            "type" = "object"
                          }
                          "gitRepo" = {
                            "description" = <<-EOT
                            gitRepo represents a git repository at a particular revision.
                            Deprecated: GitRepo is deprecated. To provision a container with a git repo, mount an
                            EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir
                            into the Pod's container.
                            EOT
                            "properties" = {
                              "directory" = {
                                "description" = <<-EOT
                                directory is the target directory name.
                                Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the
                                git repository.  Otherwise, if specified, the volume will contain the git repository in
                                the subdirectory with the given name.
                                EOT
                                "type" = "string"
                              }
                              "repository" = {
                                "description" = "repository is the URL"
                                "type" = "string"
                              }
                              "revision" = {
                                "description" = "revision is the commit hash for the specified revision."
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "repository",
                            ]
                            "type" = "object"
                          }
                          "glusterfs" = {
                            "description" = <<-EOT
                            glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime.
                            Deprecated: Glusterfs is deprecated and the in-tree glusterfs type is no longer supported.
                            EOT
                            "properties" = {
                              "endpoints" = {
                                "description" = "endpoints is the endpoint name that details Glusterfs topology."
                                "type" = "string"
                              }
                              "path" = {
                                "description" = <<-EOT
                                path is the Glusterfs volume path.
                                More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                                EOT
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly here will force the Glusterfs volume to be mounted with read-only permissions.
                                Defaults to false.
                                More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
                                EOT
                                "type" = "boolean"
                              }
                            }
                            "required" = [
                              "endpoints",
                              "path",
                            ]
                            "type" = "object"
                          }
                          "hostPath" = {
                            "description" = <<-EOT
                            hostPath represents a pre-existing file or directory on the host
                            machine that is directly exposed to the container. This is generally
                            used for system agents or other privileged things that are allowed
                            to see the host machine. Most containers will NOT need this.
                            More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
                            EOT
                            "properties" = {
                              "path" = {
                                "description" = <<-EOT
                                path of the directory on the host.
                                If the path is a symlink, it will follow the link to the real path.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
                                EOT
                                "type" = "string"
                              }
                              "type" = {
                                "description" = <<-EOT
                                type for HostPath Volume
                                Defaults to ""
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
                                EOT
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "path",
                            ]
                            "type" = "object"
                          }
                          "image" = {
                            "description" = <<-EOT
                            image represents an OCI object (a container image or artifact) pulled and mounted on the kubelet's host machine.
                            The volume is resolved at pod startup depending on which PullPolicy value is provided:
                            
                            - Always: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails.
                            - Never: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present.
                            - IfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.
                            
                            The volume gets re-resolved if the pod gets deleted and recreated, which means that new remote content will become available on pod recreation.
                            A failure to resolve or pull the image during pod startup will block containers from starting and may add significant latency. Failures will be retried using normal volume backoff and will be reported on the pod reason and message.
                            The types of objects that may be mounted by this volume are defined by the container runtime implementation on a host machine and at minimum must include all valid types supported by the container image field.
                            The OCI object gets mounted in a single directory (spec.containers[*].volumeMounts.mountPath) by merging the manifest layers in the same way as for container images.
                            The volume will be mounted read-only (ro).
                            Sub path mounts for containers are not supported (spec.containers[*].volumeMounts.subpath) before 1.33.
                            The field spec.securityContext.fsGroupChangePolicy has no effect on this volume type.
                            EOT
                            "properties" = {
                              "pullPolicy" = {
                                "description" = <<-EOT
                                Policy for pulling OCI objects. Possible values are:
                                Always: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails.
                                Never: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present.
                                IfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.
                                Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
                                EOT
                                "type" = "string"
                              }
                              "reference" = {
                                "description" = <<-EOT
                                Required: Image or artifact reference to be used.
                                Behaves in the same way as pod.spec.containers[*].image.
                                Pull secrets will be assembled in the same way as for the container image by looking up node credentials, SA image pull secrets, and pod spec image pull secrets.
                                More info: https://kubernetes.io/docs/concepts/containers/images
                                This field is optional to allow higher level config management to default or override
                                container images in workload controllers like Deployments and StatefulSets.
                                EOT
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "iscsi" = {
                            "description" = <<-EOT
                            iscsi represents an ISCSI Disk resource that is attached to a
                            kubelet's host machine and then exposed to the pod.
                            More info: https://kubernetes.io/docs/concepts/storage/volumes/#iscsi
                            EOT
                            "properties" = {
                              "chapAuthDiscovery" = {
                                "description" = "chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication"
                                "type" = "boolean"
                              }
                              "chapAuthSession" = {
                                "description" = "chapAuthSession defines whether support iSCSI Session CHAP authentication"
                                "type" = "boolean"
                              }
                              "fsType" = {
                                "description" = <<-EOT
                                fsType is the filesystem type of the volume that you want to mount.
                                Tip: Ensure that the filesystem type is supported by the host operating system.
                                Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi
                                EOT
                                "type" = "string"
                              }
                              "initiatorName" = {
                                "description" = <<-EOT
                                initiatorName is the custom iSCSI Initiator Name.
                                If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface
                                <target portal>:<volume name> will be created for the connection.
                                EOT
                                "type" = "string"
                              }
                              "iqn" = {
                                "description" = "iqn is the target iSCSI Qualified Name."
                                "type" = "string"
                              }
                              "iscsiInterface" = {
                                "default" = "default"
                                "description" = <<-EOT
                                iscsiInterface is the interface Name that uses an iSCSI transport.
                                Defaults to 'default' (tcp).
                                EOT
                                "type" = "string"
                              }
                              "lun" = {
                                "description" = "lun represents iSCSI Target Lun number."
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "portals" = {
                                "description" = <<-EOT
                                portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port
                                is other than default (typically TCP ports 860 and 3260).
                                EOT
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                                "x-kubernetes-list-type" = "atomic"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly here will force the ReadOnly setting in VolumeMounts.
                                Defaults to false.
                                EOT
                                "type" = "boolean"
                              }
                              "secretRef" = {
                                "description" = "secretRef is the CHAP Secret for iSCSI target and initiator authentication"
                                "properties" = {
                                  "name" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Name of the referent.
                                    This field is effectively required, but due to backwards compatibility is
                                    allowed to be empty. Instances of this type with an empty value here are
                                    almost certainly wrong.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                                "x-kubernetes-map-type" = "atomic"
                              }
                              "targetPortal" = {
                                "description" = <<-EOT
                                targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port
                                is other than default (typically TCP ports 860 and 3260).
                                EOT
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "iqn",
                              "lun",
                              "targetPortal",
                            ]
                            "type" = "object"
                          }
                          "name" = {
                            "description" = <<-EOT
                            name of the volume.
                            Must be a DNS_LABEL and unique within the pod.
                            More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                            EOT
                            "type" = "string"
                          }
                          "nfs" = {
                            "description" = <<-EOT
                            nfs represents an NFS mount on the host that shares a pod's lifetime
                            More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
                            EOT
                            "properties" = {
                              "path" = {
                                "description" = <<-EOT
                                path that is exported by the NFS server.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
                                EOT
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly here will force the NFS export to be mounted with read-only permissions.
                                Defaults to false.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
                                EOT
                                "type" = "boolean"
                              }
                              "server" = {
                                "description" = <<-EOT
                                server is the hostname or IP address of the NFS server.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
                                EOT
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "path",
                              "server",
                            ]
                            "type" = "object"
                          }
                          "persistentVolumeClaim" = {
                            "description" = <<-EOT
                            persistentVolumeClaimVolumeSource represents a reference to a
                            PersistentVolumeClaim in the same namespace.
                            More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
                            EOT
                            "properties" = {
                              "claimName" = {
                                "description" = <<-EOT
                                claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume.
                                More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
                                EOT
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly Will force the ReadOnly setting in VolumeMounts.
                                Default false.
                                EOT
                                "type" = "boolean"
                              }
                            }
                            "required" = [
                              "claimName",
                            ]
                            "type" = "object"
                          }
                          "photonPersistentDisk" = {
                            "description" = <<-EOT
                            photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine.
                            Deprecated: PhotonPersistentDisk is deprecated and the in-tree photonPersistentDisk type is no longer supported.
                            EOT
                            "properties" = {
                              "fsType" = {
                                "description" = <<-EOT
                                fsType is the filesystem type to mount.
                                Must be a filesystem type supported by the host operating system.
                                Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                                EOT
                                "type" = "string"
                              }
                              "pdID" = {
                                "description" = "pdID is the ID that identifies Photon Controller persistent disk"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "pdID",
                            ]
                            "type" = "object"
                          }
                          "portworxVolume" = {
                            "description" = <<-EOT
                            portworxVolume represents a portworx volume attached and mounted on kubelets host machine.
                            Deprecated: PortworxVolume is deprecated. All operations for the in-tree portworxVolume type
                            are redirected to the pxd.portworx.com CSI driver.
                            EOT
                            "properties" = {
                              "fsType" = {
                                "description" = <<-EOT
                                fSType represents the filesystem type to mount
                                Must be a filesystem type supported by the host operating system.
                                Ex. "ext4", "xfs". Implicitly inferred to be "ext4" if unspecified.
                                EOT
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly defaults to false (read/write). ReadOnly here will force
                                the ReadOnly setting in VolumeMounts.
                                EOT
                                "type" = "boolean"
                              }
                              "volumeID" = {
                                "description" = "volumeID uniquely identifies a Portworx volume"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "volumeID",
                            ]
                            "type" = "object"
                          }
                          "projected" = {
                            "description" = "projected items for all in one resources secrets, configmaps, and downward API"
                            "properties" = {
                              "defaultMode" = {
                                "description" = <<-EOT
                                defaultMode are the mode bits used to set permissions on created files by default.
                                Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
                                YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
                                Directories within the path are not affected by this setting.
                                This might be in conflict with other options that affect the file
                                mode, like fsGroup, and the result can be other mode bits set.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "defaultUser" = {
                                "description" = <<-EOT
                                defaultUser is Optional: The owner UID of the created files by default.
                                The defaultUser field is only used as a fallback when the item-level user field is unset.
                                (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "sources" = {
                                "description" = <<-EOT
                                sources is the list of volume projections. Each entry in this list
                                handles one source.
                                EOT
                                "items" = {
                                  "description" = <<-EOT
                                  Projection that may be projected along with other supported volume types.
                                  Exactly one of these fields must be set.
                                  EOT
                                  "properties" = {
                                    "clusterTrustBundle" = {
                                      "description" = <<-EOT
                                      ClusterTrustBundle allows a pod to access the `.spec.trustBundle` field
                                      of ClusterTrustBundle objects in an auto-updating file.
                                      
                                      Alpha, gated by the ClusterTrustBundleProjection feature gate.
                                      
                                      ClusterTrustBundle objects can either be selected by name, or by the
                                      combination of signer name and a label selector.
                                      
                                      Kubelet performs aggressive normalization of the PEM contents written
                                      into the pod filesystem.  Esoteric PEM features such as inter-block
                                      comments and block headers are stripped.  Certificates are deduplicated.
                                      The ordering of certificates within the file is arbitrary, and Kubelet
                                      may change the order over time.
                                      EOT
                                      "properties" = {
                                        "labelSelector" = {
                                          "description" = <<-EOT
                                          Select all ClusterTrustBundles that match this label selector.  Only has
                                          effect if signerName is set.  Mutually-exclusive with name.  If unset,
                                          interpreted as "match nothing".  If set but empty, interpreted as "match
                                          everything".
                                          EOT
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
                                        "name" = {
                                          "description" = <<-EOT
                                          Select a single ClusterTrustBundle by object name.  Mutually-exclusive
                                          with signerName and labelSelector.
                                          EOT
                                          "type" = "string"
                                        }
                                        "optional" = {
                                          "description" = <<-EOT
                                          If true, don't block pod startup if the referenced ClusterTrustBundle(s)
                                          aren't available.  If using name, then the named ClusterTrustBundle is
                                          allowed not to exist.  If using signerName, then the combination of
                                          signerName and labelSelector is allowed to match zero
                                          ClusterTrustBundles.
                                          EOT
                                          "type" = "boolean"
                                        }
                                        "path" = {
                                          "description" = "Relative path from the volume root to write the bundle."
                                          "type" = "string"
                                        }
                                        "signerName" = {
                                          "description" = <<-EOT
                                          Select all ClusterTrustBundles that match this signer name.
                                          Mutually-exclusive with name.  The contents of all selected
                                          ClusterTrustBundles will be unified and deduplicated.
                                          EOT
                                          "type" = "string"
                                        }
                                        "user" = {
                                          "description" = <<-EOT
                                          user is Optional: The owner UID of the created file.
                                          If specified, the item-level user field takes precedence over defaultUser.
                                          (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                          EOT
                                          "format" = "int64"
                                          "type" = "integer"
                                        }
                                      }
                                      "required" = [
                                        "path",
                                      ]
                                      "type" = "object"
                                    }
                                    "configMap" = {
                                      "description" = "configMap information about the configMap data to project"
                                      "properties" = {
                                        "items" = {
                                          "description" = <<-EOT
                                          items if unspecified, each key-value pair in the Data field of the referenced
                                          ConfigMap will be projected into the volume as a file whose name is the
                                          key and content is the value. If specified, the listed keys will be
                                          projected into the specified paths, and unlisted keys will not be
                                          present. If a key is specified which is not present in the ConfigMap,
                                          the volume setup will error unless it is marked optional. Paths must be
                                          relative and may not contain the '..' path or start with '..'.
                                          EOT
                                          "items" = {
                                            "description" = "Maps a string key to a path within a volume."
                                            "properties" = {
                                              "key" = {
                                                "description" = "key is the key to project."
                                                "type" = "string"
                                              }
                                              "mode" = {
                                                "description" = <<-EOT
                                                mode is Optional: mode bits used to set permissions on this file.
                                                Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
                                                YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
                                                If not specified, the volume defaultMode will be used.
                                                This might be in conflict with other options that affect the file
                                                mode, like fsGroup, and the result can be other mode bits set.
                                                EOT
                                                "format" = "int32"
                                                "type" = "integer"
                                              }
                                              "path" = {
                                                "description" = <<-EOT
                                                path is the relative path of the file to map the key to.
                                                May not be an absolute path.
                                                May not contain the path element '..'.
                                                May not start with the string '..'.
                                                EOT
                                                "type" = "string"
                                              }
                                              "user" = {
                                                "description" = <<-EOT
                                                user is Optional: The owner UID of the created file.
                                                If specified, the item-level user field takes precedence over defaultUser.
                                                (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                                EOT
                                                "format" = "int64"
                                                "type" = "integer"
                                              }
                                            }
                                            "required" = [
                                              "key",
                                              "path",
                                            ]
                                            "type" = "object"
                                          }
                                          "type" = "array"
                                          "x-kubernetes-list-type" = "atomic"
                                        }
                                        "name" = {
                                          "default" = ""
                                          "description" = <<-EOT
                                          Name of the referent.
                                          This field is effectively required, but due to backwards compatibility is
                                          allowed to be empty. Instances of this type with an empty value here are
                                          almost certainly wrong.
                                          More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                          EOT
                                          "type" = "string"
                                        }
                                        "optional" = {
                                          "description" = "optional specify whether the ConfigMap or its keys must be defined"
                                          "type" = "boolean"
                                        }
                                      }
                                      "type" = "object"
                                      "x-kubernetes-map-type" = "atomic"
                                    }
                                    "downwardAPI" = {
                                      "description" = "downwardAPI information about the downwardAPI data to project"
                                      "properties" = {
                                        "items" = {
                                          "description" = "Items is a list of DownwardAPIVolume file"
                                          "items" = {
                                            "description" = "DownwardAPIVolumeFile represents information to create the file containing the pod field"
                                            "properties" = {
                                              "fieldRef" = {
                                                "description" = "Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported."
                                                "properties" = {
                                                  "apiVersion" = {
                                                    "description" = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
                                                    "type" = "string"
                                                  }
                                                  "fieldPath" = {
                                                    "description" = "Path of the field to select in the specified API version."
                                                    "type" = "string"
                                                  }
                                                }
                                                "required" = [
                                                  "fieldPath",
                                                ]
                                                "type" = "object"
                                                "x-kubernetes-map-type" = "atomic"
                                              }
                                              "mode" = {
                                                "description" = <<-EOT
                                                Optional: mode bits used to set permissions on this file, must be an octal value
                                                between 0000 and 0777 or a decimal value between 0 and 511.
                                                YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
                                                If not specified, the volume defaultMode will be used.
                                                This might be in conflict with other options that affect the file
                                                mode, like fsGroup, and the result can be other mode bits set.
                                                EOT
                                                "format" = "int32"
                                                "type" = "integer"
                                              }
                                              "path" = {
                                                "description" = "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
                                                "type" = "string"
                                              }
                                              "resourceFieldRef" = {
                                                "description" = <<-EOT
                                                Selects a resource of the container: only resources limits and requests
                                                (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.
                                                EOT
                                                "properties" = {
                                                  "containerName" = {
                                                    "description" = "Container name: required for volumes, optional for env vars"
                                                    "type" = "string"
                                                  }
                                                  "divisor" = {
                                                    "anyOf" = [
                                                      {
                                                        "type" = "integer"
                                                      },
                                                      {
                                                        "type" = "string"
                                                      },
                                                    ]
                                                    "description" = "Specifies the output format of the exposed resources, defaults to \"1\""
                                                    "pattern" = "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
                                                    "x-kubernetes-int-or-string" = true
                                                  }
                                                  "resource" = {
                                                    "description" = "Required: resource to select"
                                                    "type" = "string"
                                                  }
                                                }
                                                "required" = [
                                                  "resource",
                                                ]
                                                "type" = "object"
                                                "x-kubernetes-map-type" = "atomic"
                                              }
                                              "user" = {
                                                "description" = <<-EOT
                                                user is Optional: The owner UID of the created file.
                                                If specified, the item-level user field takes precedence over defaultUser.
                                                (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                                EOT
                                                "format" = "int64"
                                                "type" = "integer"
                                              }
                                            }
                                            "required" = [
                                              "path",
                                            ]
                                            "type" = "object"
                                          }
                                          "type" = "array"
                                          "x-kubernetes-list-type" = "atomic"
                                        }
                                      }
                                      "type" = "object"
                                    }
                                    "podCertificate" = {
                                      "description" = <<-EOT
                                      Projects an auto-rotating credential bundle (private key and certificate
                                      chain) that the pod can use either as a TLS client or server.
                                      
                                      Kubelet generates a private key and uses it to send a
                                      PodCertificateRequest to the named signer.  Once the signer approves the
                                      request and issues a certificate chain, Kubelet writes the key and
                                      certificate chain to the pod filesystem.  The pod does not start until
                                      certificates have been issued for each podCertificate projected volume
                                      source in its spec.
                                      
                                      Kubelet will begin trying to rotate the certificate at the time indicated
                                      by the signer using the PodCertificateRequest.Status.BeginRefreshAt
                                      timestamp.
                                      
                                      Kubelet can write a single file, indicated by the credentialBundlePath
                                      field, or separate files, indicated by the keyPath and
                                      certificateChainPath fields.
                                      
                                      The credential bundle is a single file in PEM format.  The first PEM
                                      entry is the private key (in PKCS#8 format), and the remaining PEM
                                      entries are the certificate chain issued by the signer (typically,
                                      signers will return their certificate chain in leaf-to-root order).
                                      
                                      Prefer using the credential bundle format, since your application code
                                      can read it atomically.  If you use keyPath and certificateChainPath,
                                      your application must make two separate file reads. If these coincide
                                      with a certificate rotation, it is possible that the private key and leaf
                                      certificate you read may not correspond to each other.  Your application
                                      will need to check for this condition, and re-read until they are
                                      consistent.
                                      
                                      The named signer controls chooses the format of the certificate it
                                      issues; consult the signer implementation's documentation to learn how to
                                      use the certificates it issues.
                                      EOT
                                      "properties" = {
                                        "certificateChainPath" = {
                                          "description" = <<-EOT
                                          Write the certificate chain at this path in the projected volume.
                                          
                                          Most applications should use credentialBundlePath.  When using keyPath
                                          and certificateChainPath, your application needs to check that the key
                                          and leaf certificate are consistent, because it is possible to read the
                                          files mid-rotation.
                                          EOT
                                          "type" = "string"
                                        }
                                        "credentialBundlePath" = {
                                          "description" = <<-EOT
                                          Write the credential bundle at this path in the projected volume.
                                          
                                          The credential bundle is a single file that contains multiple PEM blocks.
                                          The first PEM block is a PRIVATE KEY block, containing a PKCS#8 private
                                          key.
                                          
                                          The remaining blocks are CERTIFICATE blocks, containing the issued
                                          certificate chain from the signer (leaf and any intermediates).
                                          
                                          Using credentialBundlePath lets your Pod's application code make a single
                                          atomic read that retrieves a consistent key and certificate chain.  If you
                                          project them to separate files, your application code will need to
                                          additionally check that the leaf certificate was issued to the key.
                                          EOT
                                          "type" = "string"
                                        }
                                        "keyPath" = {
                                          "description" = <<-EOT
                                          Write the key at this path in the projected volume.
                                          
                                          Most applications should use credentialBundlePath.  When using keyPath
                                          and certificateChainPath, your application needs to check that the key
                                          and leaf certificate are consistent, because it is possible to read the
                                          files mid-rotation.
                                          EOT
                                          "type" = "string"
                                        }
                                        "keyType" = {
                                          "description" = <<-EOT
                                          The type of keypair Kubelet will generate for the pod.
                                          
                                          Valid values are "RSA3072", "RSA4096", "ECDSAP256", "ECDSAP384",
                                          "ECDSAP521", and "ED25519".
                                          EOT
                                          "type" = "string"
                                        }
                                        "maxExpirationSeconds" = {
                                          "description" = <<-EOT
                                          maxExpirationSeconds is the maximum lifetime permitted for the
                                          certificate.
                                          
                                          Kubelet copies this value verbatim into the PodCertificateRequests it
                                          generates for this projection.
                                          
                                          If omitted, kube-apiserver will set it to 86400(24 hours). kube-apiserver
                                          will reject values shorter than 3600 (1 hour).  The maximum allowable
                                          value is 7862400 (91 days).
                                          
                                          The signer implementation is then free to issue a certificate with any
                                          lifetime *shorter* than MaxExpirationSeconds, but no shorter than 3600
                                          seconds (1 hour).  This constraint is enforced by kube-apiserver.
                                          `kubernetes.io` signers will never issue certificates with a lifetime
                                          longer than 24 hours.
                                          EOT
                                          "format" = "int32"
                                          "type" = "integer"
                                        }
                                        "signerName" = {
                                          "description" = "Kubelet's generated CSRs will be addressed to this signer."
                                          "type" = "string"
                                        }
                                        "user" = {
                                          "description" = <<-EOT
                                          user is Optional: The owner UID of the created file.
                                          If specified, the item-level user field takes precedence over defaultUser.
                                          (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                          EOT
                                          "format" = "int64"
                                          "type" = "integer"
                                        }
                                        "userAnnotations" = {
                                          "additionalProperties" = {
                                            "type" = "string"
                                          }
                                          "description" = <<-EOT
                                          userAnnotations allow pod authors to pass additional information to
                                          the signer implementation.  Kubernetes does not restrict or validate this
                                          metadata in any way.
                                          
                                          These values are copied verbatim into the `spec.unverifiedUserAnnotations` field of
                                          the PodCertificateRequest objects that Kubelet creates.
                                          
                                          Entries are subject to the same validation as object metadata annotations,
                                          with the addition that all keys must be domain-prefixed. No restrictions
                                          are placed on values, except an overall size limitation on the entire field.
                                          
                                          Signers should document the keys and values they support. Signers should
                                          deny requests that contain keys they do not recognize.
                                          EOT
                                          "type" = "object"
                                        }
                                      }
                                      "required" = [
                                        "keyType",
                                        "signerName",
                                      ]
                                      "type" = "object"
                                    }
                                    "secret" = {
                                      "description" = "secret information about the secret data to project"
                                      "properties" = {
                                        "items" = {
                                          "description" = <<-EOT
                                          items if unspecified, each key-value pair in the Data field of the referenced
                                          Secret will be projected into the volume as a file whose name is the
                                          key and content is the value. If specified, the listed keys will be
                                          projected into the specified paths, and unlisted keys will not be
                                          present. If a key is specified which is not present in the Secret,
                                          the volume setup will error unless it is marked optional. Paths must be
                                          relative and may not contain the '..' path or start with '..'.
                                          EOT
                                          "items" = {
                                            "description" = "Maps a string key to a path within a volume."
                                            "properties" = {
                                              "key" = {
                                                "description" = "key is the key to project."
                                                "type" = "string"
                                              }
                                              "mode" = {
                                                "description" = <<-EOT
                                                mode is Optional: mode bits used to set permissions on this file.
                                                Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
                                                YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
                                                If not specified, the volume defaultMode will be used.
                                                This might be in conflict with other options that affect the file
                                                mode, like fsGroup, and the result can be other mode bits set.
                                                EOT
                                                "format" = "int32"
                                                "type" = "integer"
                                              }
                                              "path" = {
                                                "description" = <<-EOT
                                                path is the relative path of the file to map the key to.
                                                May not be an absolute path.
                                                May not contain the path element '..'.
                                                May not start with the string '..'.
                                                EOT
                                                "type" = "string"
                                              }
                                              "user" = {
                                                "description" = <<-EOT
                                                user is Optional: The owner UID of the created file.
                                                If specified, the item-level user field takes precedence over defaultUser.
                                                (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                                EOT
                                                "format" = "int64"
                                                "type" = "integer"
                                              }
                                            }
                                            "required" = [
                                              "key",
                                              "path",
                                            ]
                                            "type" = "object"
                                          }
                                          "type" = "array"
                                          "x-kubernetes-list-type" = "atomic"
                                        }
                                        "name" = {
                                          "default" = ""
                                          "description" = <<-EOT
                                          Name of the referent.
                                          This field is effectively required, but due to backwards compatibility is
                                          allowed to be empty. Instances of this type with an empty value here are
                                          almost certainly wrong.
                                          More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                          EOT
                                          "type" = "string"
                                        }
                                        "optional" = {
                                          "description" = "optional field specify whether the Secret or its key must be defined"
                                          "type" = "boolean"
                                        }
                                      }
                                      "type" = "object"
                                      "x-kubernetes-map-type" = "atomic"
                                    }
                                    "serviceAccountToken" = {
                                      "description" = "serviceAccountToken is information about the serviceAccountToken data to project"
                                      "properties" = {
                                        "audience" = {
                                          "description" = <<-EOT
                                          audience is the intended audience of the token. A recipient of a token
                                          must identify itself with an identifier specified in the audience of the
                                          token, and otherwise should reject the token. The audience defaults to the
                                          identifier of the apiserver.
                                          EOT
                                          "type" = "string"
                                        }
                                        "expirationSeconds" = {
                                          "description" = <<-EOT
                                          expirationSeconds is the requested duration of validity of the service
                                          account token. As the token approaches expiration, the kubelet volume
                                          plugin will proactively rotate the service account token. The kubelet will
                                          start trying to rotate the token if the token is older than 80 percent of
                                          its time to live or if the token is older than 24 hours.Defaults to 1 hour
                                          and must be at least 10 minutes.
                                          EOT
                                          "format" = "int64"
                                          "type" = "integer"
                                        }
                                        "path" = {
                                          "description" = <<-EOT
                                          path is the path relative to the mount point of the file to project the
                                          token into.
                                          EOT
                                          "type" = "string"
                                        }
                                        "user" = {
                                          "description" = <<-EOT
                                          user is Optional: The owner UID of the created file.
                                          If specified, the item-level user field takes precedence over defaultUser.
                                          (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                          EOT
                                          "format" = "int64"
                                          "type" = "integer"
                                        }
                                      }
                                      "required" = [
                                        "path",
                                      ]
                                      "type" = "object"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "type" = "array"
                                "x-kubernetes-list-type" = "atomic"
                              }
                            }
                            "type" = "object"
                          }
                          "quobyte" = {
                            "description" = <<-EOT
                            quobyte represents a Quobyte mount on the host that shares a pod's lifetime.
                            Deprecated: Quobyte is deprecated and the in-tree quobyte type is no longer supported.
                            EOT
                            "properties" = {
                              "group" = {
                                "description" = <<-EOT
                                group to map volume access to
                                Default is no group
                                EOT
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly here will force the Quobyte volume to be mounted with read-only permissions.
                                Defaults to false.
                                EOT
                                "type" = "boolean"
                              }
                              "registry" = {
                                "description" = <<-EOT
                                registry represents a single or multiple Quobyte Registry services
                                specified as a string as host:port pair (multiple entries are separated with commas)
                                which acts as the central registry for volumes
                                EOT
                                "type" = "string"
                              }
                              "tenant" = {
                                "description" = <<-EOT
                                tenant owning the given Quobyte volume in the Backend
                                Used with dynamically provisioned Quobyte volumes, value is set by the plugin
                                EOT
                                "type" = "string"
                              }
                              "user" = {
                                "description" = <<-EOT
                                user to map volume access to
                                Defaults to serivceaccount user
                                EOT
                                "type" = "string"
                              }
                              "volume" = {
                                "description" = "volume is a string that references an already created Quobyte volume by name."
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "registry",
                              "volume",
                            ]
                            "type" = "object"
                          }
                          "rbd" = {
                            "description" = <<-EOT
                            rbd represents a Rados Block Device mount on the host that shares a pod's lifetime.
                            Deprecated: RBD is deprecated and the in-tree rbd type is no longer supported.
                            EOT
                            "properties" = {
                              "fsType" = {
                                "description" = <<-EOT
                                fsType is the filesystem type of the volume that you want to mount.
                                Tip: Ensure that the filesystem type is supported by the host operating system.
                                Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd
                                EOT
                                "type" = "string"
                              }
                              "image" = {
                                "description" = <<-EOT
                                image is the rados image name.
                                More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                                EOT
                                "type" = "string"
                              }
                              "keyring" = {
                                "default" = "/etc/ceph/keyring"
                                "description" = <<-EOT
                                keyring is the path to key ring for RBDUser.
                                Default is /etc/ceph/keyring.
                                More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                                EOT
                                "type" = "string"
                              }
                              "monitors" = {
                                "description" = <<-EOT
                                monitors is a collection of Ceph monitors.
                                More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                                EOT
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                                "x-kubernetes-list-type" = "atomic"
                              }
                              "pool" = {
                                "default" = "rbd"
                                "description" = <<-EOT
                                pool is the rados pool name.
                                Default is rbd.
                                More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                                EOT
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly here will force the ReadOnly setting in VolumeMounts.
                                Defaults to false.
                                More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                                EOT
                                "type" = "boolean"
                              }
                              "secretRef" = {
                                "description" = <<-EOT
                                secretRef is name of the authentication secret for RBDUser. If provided
                                overrides keyring.
                                Default is nil.
                                More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                                EOT
                                "properties" = {
                                  "name" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Name of the referent.
                                    This field is effectively required, but due to backwards compatibility is
                                    allowed to be empty. Instances of this type with an empty value here are
                                    almost certainly wrong.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                                "x-kubernetes-map-type" = "atomic"
                              }
                              "user" = {
                                "default" = "admin"
                                "description" = <<-EOT
                                user is the rados user name.
                                Default is admin.
                                More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
                                EOT
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "image",
                              "monitors",
                            ]
                            "type" = "object"
                          }
                          "scaleIO" = {
                            "description" = <<-EOT
                            scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.
                            Deprecated: ScaleIO is deprecated and the in-tree scaleIO type is no longer supported.
                            EOT
                            "properties" = {
                              "fsType" = {
                                "default" = "xfs"
                                "description" = <<-EOT
                                fsType is the filesystem type to mount.
                                Must be a filesystem type supported by the host operating system.
                                Ex. "ext4", "xfs", "ntfs".
                                Default is "xfs".
                                EOT
                                "type" = "string"
                              }
                              "gateway" = {
                                "description" = "gateway is the host address of the ScaleIO API Gateway."
                                "type" = "string"
                              }
                              "protectionDomain" = {
                                "description" = "protectionDomain is the name of the ScaleIO Protection Domain for the configured storage."
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly Defaults to false (read/write). ReadOnly here will force
                                the ReadOnly setting in VolumeMounts.
                                EOT
                                "type" = "boolean"
                              }
                              "secretRef" = {
                                "description" = <<-EOT
                                secretRef references to the secret for ScaleIO user and other
                                sensitive information. If this is not provided, Login operation will fail.
                                EOT
                                "properties" = {
                                  "name" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Name of the referent.
                                    This field is effectively required, but due to backwards compatibility is
                                    allowed to be empty. Instances of this type with an empty value here are
                                    almost certainly wrong.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                                "x-kubernetes-map-type" = "atomic"
                              }
                              "sslEnabled" = {
                                "description" = "sslEnabled Flag enable/disable SSL communication with Gateway, default false"
                                "type" = "boolean"
                              }
                              "storageMode" = {
                                "default" = "ThinProvisioned"
                                "description" = <<-EOT
                                storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned.
                                Default is ThinProvisioned.
                                EOT
                                "type" = "string"
                              }
                              "storagePool" = {
                                "description" = "storagePool is the ScaleIO Storage Pool associated with the protection domain."
                                "type" = "string"
                              }
                              "system" = {
                                "description" = "system is the name of the storage system as configured in ScaleIO."
                                "type" = "string"
                              }
                              "volumeName" = {
                                "description" = <<-EOT
                                volumeName is the name of a volume already created in the ScaleIO system
                                that is associated with this volume source.
                                EOT
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "gateway",
                              "secretRef",
                              "system",
                            ]
                            "type" = "object"
                          }
                          "secret" = {
                            "description" = <<-EOT
                            secret represents a secret that should populate this volume.
                            More info: https://kubernetes.io/docs/concepts/storage/volumes#secret
                            EOT
                            "properties" = {
                              "defaultMode" = {
                                "description" = <<-EOT
                                defaultMode is Optional: mode bits used to set permissions on created files by default.
                                Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
                                YAML accepts both octal and decimal values, JSON requires decimal values
                                for mode bits. Defaults to 0644.
                                Directories within the path are not affected by this setting.
                                This might be in conflict with other options that affect the file
                                mode, like fsGroup, and the result can be other mode bits set.
                                EOT
                                "format" = "int32"
                                "type" = "integer"
                              }
                              "defaultUser" = {
                                "description" = <<-EOT
                                defaultUser is Optional: The owner UID of the created files by default.
                                The defaultUser field is only used as a fallback when the item-level user field is unset.
                                (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                EOT
                                "format" = "int64"
                                "type" = "integer"
                              }
                              "items" = {
                                "description" = <<-EOT
                                items If unspecified, each key-value pair in the Data field of the referenced
                                Secret will be projected into the volume as a file whose name is the
                                key and content is the value. If specified, the listed keys will be
                                projected into the specified paths, and unlisted keys will not be
                                present. If a key is specified which is not present in the Secret,
                                the volume setup will error unless it is marked optional. Paths must be
                                relative and may not contain the '..' path or start with '..'.
                                EOT
                                "items" = {
                                  "description" = "Maps a string key to a path within a volume."
                                  "properties" = {
                                    "key" = {
                                      "description" = "key is the key to project."
                                      "type" = "string"
                                    }
                                    "mode" = {
                                      "description" = <<-EOT
                                      mode is Optional: mode bits used to set permissions on this file.
                                      Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
                                      YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
                                      If not specified, the volume defaultMode will be used.
                                      This might be in conflict with other options that affect the file
                                      mode, like fsGroup, and the result can be other mode bits set.
                                      EOT
                                      "format" = "int32"
                                      "type" = "integer"
                                    }
                                    "path" = {
                                      "description" = <<-EOT
                                      path is the relative path of the file to map the key to.
                                      May not be an absolute path.
                                      May not contain the path element '..'.
                                      May not start with the string '..'.
                                      EOT
                                      "type" = "string"
                                    }
                                    "user" = {
                                      "description" = <<-EOT
                                      user is Optional: The owner UID of the created file.
                                      If specified, the item-level user field takes precedence over defaultUser.
                                      (Alpha) This field requires the AtomicWriteVolumeUserFields feature gate to be enabled.
                                      EOT
                                      "format" = "int64"
                                      "type" = "integer"
                                    }
                                  }
                                  "required" = [
                                    "key",
                                    "path",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                                "x-kubernetes-list-type" = "atomic"
                              }
                              "optional" = {
                                "description" = "optional field specify whether the Secret or its keys must be defined"
                                "type" = "boolean"
                              }
                              "secretName" = {
                                "description" = <<-EOT
                                secretName is the name of the secret in the pod's namespace to use.
                                More info: https://kubernetes.io/docs/concepts/storage/volumes#secret
                                EOT
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "storageos" = {
                            "description" = <<-EOT
                            storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes.
                            Deprecated: StorageOS is deprecated and the in-tree storageos type is no longer supported.
                            EOT
                            "properties" = {
                              "fsType" = {
                                "description" = <<-EOT
                                fsType is the filesystem type to mount.
                                Must be a filesystem type supported by the host operating system.
                                Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                                EOT
                                "type" = "string"
                              }
                              "readOnly" = {
                                "description" = <<-EOT
                                readOnly defaults to false (read/write). ReadOnly here will force
                                the ReadOnly setting in VolumeMounts.
                                EOT
                                "type" = "boolean"
                              }
                              "secretRef" = {
                                "description" = <<-EOT
                                secretRef specifies the secret to use for obtaining the StorageOS API
                                credentials.  If not specified, default values will be attempted.
                                EOT
                                "properties" = {
                                  "name" = {
                                    "default" = ""
                                    "description" = <<-EOT
                                    Name of the referent.
                                    This field is effectively required, but due to backwards compatibility is
                                    allowed to be empty. Instances of this type with an empty value here are
                                    almost certainly wrong.
                                    More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    EOT
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                                "x-kubernetes-map-type" = "atomic"
                              }
                              "volumeName" = {
                                "description" = <<-EOT
                                volumeName is the human-readable name of the StorageOS volume.  Volume
                                names are only unique within a namespace.
                                EOT
                                "type" = "string"
                              }
                              "volumeNamespace" = {
                                "description" = <<-EOT
                                volumeNamespace specifies the scope of the volume within StorageOS.  If no
                                namespace is specified then the Pod's namespace will be used.  This allows the
                                Kubernetes name scoping to be mirrored within StorageOS for tighter integration.
                                Set VolumeName to any name to override the default behaviour.
                                Set to "default" if you are not using namespaces within StorageOS.
                                Namespaces that do not pre-exist within StorageOS will be created.
                                EOT
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "vsphereVolume" = {
                            "description" = <<-EOT
                            vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine.
                            Deprecated: VsphereVolume is deprecated. All operations for the in-tree vsphereVolume type
                            are redirected to the csi.vsphere.vmware.com CSI driver.
                            EOT
                            "properties" = {
                              "fsType" = {
                                "description" = <<-EOT
                                fsType is filesystem type to mount.
                                Must be a filesystem type supported by the host operating system.
                                Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
                                EOT
                                "type" = "string"
                              }
                              "storagePolicyID" = {
                                "description" = "storagePolicyID is the storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName."
                                "type" = "string"
                              }
                              "storagePolicyName" = {
                                "description" = "storagePolicyName is the storage Policy Based Management (SPBM) profile name."
                                "type" = "string"
                              }
                              "volumePath" = {
                                "description" = "volumePath is the path that identifies vSphere volume vmdk"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "volumePath",
                            ]
                            "type" = "object"
                          }
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "walCompression" = {
                      "description" = <<-EOT
                      walCompression defines the compression of the write-ahead log (WAL) using Snappy.
                      
                      WAL compression is enabled by default for Prometheus >= 2.20.0
                      
                      Requires Prometheus v2.11.0 and above.
                      EOT
                      "type" = "boolean"
                    }
                    "web" = {
                      "description" = "web defines the configuration of the Prometheus web server."
                      "properties" = {
                        "httpConfig" = {
                          "description" = "httpConfig defines HTTP parameters for web server."
                          "properties" = {
                            "headers" = {
                              "description" = "headers defines a list of headers that can be added to HTTP responses."
                              "properties" = {
                                "contentSecurityPolicy" = {
                                  "description" = <<-EOT
                                  contentSecurityPolicy defines the Content-Security-Policy header to HTTP responses.
                                  Unset if blank.
                                  EOT
                                  "type" = "string"
                                }
                                "strictTransportSecurity" = {
                                  "description" = <<-EOT
                                  strictTransportSecurity defines the Strict-Transport-Security header to HTTP responses.
                                  Unset if blank.
                                  Please make sure that you use this with care as this header might force
                                  browsers to load Prometheus and the other applications hosted on the same
                                  domain and subdomains over HTTPS.
                                  https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security
                                  EOT
                                  "type" = "string"
                                }
                                "xContentTypeOptions" = {
                                  "description" = <<-EOT
                                  xContentTypeOptions defines the X-Content-Type-Options header to HTTP responses.
                                  Unset if blank. Accepted value is nosniff.
                                  https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options
                                  EOT
                                  "enum" = [
                                    "",
                                    "NoSniff",
                                  ]
                                  "type" = "string"
                                }
                                "xFrameOptions" = {
                                  "description" = <<-EOT
                                  xFrameOptions defines the X-Frame-Options header to HTTP responses.
                                  Unset if blank. Accepted values are deny and sameorigin.
                                  https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
                                  EOT
                                  "enum" = [
                                    "",
                                    "Deny",
                                    "SameOrigin",
                                  ]
                                  "type" = "string"
                                }
                                "xXSSProtection" = {
                                  "description" = <<-EOT
                                  xXSSProtection defines the X-XSS-Protection header to all responses.
                                  Unset if blank.
                                  https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection
                                  EOT
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "http2" = {
                              "description" = <<-EOT
                              http2 enable HTTP/2 support. Note that HTTP/2 is only supported with TLS.
                              When TLSConfig is not configured, HTTP/2 will be disabled.
                              Whenever the value of the field changes, a rolling update will be triggered.
                              EOT
                              "type" = "boolean"
                            }
                          }
                          "type" = "object"
                        }
                        "maxConnections" = {
                          "description" = <<-EOT
                          maxConnections defines the maximum number of simultaneous connections
                          A zero value means that Prometheus doesn't accept any incoming connection.
                          EOT
                          "format" = "int32"
                          "minimum" = 0
                          "type" = "integer"
                        }
                        "pageTitle" = {
                          "description" = "pageTitle defines the prometheus web page title."
                          "type" = "string"
                        }
                        "tlsConfig" = {
                          "description" = "tlsConfig defines the TLS parameters for HTTPS."
                          "properties" = {
                            "cert" = {
                              "description" = <<-EOT
                              cert defines the Secret or ConfigMap containing the TLS certificate for the web server.
                              
                              Either `keySecret` or `keyFile` must be defined.
                              
                              It is mutually exclusive with `certFile`.
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
                            "certFile" = {
                              "description" = <<-EOT
                              certFile defines the path to the TLS certificate file in the container for the web server.
                              
                              Either `keySecret` or `keyFile` must be defined.
                              
                              It is mutually exclusive with `cert`.
                              EOT
                              "type" = "string"
                            }
                            "cipherSuites" = {
                              "description" = <<-EOT
                              cipherSuites defines the list of supported cipher suites for TLS versions up to TLS 1.2.
                              
                              If not defined, the Go default cipher suites are used.
                              Available cipher suites are documented in the Go documentation:
                              https://golang.org/pkg/crypto/tls/#pkg-constants
                              EOT
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                            "clientAuthType" = {
                              "description" = <<-EOT
                              clientAuthType defines the server policy for client TLS authentication.
                              
                              For more detail on clientAuth options:
                              https://golang.org/pkg/crypto/tls/#ClientAuthType
                              EOT
                              "type" = "string"
                            }
                            "clientCAFile" = {
                              "description" = <<-EOT
                              clientCAFile defines the path to the CA certificate file for client certificate authentication to
                              the server.
                              
                              It is mutually exclusive with `client_ca`.
                              EOT
                              "type" = "string"
                            }
                            "client_ca" = {
                              "description" = <<-EOT
                              client_ca defines the Secret or ConfigMap containing the CA certificate for client certificate
                              authentication to the server.
                              
                              It is mutually exclusive with `clientCAFile`.
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
                            "curvePreferences" = {
                              "description" = <<-EOT
                              curvePreferences defines elliptic curves that will be used in an ECDHE handshake, in preference
                              order.
                              
                              Available curves are documented in the Go documentation:
                              https://golang.org/pkg/crypto/tls/#CurveID
                              EOT
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                            "keyFile" = {
                              "description" = <<-EOT
                              keyFile defines the path to the TLS private key file in the container for the web server.
                              
                              If defined, either `cert` or `certFile` must be defined.
                              
                              It is mutually exclusive with `keySecret`.
                              EOT
                              "type" = "string"
                            }
                            "keySecret" = {
                              "description" = <<-EOT
                              keySecret defines the secret containing the TLS private key for the web server.
                              
                              Either `cert` or `certFile` must be defined.
                              
                              It is mutually exclusive with `keyFile`.
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
                            "maxVersion" = {
                              "description" = "maxVersion defines the Maximum TLS version that is acceptable."
                              "type" = "string"
                            }
                            "minVersion" = {
                              "description" = "minVersion defines the minimum TLS version that is acceptable."
                              "type" = "string"
                            }
                            "preferServerCipherSuites" = {
                              "description" = <<-EOT
                              preferServerCipherSuites defines whether the server selects the client's most preferred cipher
                              suite, or the server's most preferred cipher suite.
                              
                              If true then the server's preference, as expressed in
                              the order of elements in cipherSuites, is used.
                              EOT
                              "type" = "boolean"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                  }
                  "type" = "object"
                  "x-kubernetes-validations" = [
                    {
                      "message" = "replicas cannot be set when mode is DaemonSet"
                      "rule" = "!(has(self.mode) && self.mode == 'DaemonSet' && has(self.replicas))"
                    },
                    {
                      "message" = "storage cannot be set when mode is DaemonSet"
                      "rule" = "!(has(self.mode) && self.mode == 'DaemonSet' && has(self.storage))"
                    },
                    {
                      "message" = "shards cannot be greater than 1 when mode is DaemonSet"
                      "rule" = "!(has(self.mode) && self.mode == 'DaemonSet' && has(self.shards) && self.shards > 1)"
                    },
                    {
                      "message" = "persistentVolumeClaimRetentionPolicy cannot be set when mode is DaemonSet"
                      "rule" = "!(has(self.mode) && self.mode == 'DaemonSet' && has(self.persistentVolumeClaimRetentionPolicy))"
                    },
                    {
                      "message" = "scrapeConfigSelector cannot be set when mode is DaemonSet"
                      "rule" = "!(has(self.mode) && self.mode == 'DaemonSet' && has(self.scrapeConfigSelector))"
                    },
                    {
                      "message" = "probeSelector cannot be set when mode is DaemonSet"
                      "rule" = "!(has(self.mode) && self.mode == 'DaemonSet' && has(self.probeSelector))"
                    },
                    {
                      "message" = "scrapeConfigNamespaceSelector cannot be set when mode is DaemonSet"
                      "rule" = "!(has(self.mode) && self.mode == 'DaemonSet' && has(self.scrapeConfigNamespaceSelector))"
                    },
                    {
                      "message" = "probeNamespaceSelector cannot be set when mode is DaemonSet"
                      "rule" = "!(has(self.mode) && self.mode == 'DaemonSet' && has(self.probeNamespaceSelector))"
                    },
                    {
                      "message" = "serviceMonitorSelector cannot be set when mode is DaemonSet"
                      "rule" = "!(has(self.mode) && self.mode == 'DaemonSet' && has(self.serviceMonitorSelector))"
                    },
                    {
                      "message" = "serviceMonitorNamespaceSelector cannot be set when mode is DaemonSet"
                      "rule" = "!(has(self.mode) && self.mode == 'DaemonSet' && has(self.serviceMonitorNamespaceSelector))"
                    },
                    {
                      "message" = "additionalScrapeConfigs cannot be set when mode is DaemonSet"
                      "rule" = "!(has(self.mode) && self.mode == 'DaemonSet' && has(self.additionalScrapeConfigs))"
                    },
                    {
                      "message" = "shardingStrategy cannot be set when mode is DaemonSet"
                      "rule" = "!(has(self.mode) && self.mode == 'DaemonSet' && has(self.shardingStrategy))"
                    },
                    {
                      "message" = "shards must be greater than or equal to the number of topology values when sharding strategy mode is Topology"
                      "rule" = "!has(self.shardingStrategy) || !has(self.shardingStrategy.mode) || self.shardingStrategy.mode != 'Topology' || !has(self.shardingStrategy.topology) || !has(self.shardingStrategy.topology.values) || self.shardingStrategy.topology.values.size() == 0 || (has(self.shards) ? self.shards : 1) >= self.shardingStrategy.topology.values.size()"
                    },
                  ]
                }
                "status" = {
                  "description" = <<-EOT
                  status defines the most recent observed status of the Prometheus cluster. Read-only.
                  More info:
                  https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
                  EOT
                  "properties" = {
                    "availableReplicas" = {
                      "description" = <<-EOT
                      availableReplicas defines the total number of available pods (ready for at least minReadySeconds)
                      targeted by this Prometheus deployment.
                      EOT
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "conditions" = {
                      "description" = "conditions defines the current state of the Prometheus deployment."
                      "items" = {
                        "description" = <<-EOT
                        Condition represents the state of the resources associated with the
                        Prometheus, Alertmanager or ThanosRuler resource.
                        EOT
                        "properties" = {
                          "lastTransitionTime" = {
                            "description" = "lastTransitionTime is the time of the last update to the current status property."
                            "format" = "date-time"
                            "type" = "string"
                          }
                          "message" = {
                            "description" = "message defines human-readable message indicating details for the condition's last transition."
                            "type" = "string"
                          }
                          "observedGeneration" = {
                            "description" = <<-EOT
                            observedGeneration defines the .metadata.generation that the
                            condition was set based upon. For instance, if `.metadata.generation` is
                            currently 12, but the `.status.conditions[].observedGeneration` is 9, the
                            condition is out of date with respect to the current state of the
                            instance.
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
                            "description" = "type of the condition being reported."
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
                    "paused" = {
                      "description" = <<-EOT
                      paused defines whether any actions on the underlying managed objects are
                      being performed. Only delete actions will be performed.
                      EOT
                      "type" = "boolean"
                    }
                    "replicas" = {
                      "description" = <<-EOT
                      replicas defines the total number of non-terminated pods targeted by this Prometheus deployment
                      (their labels match the selector).
                      EOT
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "selector" = {
                      "description" = "selector used to match the pods targeted by this Prometheus resource."
                      "type" = "string"
                    }
                    "shardStatuses" = {
                      "description" = "shardStatuses defines the list has one entry per shard. Each entry provides a summary of the shard status."
                      "items" = {
                        "properties" = {
                          "availableReplicas" = {
                            "description" = <<-EOT
                            availableReplicas defines the total number of available pods (ready for at least minReadySeconds)
                            targeted by this shard.
                            EOT
                            "format" = "int32"
                            "type" = "integer"
                          }
                          "replicas" = {
                            "description" = "replicas defines the total number of pods targeted by this shard."
                            "format" = "int32"
                            "type" = "integer"
                          }
                          "shardID" = {
                            "description" = "shardID defines the identifier of the shard."
                            "type" = "string"
                          }
                          "unavailableReplicas" = {
                            "description" = "unavailableReplicas defines the Total number of unavailable pods targeted by this shard."
                            "format" = "int32"
                            "type" = "integer"
                          }
                          "updatedReplicas" = {
                            "description" = <<-EOT
                            updatedReplicas defines the total number of non-terminated pods targeted by this shard
                            that have the desired spec.
                            EOT
                            "format" = "int32"
                            "type" = "integer"
                          }
                        }
                        "required" = [
                          "availableReplicas",
                          "replicas",
                          "shardID",
                          "unavailableReplicas",
                          "updatedReplicas",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                      "x-kubernetes-list-map-keys" = [
                        "shardID",
                      ]
                      "x-kubernetes-list-type" = "map"
                    }
                    "shards" = {
                      "description" = "shards defines the most recently observed number of shards."
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "unavailableReplicas" = {
                      "description" = "unavailableReplicas defines the total number of unavailable pods targeted by this Prometheus deployment."
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "updatedReplicas" = {
                      "description" = <<-EOT
                      updatedReplicas defines the total number of non-terminated pods targeted by this Prometheus deployment
                      that have the desired version spec.
                      EOT
                      "format" = "int32"
                      "type" = "integer"
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
            "scale" = {
              "labelSelectorPath" = ".status.selector"
              "specReplicasPath" = ".spec.shards"
              "statusReplicasPath" = ".status.shards"
            }
            "status" = {}
          }
        },
      ]
    }
  }
}
