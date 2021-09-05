Example [direnv](https://github.com/direnv/direnv) `.envrc`:

```sh
# AWS credentials
export AWS_ACCESS_KEY_ID=FIXME
export AWS_SECRET_ACCESS_KEY=FIXME
export AWS_DEFAULT_REGION=eu-west-1

# Optional. Let us use `kubectl`.
# https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/#set-the-kubeconfig-environment-variable
export KUBECONFIG="$(pwd)/kubeconfig_haxe2021"

# Optional. Let us use VS Code for `kubectl edit`.
export KUBE_EDITOR="code -w"
```
