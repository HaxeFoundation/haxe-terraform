Tools and environment variables are managed by [mise](https://mise.jdx.dev/).

Put the credentials in `mise.local.toml` (git-ignored):

```toml
[env]
# AWS credentials
AWS_ACCESS_KEY_ID = "FIXME"
AWS_SECRET_ACCESS_KEY = "FIXME"
AWS_DEFAULT_REGION = "eu-west-1"

# Digital Ocean access tokens
DIGITALOCEAN_ACCESS_TOKEN = "FIXME"
SPACES_ACCESS_KEY_ID = "FIXME"
SPACES_SECRET_ACCESS_KEY = "FIXME"

# Optional. Let us use VS Code for `kubectl edit`.
KUBE_EDITOR = "code -w"
```
