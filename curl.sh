#!/usr/bin/env sh
#curl.sh

# installs starship if necessary
# creates a temporary directory to work in
# clones the repo
# launches starship-tyd-install.sh

if [ -z "$HOME" ]; then
	echo "\$HOME is unset." 1>&2
	exit 1
fi

set -eu

BASHRC="$HOME/.bashrc"
touch "$BASHRC"

if ! command -v starship > /dev/null 2>&1; then # starship: command not found

	mkdir -p "$HOME/.local/bin"             # add ~/.local/bin to PATH
	SETPATH='PATH="$HOME/.local/bin:$PATH"' #
                                            #
	if ! grep -q "$SETPATH" "$BASHRC"; then #
		echo ''         >> "$BASHRC"        #
		echo "$SETPATH" >> "$BASHRC"        #
	fi                                      #

	curl -sSLf https://starship.rs/install.sh | sh -s -- --version v1.24.1 --bin-dir "$HOME/.local/bin" # install starship
fi

STARSHIP_INIT='eval "$(starship init bash)"'  # add starship to ~/.bashrc
                                              #
if ! grep -q "$STARSHIP_INIT" "$BASHRC"; then #
	echo ''               >> "$BASHRC"        #
	echo "$STARSHIP_INIT" >> "$BASHRC"        #
fi

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT
cd "$TEMP_DIR"

git clone https://github.com/YknotTYD/StarshipTYD.git
cd StarshipTYD

sh "./starship-tyd-install.sh"
