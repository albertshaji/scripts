#!/bin/bash

[ `whoami` != 'root' ] && exit

USER="alby"
SHELL="zsh"
EMAIL="alby@disroot.org"
HOSTNAME="arch"
TIMEZONE="Asia/Kolkata"
HIBERNATION=true
KERNEL=linux-lts

read -p "Enter a password for the user: " PASS1
read -p "Re-enter password :" PASS2
until [ "$PASS1" = "$PASS2" ]
do
	unset PASS1 PASS2
	read -p "Enter a password for the user: " PASS1
	read -p "Re-enter password :" PASS2
done

ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo $HOSTNAME > /etc/hostname

grub-install `cat /Disk.txt`
sed -i "/GRUB_TIMEOUT_STYLE/c\GRUB_TIMEOUT_STYLE=hidden" /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

pacman --noconfirm --needed -Sy `cat /Pacman.txt`

cd /home
[ -d $USER ] &&
{
    k=(
    .suckless
    .aur
    .scripts
    .arch
    .gnupg
    .password-store
    .stardict
    .vimtex
    .vim
    `ls $USER`
    )

    mv $USER ${USER}-old
    mkdir $USER
    chmod 700 $USER
    mv "${k[@]/#/${USER}-old/}" $USER

    chown -Rv $USER:wheel /home/$USER-old
    chown -Rv $USER:wheel /home/$USER
}

useradd -m -g wheel -s /bin/$SHELL $USER
echo "$USER:$PASS1" | chpasswd
echo "root:$PASS1" | chpasswd
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
cd $USER

[ -d .scripts ] || git clone https://github.com/albertshaji/scripts.git .scripts
[ -d .arch ] || git clone https://github.com/albertshaji/arch.git .arch
export PATH="$PATH:/home/$USER/.scripts"
config.sh
chown -Rv $USER:wheel /home/$USER

if $HIBERNATION
then
    sed -i "/GRUB_CMDLINE_LINUX_DEFAULT/c\GRUB_CMDLINE_LINUX_DEFAULT=\"$KERNEL /boot/vmlinuz-$KERNEL resume=`cat /Disk.txt`3 quiet splash\"" /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
    sed -i "/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/c\HOOKS=(base udev autodetect modconf block filesystems keyboard resume fsck)" /etc/mkinitcpio.conf
    mkinitcpio -P
fi

if pacman -Qs git >/dev/null
then
    sudo -u $USER git config --global user.name $USER
    sudo -u $USER git config --global user.email $EMAIL
    sudo -u $USER git config --global credential.helper store
fi

if pacman -Qs syncthing >/dev/null
then
    systemctl enable syncthing@$USER
fi

if pacman -Qs ranger >/dev/null
then
    sudo -u ranger --copy-config=scope
fi

[ -d .suckless ] &&
{
    cd .suckless
    for p in `ls`
    do
	    make -C $p clean install
    done
    cd ..
}

if pacman -Qs python-pip >/dev/null
then
    pip install `cat /Python.txt`
fi

sudo -u $USER aur.sh `cat /Aur.txt`

if pacman -Qs fprintd >/dev/null
then
	echo "Run \"fprintd-enroll\" after login!"
fi

figlet "Installation Completed!"
