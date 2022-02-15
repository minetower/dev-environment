#!/bin/bash

# check for unpublished commits

source "$(dirname "$0")/init.sh"

branch='master'
repos+=('.')

for repo in "${repos[@]}"; do
	cd "$repo"
	if [[ "$(git rev-parse origin/$branch)" != "$(git rev-parse $branch)" ]]; then
		echo "unpublished: $repo"
	fi
	cd - >/dev/null
done
