Example [direnv](https://github.com/direnv/direnv) `.envrc`:

```sh
# AWS credentials
export AWS_ACCESS_KEY_ID=FIXME
export AWS_SECRET_ACCESS_KEY=FIXME
export AWS_DEFAULT_REGION=eu-west-1

# Digital Ocean access tokens
export DIGITALOCEAN_ACCESS_TOKEN=FIXME
export SPACES_ACCESS_KEY_ID=FIXME
export SPACES_SECRET_ACCESS_KEY=FIXME

# GitHub personal access token
# public_repo, admin:org
export GITHUB_TOKEN=FIXME

# Optional. Let us use `kubectl`.
# https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/#set-the-kubeconfig-environment-variable
export KUBECONFIG="$HOME/.kube/config:$(pwd)/kubeconfig_do"

# Optional. Let us use VS Code for `kubectl edit`.
export KUBE_EDITOR="code -w"
```
