#!/usr/bin/env sh
#starship-tyd-install.sh

if [ -z "$HOME" ]; then
	echo "\$HOME is unset." 1>&2
	exit 1
fi

set -eu

BASHRC="$HOME/.bashrc"
touch "$BASHRC"

CONF="$HOME/.config/starship.toml"
CONF_BACKUP="$HOME/.config/.starship.toml.backup"

mkdir -p "$(dirname "$CONF")"

if [ -f "$CONF" ]; then
    cp "$CONF" "$CONF_BACKUP"
fi

python3 ./starship_toml_gen.py > "$CONF"

cp "./sudo-cache-worker.sh" "$HOME/sudo-cache-worker.sh"

if ! grep -q 'source "$HOME/sudo-cache-worker.sh"' "$BASHRC"; then
	echo '' >> "$BASHRC"
	echo 'source "$HOME/sudo-cache-worker.sh"' >> "$BASHRC"
fi
