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

arkdep-build timesink-${{ matrix.image }}

cp target/*.zst ./

checksum=($(sha1sum ./*.tar.*))
file=$(basename $(ls ./*.tar.*))
compress=${file##*.}
id=${file%%.*}
echo "$id:$compress:${checksum[0]}" > database

echo "$file" > file_name
