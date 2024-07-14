# Arch Linux imagebuilder for kukui

*Most of the stuff here was written by [@linsyking](https://www.github.com/linsyking) - I just changed a few things so that I could build on kukui*

Simple script to build an Arch Linux ARM image for kukui Chromebooks (tested only on kappa).

# Build environment

You need to run this script on an `aarch64` device. Otherwise you need to change `arch-chroot` commands in the script.

Several build dependencies are needed.

- arch-chroot
- cgpt
- growpart
- btrfs
- tar
- bsdtar
- sed
- wget
- sync
- rmdir
- sgdisk
- losetup
- partprobe
- fdisk
- mkfs (ext4, btrfs)
- rsync
- fallocate
- mkswap
- truncate

# Build

Run `run.sh` to create rootfs. Then run `build_image.sh` to build the image. Finally run `flash_disk` to flash the image.

The building directory is in `compile/local`.

# After-build

After boot, you should first run `mkinitcpio -g /boot/initrd.img-6.6.9-stb-mt8+` to create the initramfs.

The network should be ready. Use `nmtui` to connect to wifi.

You could run some scripts in `/scripts`.
