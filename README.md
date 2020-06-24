# Shell Scripts

Casual shell scripts (bash, zsh) to ease day to day interactions with computer, or in other words, make things fast and simple ;-)

## Arch Linux Installation Scripts

- **arch.sh**, The steps from [Arch Linux instalation guide](https://wiki.archlinux.org/index.php/installation_guide) made into a script. Executed in the live boot.

```
curl -LO https://albertshaji.github.io/scripts/arch.sh
sh arch.sh
```

- **arch-user.sh**, Initial part follows the remaining steps from installation guide. Further the script installs user-end packages and configures then using the files from [arch repo](https://github.com/albertshaji/arch). Executed after `arch-chroot` from live boot.

## dog.sh

When you are not using any full desktop environment (like Xfce, GNOME, KDE), alternately employing [suckless](https://suckless.org/) programs like `dwm`, which is just a window manager. So this script bridges the missing pieces from a desktop environment by managing background process like the following:

- `b`, Checks battery status and notifies the user to take necessary action. Hibernates in critical conditions.
- `s`, Display and update *battery*, *cpu*, *ram*, *up-time*, *weather*, *date time* status.
- `t`, Checks temperature and notifies during peaks and runs sleep/wakeup actions to keep the temperature under control.
- `p`, This forces the user to take frequent breaks by periodically sleeping and waking system for a few minutes.

Usage:
```
dog.sh +x/-x  # start/stop "x" process independently.
dog.sh +/-    # start/stop all processes together.
dog.sh -l/ls  # list all running services.
```
## sync.sh

Mange data synchronization between *laptop*, *mobile*, *cloud* using `rclone`.

Usage:
```
sync.sh +M DIRECTORY...  # Laptop to Mobile.
sync.sh +C DIRECTORY...  # Laptop to Cloud.
replace `+` with `-` to reverse the direction of sync.
```
## rname.sh

Bulk rename all the files of a specified directory by a pattern (like 01.png, 02.png, 03.png, ...). Once the names are in sequence, addition and removal of files breach the continuity. This script employs an algorithm that exactly picks up files that are out of sequence and brings it back to the sequence.

Usage:
```
rname.sh ~/pic/ [.EXTENSION]
```

## usb.sh

Mount/Unmount block devices, like Pendrive, Hard disk. One argument "+/-" is passed, specifying "add/remove". The script produces a numbered list of devices and then the user can input his/her selection as a number, or as a space-separated sequence.

## Other Minor Scripts

- **config.sh**, Used to backup and deploy configuration files found in [arch repo](https://github.com/albertshaji/arch)
- **sxiv.sh**, Key handlers for suckless image viewer program. Example, move to trash, rotate, set as wallpaper, etc.
- **aur.sh**, A straightforward script to install and update packages from "Arch User Repository".
- **man.sh**, Similar output as of `man` command, but a filtered/modified list of commands and key bindings. It's a reference document made into a script for modular and interactive usage via `dmenu`.
- **words.sh**, Quickly find word meaning! Integrating `sdcv` dictionary program and words list with `dmenu` interface.
- **speak.sh**, Pronounce the last word searched in the dictionary using `flite`.
- **alarm.sh**, Tiny alarm script using `sleep` delay and `dzen` notification.
- **screenshot.sh**, Take screenshots and manage their names in sequence avoiding conflict.
- **[p/t/b]toggle.sh**, Touchpad State (Enable/Disable), Screen Temperature (Warm/Cold), Screen Brightness (Zero/Average) Respectively.

## Reference

- [LinuxJourney](https://linuxjourney.com/)
- [LukeSmith](https://lukesmith.xyz/)
