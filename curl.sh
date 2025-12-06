#!/usr/bin/env sh
#curl.sh

set -eu

#check to add eval thing to bashrc

if ! command -v starship; then
	curl -sS https://starship.rs/install.sh | sh -s -- --version v1.24.1
fi

TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"
trap 'rm -rf "$TEMP_DIR"' EXIT

git clone https://github.com/YknotTYD/StarshipConfig.git StarshipConfig
cd StarshipConfig
sh starship-config-install.sh
