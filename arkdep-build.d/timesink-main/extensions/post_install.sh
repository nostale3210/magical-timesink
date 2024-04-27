#!/usr/bin/env bash

set -oue pipefail

# patch arkdep for use with github releases
sed -i "s/curl -sf /curl -sfL /g" /var/tmp/rootfs/usr/bin/arkdep

# install bibata cursor theme
mkdir -p /var/tmp/rootfs/usr/share/icons
curl -OL https://github.com/ful1e5/Bibata_Cursor/releases/latest/download/Bibata-Modern-Classic.tar.xz
tar -xf Bibata-Modern-Classic.tar.xz --directory /var/tmp/rootfs/usr/share/icons/
rm -rf Bibata-Modern-Classic.tar.xz

# install adw-gtk3
mkdir -p /var/tmp/rootfs/usr/share/themes
curl -OL https://github.com/lassekongo83/adw-gtk3/releases/latest/download/adw-gtk3v5.3.tar.xz
tar -xf adw-gtk3v5.3.tar.xz --directory /var/tmp/rootfs/usr/share/themes/
rm -rf adw-gtk3v5.3.tar.xz

# install statically linked nix
curl -L https://hydra.nixos.org/job/nix/master/buildStatic.x86_64-linux/latest/download-by-type/file/binary-dist > /var/tmp/rootfs/usr/bin/nix
chmod +x /var/tmp/rootfs/usr/bin/nix

# install proot
curl -L https://proot.gitlab.io/proot/bin/proot > /var/tmp/rootfs/usr/bin/proot
chmod +x /var/tmp/rootfs/usr/bin/proot

# enable services
systemctl enable tailscaled.service
systemctl enable ufw.service
ufw enable

ufw default deny incoming
ufw default allow outgoing
