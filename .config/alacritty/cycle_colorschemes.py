#!/usr/bin/env python

import yaml
import os
import re


COLOR_SCHEME_FILENAME = "colorschemes.yaml"
CONFIG_FILENAME = "colorschemes.yaml"
CONFIG_FILE_DIR = os.path.expanduser("~/.config/alacritty/")
COLOR_SCHEME_FILEPATH = os.path.join(CONFIG_FILE_DIR, COLOR_SCHEME_FILENAME)
CONFIG_FILEPATH = os.path.join(CONFIG_FILE_DIR, CONFIG_FILENAME)

COLOR_SCHEME_LINE_SEARCH = "colors: \*(\S+)"
COLOR_SCHEME_LINE_TEMPLATE = "colors: *{}\n"

with open(COLOR_SCHEME_FILEPATH, "r") as color_scheme_file:
    config = yaml.safe_load(color_scheme_file)
    color_scheme_file.seek(0)
    lines = color_scheme_file.readlines()

colors_line_index = -1
for i, line in enumerate(lines):
    match = re.search(COLOR_SCHEME_LINE_SEARCH, line)
    if match is not None:
        current_color_scheme = match.group(1)
        colors_line_index = i

available_color_schemes = list(config["schemes"].keys())

color_scheme_index = available_color_schemes.index(current_color_scheme)
color_scheme_index = (color_scheme_index + 1) % len(available_color_schemes)

lines[colors_line_index] = COLOR_SCHEME_LINE_TEMPLATE.format(
    available_color_schemes[color_scheme_index]
)

with open(CONFIG_FILEPATH, "w") as config_file:
    for line in lines:
        config_file.write(line)
