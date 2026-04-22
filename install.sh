#!/bin/bash

##########################################################################################################################
# Install apt required packages
##########################################################################################################################
sudo apt update
sudo apt install -y git zsh tar ripgrep gcc g++ make unzip libreadline-dev wget tmux fzf curl
sudo apt upgrade -y

curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage --appimage-extract
sudo mv squashfs-root /opt/nvim
sudo ln -s /opt/nvim/AppRun /bin/nvim
rm -rf nvim-linux-x86_64.appimage squashfs-root


##########################################################################################################################
# Install ohmyzsh
##########################################################################################################################
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
chsh -s $(which zsh)

##########################################################################################################################
# Install zsh plugins
##########################################################################################################################
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting

##########################################################################################################################
# Configure nvim
##########################################################################################################################
git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git $HOME/.local/share/nvim/lazy/lazy.nvim
mkdir -p $HOME/.config/nvim/
cp -r nvim $HOME/.config/

curl -O --output-dir /opt/ https://www.lua.org/ftp/lua-5.1.5.tar.gz
sudo tar -xzvf /opt/lua-5.1.5.tar.gz -C /opt/
cd /opt/lua-5.1.5/
sudo make linux
sudo make install

##########################################################################################################################
# Install and configure tmux sessionizer
##########################################################################################################################
sudo curl -O --output-dir /usr/local/bin https://raw.githubusercontent.com/ThePrimeagen/tmux-sessionizer/refs/heads/master/tmux-sessionizer
chmod +x /usr/local/bin/tmux-sessionizer

mkdir $HOME/.config/tmux-sessionizer
cp -r tmux-sessionizer.conf $HOME/.config/tmux-sessionizer

##########################################################################################################################
# Install opencode
##########################################################################################################################
curl -fsSL https://opencode.ai/install | bash

##########################################################################################################################
# Install Ghostty terminfo
##########################################################################################################################
tic -x dotfiles/xterm-ghostty.terminfo

##########################################################################################################################
# Deploy dotfiles
##########################################################################################################################
cp dotfiles/.tmux.conf $HOME/.tmux.conf
cp dotfiles/.oh-my-zsh/themes/robbyrussell.zsh-theme $HOME/.oh-my-zsh/themes/robbyrussell.zsh-theme
cp dotfiles/.zshrc $HOME/.zshrc
