#!/bin/bash

##########################################################################################################################
# Install dnf required packages
##########################################################################################################################
sudo dnf install -y epel-release
sudo dnf install -y git zsh util-linux-user tar ripgrep gcc gcc-c++ make unzip readline-devel wget tmux
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

git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git $HOME/.local/share/nvim/lazy/lazy.nvim
mkdir -p $HOME/.config/nvim/
cp -r nvim $HOME/.config/

curl -O --output-dir /opt/ https://www.lua.org/ftp/lua-5.1.5.tar.gz
sudo tar xzvf -C /opt/ /opt/lua-5.1.5.tar.gz
cd /opt/lua-5.1.5/
sudo make linux
sudo make install

##########################################################################################################################
# Install gopls
##########################################################################################################################
curl -O --output-dir /opt/ https://dl.google.com/go/go1.25.3.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local/ -xzf /opt/go1.25.3.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin:/usr/local/bin' >> $HOME/.zshrc
echo "bindkey '^U' backward-kill-line" >> $HOME/.zshrc
rm -f /opt/go1.25.3.linux-amd64.tar.gz
go version

##########################################################################################################################
# Install npm
##########################################################################################################################
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 24

