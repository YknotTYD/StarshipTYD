#!/usr/bin/env python3
#starship_toml_gen.py

"""
Made to be used by install_starship_config.sh.
"""

battery_display_text: str = """
[[battery.display]]
threshold = {}
style = "bold {}"
"""

with open("starship.toml", "r") as file:
    file_content = file.read().split("\n")

replacement_index = file_content.index("#PYTHONANCHOR_REPLACE")
file_content[replacement_index] = ""

for i in range(0, 100):

    color = (int(255 - (i / 100 * 255)), 255, 0)       #(255, 255, 0) to (0, 255, 0)
    color = [int(i * 0.85) for i in color]             #reduce all channel values by 15%
    color = [hex(i).removeprefix("0x") for i in color] #e.g. (255, 11, 0)       to ('ff', 'b', '0')
    color = [f"{i:0>2}" for i in color]                #e.g. ('ff', 'b', '0')   to ('ff', '0b', '00')
    color = "#" + "".join(color)                       #e.g. ('ff', '0b', '00') to '#ff0b00'

    file_content[replacement_index] += battery_display_text.format(i + 1, color)

for line in file_content:
    print(line)
