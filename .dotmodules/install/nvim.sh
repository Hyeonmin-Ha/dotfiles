#!/bin/zsh

pprint() {
  printf "%*s\n" $(( (${#1} + $(tput cols) * 2 / 3) / 2 )) "$1"
}

installing() {
  pprint "#################################################"
  pprint "Installing $1"
  pprint "#################################################"
}

installing "neovim"
cd /tmp
NVIM_NAME="nvim-linux-x86_64"
curl -LO https://github.com/neovim/neovim-releases/releases/download/v0.11.3/$NVIM_NAME.tar.gz
#curl -LO https://github.com/neovim/neovim/releases/download/nightly/$NVIM_NAME.tar.gz
tar xzvf $NVIM_NAME.tar.gz
mkdir -p ~/.local
rsync -a $NVIM_NAME/* ~/.local/

installing "vim-plug"
sh -c 'curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

installing "vim plugins"
~/.local/bin/nvim -E -s -u ~/.config/nvim/init.vim +PlugInstall +qall!
