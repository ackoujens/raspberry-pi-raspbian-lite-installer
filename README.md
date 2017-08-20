# Raspbian Lite Latest 2 SD Installer

Install Raspbian to your SD card quick and stop doing this repetitive task now !

## How to use
- Download the `install-osx.sh` script
- Format SD Card (FAT)
- Execute script using the terminal command
`sh install-osx.sh`
- Follow instructions printed in the terminal
- Put the SD Card in your raspberry pi
- Power your raspberry pi while connected to an ethernet cable
- Open a terminal on your mac
- `ssh pi@<RaspberryPiIP>`
(I found the RPI's ip by logging in into my router where it was connect to)
- "raspberry" is the default password when connecting the first time

## Features
- OSX Terminal compatible
- Downloads latest Rasbian Lite image from raspberrypi.org
- Safety measures to prevent ruining operating your system drive
- Error checking every step of the install for easier debugging (incomplete)

## Todo
- Windows CMD/Powershell implementation
- Linux Terminal implementation
- SD Card formatting
- SD Card detection after previous flash attempt
- Create an `ssh` file on the sd card after Raspbian install
