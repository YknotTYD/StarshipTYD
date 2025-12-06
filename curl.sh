#!/usr/bin/env sh
#curl.sh

set -eu

TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"
trap 'rm -rf "$TEMP_DIR"' EXIT

git clone https://github.com/YknotTYD/StarshipConfig.git StarshipConfig
cd StarshipConfig
sh starship-config-install.sh
