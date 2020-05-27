#!/bin/bash

[ `whoami` != 'root' ] && exit
[ -e /sys/firmware/efi/efivars ] && exit
timedatectl set-ntp true


echo "Welcome!"
echo
lsblk
echo
read -p "Select Disk: " disk
echo
[ -z "$disk" ] && exit
disk=/dev/`basename $disk`
d=`lsblk -dpn | awk '{print $1}'`
echo $d | grep -q -w $disk
[ $? != 0 ] && exit


echo "Partitioning is Optional!"
echo "Skip to keep \"\home\" Data."
echo
read -p "Partition? [n]/y: " -n 1
echo

[[ $REPLY = 'y' ]] &&
{
    echo "Entire data in [$disk] will be lost!"
    echo
    read -p "Confirm? [n]/y: " -n 1
    echo

    [[ $REPLY = 'y' ]] &&
    {
    wipefs -fa $disk
cat <<EOF | fdisk $disk -W always
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


w
EOF
    partprobe
    yes | mkfs.ext4 ${disk}4
    }
}


yes | mkfs.ext4 ${disk}1
yes | mkfs.ext4 ${disk}2
mkswap ${disk}3


mkdir -p /mnt
mount ${disk}2 /mnt
mkdir -p /mnt/{boot,home}
mount ${disk}1 /mnt/boot
mount ${disk}4 /mnt/home
swapon ${disk}3


pacstrap /mnt base linux linux-firmware grub gvim
genfstab -U /mnt >/mnt/etc/fstab

echo $disk >/mnt/disk.txt
curl https://raw.githubusercontent.com/albertshaji/scripts/master/arch-user.sh >/mnt/arch-user.sh
chmod +x /mnt/arch-user.sh

arch-chroot /mnt
umount -R /mnt
swapoff ${disk}3
