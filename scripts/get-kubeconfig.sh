#!/usr/bin/env bash
# Save the kubeconfig of the DigitalOcean k8s cluster to kubeconfig_do,
# which is used by the kubernetes and helm providers in do-k8s.tf.
set -euo pipefail

cd "$(dirname "$0")/.."

out_file="kubeconfig_do"
cluster_name="${1:-$(sed -nE 's/^[[:space:]]*stack_name[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/p' locals.tf)}"

if [[ -z "$cluster_name" ]]; then
  echo "Could not determine cluster name from locals.tf" >&2
  exit 1
fi

# write to a fresh file instead of merging into an existing kubeconfig
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
install -m 600 /dev/null "$tmp_dir/kubeconfig"
KUBECONFIG="$tmp_dir/kubeconfig" doctl kubernetes cluster kubeconfig save "$cluster_name"
install -m 600 "$tmp_dir/kubeconfig" "$out_file"
echo "Saved kubeconfig of cluster $cluster_name to $out_file"
