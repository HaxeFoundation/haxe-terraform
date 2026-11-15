#!/usr/bin/env bash
# Run the DOKS clusterlint checks against the DO k8s cluster.
# These are the checks DigitalOcean runs before automatic upgrades:
# any "error" diagnostic blocks the upgrade, so this script exits 1 on errors.
# Warnings are reported but don't fail.
#
# clusterlint itself exits 0 even when it finds errors, so parse its JSON output.
# In GitHub Actions, errors become annotations and all diagnostics go to the job summary.
set -euo pipefail

cd "$(dirname "$0")/.."

result="$(clusterlint run --groups doks --output json)"

# one diagnostic per line: severity, check, object, message
diagnostics="$(jq -r '
  .Diagnostics // []
  | sort_by(.Severity, .Check, .Object.namespace, .Object.name)
  | .[]
  | [
      .Severity,
      .Check,
      ([.Object.namespace, (.Kind | ascii_downcase), .Object.name] | map(select(. != null and . != "")) | join("/")),
      .Message
    ]
  | @tsv
' <<<"$result")"

count() { jq --arg s "$1" '[.Diagnostics // [] | .[] | select(.Severity == $s)] | length' <<<"$result"; }
errors="$(count error)"
warnings="$(count warning)"
suggestions="$(count suggestion)"

if [[ -n "$diagnostics" ]]; then
  while IFS=$'\t' read -r severity check object message; do
    echo "[$severity] $check: $object: $message"
    if [[ "$severity" == "error" && -n "${GITHUB_ACTIONS:-}" ]]; then
      echo "::error title=clusterlint $check::$object: $message"
    fi
  done <<<"$diagnostics"
fi

summary="clusterlint (doks): $errors error(s), $warnings warning(s), $suggestions suggestion(s)"
echo
echo "$summary"

if [[ -n "${GITHUB_STEP_SUMMARY:-}" ]]; then
  {
    echo "## $summary"
    echo
    if [[ "$errors" -gt 0 ]]; then
      echo "Errors block DOKS automatic upgrades."
      echo
    fi
    if [[ -n "$diagnostics" ]]; then
      echo "| Severity | Check | Object | Message |"
      echo "| --- | --- | --- | --- |"
      while IFS=$'\t' read -r severity check object message; do
        echo "| $severity | \`$check\` | \`$object\` | ${message//|/\\|} |"
      done <<<"$diagnostics"
    fi
  } >>"$GITHUB_STEP_SUMMARY"
fi

if [[ "$errors" -gt 0 ]]; then
  exit 1
fi
