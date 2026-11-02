#!/usr/bin/env bash
# Update the `version` of the DigitalOcean k8s cluster in do-k8s.tf,
# and the kubectl version in mise.toml,
# to match the version currently running (e.g. after an auto-upgrade).
set -euo pipefail

cd "$(dirname "$0")/.."

tf_file="do-k8s.tf"
cluster_name="${1:-$(sed -nE 's/^[[:space:]]*stack_name[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/p' locals.tf)}"

if [[ -z "$cluster_name" ]]; then
  echo "Could not determine cluster name from locals.tf" >&2
  exit 1
fi

current="$(doctl kubernetes cluster get "$cluster_name" --format Version --no-header | tr -d '[:space:]')"
if [[ -z "$current" ]]; then
  echo "Could not get version of cluster $cluster_name" >&2
  exit 1
fi

# only touch the `version` inside the cluster resource block
block='/^resource "digitalocean_kubernetes_cluster" "cluster"/,/^}/'
pattern='^([[:space:]]*version[[:space:]]*=[[:space:]]*")([^"]*)(".*)$'
previous="$(sed -nE "${block}s/${pattern}/\2/p" "$tf_file")"
if [[ -z "$previous" ]]; then
  echo "Could not find cluster version in $tf_file" >&2
  exit 1
fi

if [[ "$previous" == "$current" ]]; then
  echo "$tf_file is already at $current"
else
  tmp="$(mktemp)"
  sed -E "${block}s/${pattern}/\1${current}\3/" "$tf_file" > "$tmp"
  cat "$tmp" > "$tf_file"
  rm "$tmp"
  echo "Updated $tf_file: $previous -> $current"
fi

# kubectl in mise.toml should match the cluster minor version
minor="$(echo "$current" | cut -d. -f1-2)"
previous="$(mise list kubectl --current --json | jq -r '.[0].requested_version // empty')"
if [[ "$previous" == "$minor" ]]; then
  echo "mise.toml kubectl is already at $minor"
else
  # also installs the new version and updates mise.lock
  mise use "kubectl@${minor}"
  echo "Updated mise.toml kubectl: $previous -> $minor"
fi
