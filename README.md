# Neovim

A repository with a simple `install.sh` script to setup oh-my-zsh and neovim on rocky linux using lazy as the plugin manager.

## Setup

Clone the repo:

```bash
dnf install -y git
git clone git@github.com:Jeff-Rowell/neovim.git
```

Run the script:
```bash
cd neovim
./install.sh
```

## Supported Plugins

Currently these are the plugins I use:
- telescope
- undotree
- treesitter
- fugitive
- lsp (python, gopls, tailwindcss)
- colorschemes
    * rose-vine
    * tokyo-night
    * gruvbox
- vim-be-good

