#!/usr/bin/env bash

set -oue pipefail

sed -i "s/Required DatabaseOptional/Never/g" /etc/pacman.conf
sed -i '72 i [arkane]' /etc/pacman.conf
sed -i '73 i Server = https://repo.arkanelinux.org/$repo/os/$arch' /etc/pacman.conf
sed -i '74 i [arkane-cauldron]' /etc/pacman.conf
sed -i '75 i Server = https://repo.arkanelinux.org/$repo/os/$arch' /etc/pacman.conf

pacman-key --init
pacman -Sy --noconfirm archlinux-keyring
pacman -S --noconfirm base base-devel arch-install-scripts device-mapper arkane-keyring arkdep

sed -i "s/31457280/3/g" /usr/bin/arkdep-build
sed -i "s/20971520/3/g" /usr/bin/arkdep-build
sed -i "s/15G/5G/g" /usr/bin/arkdep-build

arkdep-build timesink-$1

cp target/*.zst ./

checksum=($(sha1sum ./*.tar.*))
file=$(basename $(ls ./*.tar.*))
compress=${file##*.}
id=${file%%.*}
echo "$id:$compress:${checksum[0]}" > database

echo "$file" > file_name
