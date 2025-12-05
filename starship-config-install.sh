#!/usr/bin/env sh

cp ~/.config/starship.toml ~/.config/.starship.toml.backup && ./starship_toml_gen.py > ~/.config/starship.toml
