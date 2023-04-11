#!/bin/bash

# Crear directorios personales
mkdir -p  ~/{.themes,usr/{share/{fonts,lib,env,scripts},bin,local,var,opt,etc,mnt,media,tmp}} && mkdir -p ~/usr/local/Suckless &&

# Obtener archivos de red
cd ~; 
git clone https://github.com/OccultArcanne/st.git ~/usr/local/Suckless/st && git clone https://github.com/OccultArcanne/void-packages.git ~/usr/local/void-packages && git clone https://github.com/vlang/v ~/usr/local/v && git clone https://github.com/uditkarode/libxft-bgra ~/usr/share/lib/libxft-bgra && git clone https://github.com/OccultArcanne/chadwm.git --depth 1  ~/.config/chadwm &&
cd ~/usr/share/fonts; 
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip && wget https://www.wfonts.com/download/data/2016/04/23/symbola/symbola.zip &&
cd ~/.themes; wget https://github.com/catppuccin/gtk/releases/download/v0.4.1/Catppuccin-Latte-Standard-Sapphire-Light.zip && wget https://github.com/catppuccin/gtk/releases/download/v0.4.1/Catppuccin-Mocha-Standard-Sapphire-Dark.zip &&
cd ~/usr/opt; wget https://github.com/Kron4ek/Conty/releases/download/1.21.11/conty.sh && chmod +x conty.sh && wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.1.16/Obsidian-1.1.16.AppImage && chmod a+x Obsidian-1.1.16.AppImage &&
ln -sf ~/usr/opt/conty.sh /usr/bin/conty && ln -sf ~/usr/opt/Obsidian-1.1.16.AppImage ~/usr/bin/Obsidian &&
cd ~; curl -o Xresources https://raw.githubusercontent.com/catppuccin/xresources/main/mocha.Xresources && mv Xresources .Xresources &&

# Actualizar configuraciones si no he creado un repositorio para las mdificaciones a incluir
mkdir -p ~/usr/share/wall;
rsync -avhu --progress ~/distfiles/wall ~/usr/share/wall && rsync -avhu --progress ~/distfiles/env ~/usr/share/env &&
mv ~/usr/share/env/bashrc ~/.bashrc
