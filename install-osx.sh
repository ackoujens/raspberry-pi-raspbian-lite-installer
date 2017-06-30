#!/bin/bash

# Raspbian Lite Latest 2 SD Installer
# Author: Jens Ackou

# Quit on error
set -e

# Horizontal line
_hLine = "------------------------------------------------------------------------------------"

# Colorized INFO output
function _info() {
  COLOR='\033[00;32m' # green
  RESET='\033[00;00m' # white
  echo -e "${COLOR}${@}${RESET}"
}

# Colorized WARNING output
function _warn() {
  COLOR='\033[00;31m' # red
  RESET='\033[00;00m' # white
  echo -e "${COLOR}${@}${RESET}"
}

# Introduction (Font: Doom)
_info '
______          _     _               _     _ _             __     ___________
| ___ \        | |   (_)             | |   (_) |            \ \   /  ___|  _  \
| |_/ /__ _ ___| |__  _  __ _ _ __   | |    _| |_ ___   _____\ \  \ `--.| | | |
|    // _` / __| |_ \| |/ _` | |_ \  | |   | | __/ _ \ |______> >  `--. \ | | |
| |\ \ (_| \__ \ |_) | | (_| | | | | | |___| | ||  __/       / /  /\__/ / |/ /
\_| \_\__,_|___/_.__/|_|\__,_|_| |_| \_____/_|\__\___|      /_/   \____/|___/

'

# Retrieving to be instaled image
_info '- Downloading latest Raspbian Lite image'
wget 'https://downloads.raspberrypi.org/raspbian_lite_latest'
