#!/bin/bash

##########################################################################################################################
# Install dnf required packages
##########################################################################################################################
sudo dnf install -y epel-release 
sudo dnf install -y git zsh util-linux-user tar ripgrep gcc gcc-c++ make
sudo dnf update -y

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
# Install powerlevel10k theme
##########################################################################################################################
git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/themes/powerlevel10k

##########################################################################################################################
# Install zsh plugins
##########################################################################################################################
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting

##########################################################################################################################
# Configure zsh and nvim
##########################################################################################################################
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
sed -i 's/# COMPLETION_WAITING_DOTS="true"/COMPLETION_WAITING_DOTS="true"/g' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

cp .p10k.zsh ~
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
echo 'alias vi=nvim' >> ~/.zshrc
echo 'alias vim=nvim' >> ~/.zshrc

git clone --depth 1 https://github.com/wbthomason/packer.nvim $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim

mkdir -p $HOME/.config/nvim/
cp -r nvim $HOME/.config/


