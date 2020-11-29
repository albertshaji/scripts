#!/bin/bash

KERNEL=linux-lts

[ `whoami` != 'root' ] && exit
[ -e /sys/firmware/efi/efivars ] && exit

timedatectl set-ntp true

echo "Welcome!"
echo
lsblk
echo
read -p "Select Disk: " DISK
echo
[ -z "$DISK" ] && exit
DISK=/dev/`basename $DISK`
d=`lsblk -dpn | awk '{print $1}'`
echo $d | grep -q -w $DISK
[ $? != 0 ] && exit

echo "Partitioning is an Optional Step!"
echo "Skip this to retain \"\home\" Data."
echo
read -p "Partition? [n]/y: " -n 1
echo

[[ $REPLY = 'y' ]] &&
{
    echo "$DISK is about to be formated!"
    echo
    read -p "Confirm? [n]/y: " -n 1
    echo

    [[ $REPLY = 'y' ]] &&
    {
    wipefs -fa $DISK
cat <<EOF | fDISK $DISK -W always
o
n
p


+200M
n
p


+16G
n
p


+4G
n
p



p
w
EOF
    partprobe
    yes | mkfs.ext4 ${DISK}4
    }
}

yes | mkfs.ext4 ${DISK}1
yes | mkfs.ext4 ${DISK}2
mkswap ${DISK}3

mkdir -p /mnt
mount ${DISK}2 /mnt

mkdir -p /mnt/{boot,home}
mount ${DISK}1 /mnt/boot
mount ${DISK}4 /mnt/home
swapon ${DISK}3

pacstrap /mnt base $KERNEL ${KERNEL}-headers linux-firmware grub gvim networkmanager

genfstab -U /mnt >/mnt/etc/fstab

echo $DISK >/mnt/Disk.txt
curl https://albertshaji.github.io/LinuxScripts/arch-user.sh >/mnt/arch-user.sh
chmod +x /mnt/arch-user.sh

curl https://albertshaji.github.io/arch/Pacman.txt >/mnt/Pacman.txt
curl https://albertshaji.github.io/arch/Python.txt >/mnt/Python.txt
curl https://albertshaji.github.io/arch/Aur.txt >/mnt/Aur.txt

arch-chroot /mnt
umount -R /mnt
swapoff ${DISK}3
