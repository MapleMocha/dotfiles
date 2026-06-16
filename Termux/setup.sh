#!/bin/bash
set -eu

mkdir -p $HOME/.termux/

DIR=/data/data/com.termux/files/home/dotfiles/Termux

cat > /data/data/com.termux/files/usr/etc/apt/sources.list << EOF
deb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main
EOF

apt update && yes | apt upgrade

rm ~/files
ln -s /data/data/com.termux/files $HOME
rm -f $HOME/.hushlogin && touch $HOME/.hushlogin
cp $DIR/.files/termux.properties $DIR/.files/colors.properties $HOME/.termux/

apt install -y fish which gh nmap fzf wget curl fd nodejs
apt install -y zoxide tree htop openssh tig bat ripgrep jq yq
apt install -y curl ncdu tmux gdb neofetch proot-distro clang
apt install -y sqlite golang rust php ruby bc ffmpeg nginx chafa
apt install -y python python-pip build-essential cmake ninja gettext
apt install -y libtool autoconf automake doxygen ncurses-utils
apt install -y gperf pkg-config glow lua53 lua52 lua51 nodejs-lts
apt install -y eza pipes.sh cava starship uv luajit lua-lpeg
apt install -y gettext rust-analyzer lua-language-server yazi lld mandoc

chsh -s fish
mkdir -p $HOME/.config/
cp $DIR/.files/starship.toml $HOME/.config/
mkdir -p $HOME/.config/fish/

cat > $HOME/.config/fish/config.fish << EOF
set -g fish_greeting ""
termux-wake-lock
starship init fish | source

# Alias
alias ls 'eza --icons'
alias t 'eza --tree --icons'
alias a 'ls -a'

export BAT_THEME="Catppuccin Mocha"
export EDITOR="nvim"
export VISUAL="nvim"
zoxide init fish | source
export DISPALY=:0
EOF

git config --global init.defaultBranch main
mkdir -p $HOME/.config/bat/themes/
cp $DIR/.files/"Catppuccin Mocha.tmTheme" $HOME/.config/bat/themes/
mv $PREFIX/bin/pipes.sh $PREFIX/bin/pipes && chmod 755 $PREFIX/bin/pipes

cp $DIR.files/font.ttf $DIR.files/font.ttf.bak $HOME/.termux/
cp $DIR.files/swap-font $PREFIX/bin/ && chmod 755 $PREFIX/bin/swap-font

pkill -9 -f com.termux # 😈

