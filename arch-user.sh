#!/bin/bash

[ `whoami` != 'root' ] && exit

USER="alby"
SHELL="zsh"
EMAIL="alby@disroot.org"
HOSTNAME="arch"
TIMEZONE="Asia/Kolkata"

arch_pack=(
base-devel
networkmanager
ranger
alsa
alsa-utils
libinput
xorg-server
xorg-xinit
xf86-video-intel
xorg-xsetroot
xorg-xbacklight
xorg-xinput
xorg-xev
zsh
git
man
terminus-font
noto-fonts
adobe-source-code-pro-fonts
intel-ucode
libexif
imlib2
neomutt
sdcv
zathura
zathura-pdf-mupdf
zathura-djvu
words
flite
ntfsprogs
udisks2
mpv
moc
ffmpeg
figlet
gnupg
pass
htop
tree
w3m
zip
unzip
tar
feh
xcape
neofetch
wget
mtpfs
rclone
beep
imagemagick
fdupes
redshift
fprintd
youtube-dl
transmission-cli
pcmanfm
pandoc
python-pip
cairo
sox
r tk
gvfs-mtp
gnumeric
texlive-core
texlive-pictures
texlive-science
stellarium
gimp
inkscape
tipp10
telegram-desktop
arch-install-scripts
)

py_pack=(
numpy
scipy
matplotlib
manimlib
jupyter
)

aur_pack=(
brave-bin
simple-mtpfs
zoom
)


{
    ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
    hwclock --systohc
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
    echo "en_US ISO-8859-1" >> /etc/locale.gen
    locale-gen
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    echo $HOSTNAME > /etc/hostname
    grub-install `cat /disk.txt`
    grub-mkconfig -o /boot/grub/grub.cfg
}


{
    pacman --noconfirm --needed -Sy ${arch_pack[@]}
    pip install ${py_pack[@]}
}


cd /home
id -u $USER >/dev/null 2>&1 ||
{
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
    `ls $USER`
    )

    mv $USER ${USER}-old
    mkdir $USER
    chmod 700 $USER
    mv "${k[@]/#/${USER}-old/}" $USER
    }

    useradd -m -g wheel -s /bin/$SHELL $USER
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
}
cd $USER


{
    [ -d .scripts ] || git clone https://github.com/albertshaji/scripts.git .scripts
    [ -d .arch ] || git clone https://github.com/albertshaji/arch.git .arch
    export PATH="$PATH:/home/$USER/.scripts"
    config.sh
    chown -Rv $USER:wheel /home/$USER

    sed -i "/GRUB_TIMEOUT_STYLE/c\GRUB_TIMEOUT_STYLE=hidden" /etc/default/grub
    sed -i "/GRUB_CMDLINE_LINUX_DEFAULT/c\GRUB_CMDLINE_LINUX_DEFAULT=\"linux /boot/vmlinuz-linux resume=`cat /disk.txt`3 quiet splash\"" /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
    sed -i "/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/c\HOOKS=(base udev autodetect modconf block filesystems keyboard resume fsck)" /etc/mkinitcpio.conf
    mkinitcpio -P

    sudo -u $USER git config --global user.name $USER
    sudo -u $USER git config --global user.email $EMAIL
    sudo -u $USER git config --global credential.helper store

    systemctl enable NetworkManager

    sudo -u ranger --copy-config=scope
}


{
    [ -d .suckless ] &&
    {
    cd .suckless
    for p in `ls`
    do
    make -C $p clean install
    done ||
    sudo -u $USER aur.sh st dwm
    cd ..
    }

    sudo -u $USER aur.sh ${aur_pack[@]}
}


[ `passwd -S | awk '{print $2}'` = 'P' ] ||
{
    echo
    echo "Create password for Root."
    passwd
    echo "Create password for" $USER.
    passwd $USER
    echo
    echo "Remember to run: \"fprintd-enroll\" after login!"
    echo
}

figlet "Installation Completed!"
