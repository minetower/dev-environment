#!/bin/bash

source "$(dirname "$0")/init.sh"

url='https://github.com/minetower'

USAGE="$0 [OPTIONS]

Arguments:
  --needed=REPO   Clone only repositories needed for the REPO
  --all           Clone all repositories, including optional
  --ssh           Use SSH when cloning
  -h, --help      Show this message"

# assign array as array
clone_repos=("${repos[@]}")

# parse opts
for i in "$@"; do
	case $i in
	--needed=* )
		REPO=${i#*=}
		case $REPO in
			minecraft-tweaks )
				clone_repos=("${needed_minecraft_tweaks[@]}");;
			* )
				echo "Not found repo \"$REPO\""
				exit;;
		esac
		shift;;
	--ssh )
		SSH=true
		shift;;
	--all )
		clone_repos=("${clone_repos[@]}" "${optional_repos[@]}")
		shift;;
	-h|--help )
		echo "$USAGE"
		exit;;
	* )
		shift;;
	esac
done

if [[ $SSH ]]; then
	url='git@github.com:minetower'

	echo 'Starting ssh-agent for 5 minutes'
	ssh-agent -t 5m || echo 'Cannot start ssh-agent'
fi

# clone
for repo in "${clone_repos[@]}"; do
	git clone "$url/$repo.git" "$repo"
done
