#!/bin/bash

set -e

# Check if the script is run as root
if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
fi

IMAGE_DIR=/compile/local/imagebuilder-diskimage
IMG=${IMAGE_DIR}/arch.img

# Display partitions and then ask user what partition to install to install to
lsblk
echo "Enter the disk (e.g. /dev/sda) to install to. Do not enter a partition, only the entire disk."
read FLASH_DEV

read -p "Are you SURE you want to flash to $FLASH_DEV? (y/n): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
	dd bs=4M if=${IMG} of=${FLASH_DEV} status=progress
	sync
	growpart ${FLASH_DEV} 4
	mkdir -p /mnt/roottmp
	mount ${FLASH_DEV}4 /mnt/roottmp
	btrfs filesystem resize max /mnt/roottmp
	umount /mnt/roottmp
	rmdir /mnt/roottmp
	echo "Image flashed."
fi
