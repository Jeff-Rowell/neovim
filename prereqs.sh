#!/bin/bash

#########################################################################################################
# Install dnf required packages
#########################################################################################################
sudo dnf install -y epel-release 
sudo dnf install -y neovim git zsh util-linux-user tar
sudo dnf update -y

#########################################################################################################
# Install ohmyzsh
#########################################################################################################
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

#########################################################################################################
# Install powerlevel10k theme
#########################################################################################################
git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/themes/powerlevel10k

#########################################################################################################
# Configure zsh
#########################################################################################################
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
sed -i 's/# COMPLETION_WAITING_DOTS="true"/COMPLETION_WAITING_DOTS="true"/g' ~/.zshrc
cp .p10k.zsh ~
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
echo 'alias vi=nvim' >> ~/.zshrc
echo 'alias vim=nvim' >> ~/.zshrc

