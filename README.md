# Raspbian Lite Latest 2 SD Installer

Install Raspbian to your SD card quick and stop doing this repetitive task now !

## How to use
1. Download the `install-osx.sh` script
2. Format SD Card (Tested on FAT partitioning)
3. Execute script using the terminal command

`sudo sh install-osx.sh`
(note: you'll need to be in the same directory as the script)

4. Follow instructions printed in the terminal
5. Put the SD Card in your raspberry pi
6. Power your raspberry pi while connected to an ethernet cable
7. Connect to your RPi over SSH

`sudo ssh pi@<RaspberryPiIP>`

(I found the RPI's ip by logging in into my router where it was connect to)
Default password: raspberry

## Features
- MacOS Terminal compatible
- Downloads latest Rasbian Lite image from raspberrypi.org
- Safety measures to prevent ruining operating your system drive
- Error checking every step of the install for easier debugging
- Integrated SD Card formatting
- Automatically create an `ssh` file on the sd card after the Raspbian install

## Todo
- Windows CMD/Powershell implementation
- Linux Terminal implementation
- SD Card detection after previous flash attempt
- Detect if downloaded image is already present to prevent multiple downloads of the same file
- Prompt to download a fresh image or continue with the currently present one
