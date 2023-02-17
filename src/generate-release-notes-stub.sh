#!/usr/bin/env bash

if [[ $# < 1 ]]; then
  echo "Usage: generate-release-notes-stub.sh milestone"
  exit 1
fi

# If we can get good at tagging things correctly "bug", "enhancement", "feature" we should be able to make this produce the stub
# for each section in the release notes - or get close.
#
milestone=$1

gh issue list --repo FusionAuth/fusionauth-issues -m $milestone -L 250 --search "sort:created-asc" --json number,title --jq ".[]|[.number,.title] | @tsv" |
while IFS=$'\t' read -r number title; do
  echo "* $title"
  echo "** Resolves https://github.com/FusionAuth/fusionauth-issues/issues/$number[GitHub Issue #$number]"
done