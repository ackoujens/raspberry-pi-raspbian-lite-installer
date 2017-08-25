#!/bin/bash

# Raspberry Pi Raspbian Lite Installer
# Author: Jens Ackou



# ================================================
# SCRIPT SETUP
# ================================================

# Quit on error
set -e

# Horizontal line
_hLine="------------------------------------------------------------------------------------"

# Colorized INFO output
function _info() {
  COLOR='\033[00;32m' # green
  RESET='\033[00;00m' # white
  echo "${COLOR}${@}${RESET}"
}

# Colorized WARNING output
function _warn() {
  COLOR='\033[00;31m' # red
  RESET='\033[00;00m' # white
  echo "${COLOR}${@}${RESET}"
}

# Introduction (Font: Doom)
_info '
____________ _
| ___ \ ___ (_)
| |_/ / |_/ /_
|    /|  __/| |
| |\ \| |   | |
\_| \_\_|   |_|
______                _     _
| ___ \              | |   (_)
| |_/ /__ _ ___ _ __ | |__  _  __ _ _ __
|    // _` / __|  _ \|  _ \| |/ _` |  _ \
| |\ \ (_| \__ \ |_) | |_) | | (_| | | | |
\_| \_\__,_|___/ .__/|_.__/|_|\__,_|_| |_|
               | |
               |_|
 _____           _         _ _
|_   _|         | |       | | |
  | |  _ __  ___| |_  __ _| | | ___ _ __
  | | |  _ \/ __| __|/ _` | | |/ _ \  __|
 _| |_| | | \__ \ |_| (_| | | |  __/ |
 \___/|_| |_|___/\__|\__,_|_|_|\___|_|

'



# ================================================
# RPI IMAGE RETRIEVAL
# ================================================
_info '- Downloading latest Raspbian Lite image'
wget 'https://downloads.raspberrypi.org/raspbian_lite_latest'

# Set image path
# TODO Insert filename in variable from wget download
_imagePath="raspbian_lite_latest"

# TODO Check integrity of downloaded file
_warn "  - Image downloaded [?]"

# ERROR CHECK - Image path
if [ -z "$_imagePath" ]; then
  _warn $_hLine
  _warn "ERROR: NO IMAGE PATH SET"
  _warn $_hLine
  exit 0
else
  _info "  - Image path set [✓]"
fi



# ================================================
# EXTRACTING IMAGE
# ================================================
_info '  - Extracting image'
unzip -p $_imagePath > image


# ================================================
# SELECTING TARGET
# ================================================
_info '\n- Selecting target disk'
_sdCardDisk=""

function selectDisk() {
  _counter=0
  echo $_hLine

  # Combine Path with Counter
  while read line; do
    if [ "$_counter" -gt 0 ]; then
      echo "$_counter) $line"
      _mount[_counter]=$( echo $line | awk '{print $1;}')
    else
      _info "   $line"
      echo $_hLine
    fi
    ((_counter++))

  # Output disk table
  # TODO Cut unneeded columns to fit in terminal window
  done <<< "$(df -h)"
  echo "$_hLine\n"

  _selectedOption=''
  for i in "${!_mount[@]}"; do
      [ -z "$_selectedOption" ] && _selectedOption="${_selectedOption}${i}" || _selectedOption="${_selectedOption}, ${i}"
  done

  # Ask user to select mounted disk
  echo "Select the disk to use by entering the disk number."
  _warn "*** MAKE SURE YOU SELECT THE CORRECT DISK ***"
  _warn "*** If you select your main OS disk it can erase your entire disk ***"
  echo "\nUse disk [ $_selectedOption ] #"
  read _selection
  echo $_hLine

  # Set selected disk
  _sdCardDisk=${_mount[$_selection]}
  _selectedDiskSize=$( df -k | grep $_sdCardDisk | awk {'print $2'})
  _selectedDiskSizeHuman=$( df -h | grep $_sdCardDisk | awk {'print $2'})

  # Test if valid disk selected
  if [ -z "$_sdCardDisk" ]; then
      _warn "INVALID SELECTION - INPUT ANOTHER INTEGER VALUE"
      selectDisk
  elif (( $_selectedDiskSize > 67108864 )); then
    _warn "SAFEGUARD - TOTAL DISK SIZE IS LARGER THAN 64GB ($_selectedDiskSizeHuman / $_selectedDiskSize)"
    _warn "*** Please double check if this is the correct disk ($_sdCardDisk) ***"
  fi
}

# Run Prompt for SDCard disk
selectDisk

# Prompt to proceed installation
_info "You've chosen $_sdCardDisk as your target disk."
while true; do
    read -p "Do you want to continue? (Y/N)" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
  _info "  - Target disk selected [✓]"



# ================================================
# INSTALLATION PROCEDURE
# ================================================
# Format disk name to raw format
_rawdisk=$( echo $_sdCardDisk | awk 'sub("..$", "")' | sed 's/disk/rdisk/')

# Unmount Disk
_info "  - Unmounting Disk"
diskutil unmountDisk $_sdCardDisk

_info "  - Writing image"
_info "  *** Ctrl+T to see progress ***"
sudo dd bs=1m if=image of=$_rawdisk

# Eject disk
_info "- Ejecting Disk"
diskutil eject $_rawdisk

_info "- Disk safely removed"
_info "- - - INSTALL COMPLETE - - -"
