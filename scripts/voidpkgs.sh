#!/bin/bash

# Instalar paquetes necesarios
sudo xbps-install -S void-repo-nonfree util-linux bsdtar coreutils binutils libatomic-devel base-devel curl wget linux-firmware-amd dbus polkitd NetworkManager xtools git bat ripgrep fd exa procs helix neovim htop neofetch ntfs-3g p7zip dust fish-shell starship &&
sudo xbps-install -Su &&
