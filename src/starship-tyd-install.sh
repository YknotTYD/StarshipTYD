#!/usr/bin/env sh
#starship-tyd-install.sh

# creates a backup of the current starship config if possible
# installs the starship config
# installs the sudo cache worker

if [ -z "$HOME" ]; then
	echo '$HOME is unset.' 1>&2
	exit 1
fi

set -eu

SRC_DIR="$(cd -- "$(dirname "$0")" && pwd)"

BASHRC="$HOME/.bashrc"
touch "$BASHRC"

CONF="$HOME/.config/starship.toml"
CONF_BACKUP="$HOME/.config/.starship.toml.backup" # backup the current starship
                                                  # config if possible
mkdir -p "$(dirname "$CONF")"                     #
                                                  #
if [ -f "$CONF" ]; then                           #
    cp "$CONF" "$CONF_BACKUP"                     #
fi                                                #

python3 "$SRC_DIR/starship_toml_gen.py" "$SRC_DIR/starship.toml" > "$CONF" # install the starship config

cp "$SRC_DIR/sudo-cache-worker.sh" "$HOME/.sudo-cache-worker.sh" # install the sudo cache worker
LAUNCH_SUDO_WORKER='source "$HOME/.sudo-cache-worker.sh"'        #
                                                                 #
if ! grep -q "$LAUNCH_SUDO_WORKER" "$BASHRC"; then               #
	printf '\n%s\n' "$LAUNCH_SUDO_WORKER" >> "$BASHRC"           #
fi                                                               #
