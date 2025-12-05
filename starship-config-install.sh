#!/usr/bin/env sh
#starship-config-install.sh

cp ~/.config/starship.toml ~/.config/.starship.toml.backup && python3 ./starship_toml_gen.py > ~/.config/starship.toml
