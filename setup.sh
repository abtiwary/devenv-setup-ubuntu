#!/bin/bash

set -e

home_dir=`realpath ~`
arg_array=( "$@" )

if [[ ${arg_array[@]} =~ "help" ]]; then
    echo "Install one or more dev environment items."
    echo "The options are:"
    echo "  all conda neovim rust golang"
    exit
fi

# install dependencies
export TZ=Australia/Sydney
export DEBIAN_FRONTEND=noninteractive

sudo apt update 
sudo apt install -y apt-transport-https ca-certificates
sudo update-ca-certificates
sudo apt install -y build-essential git clang cmake clang clang-tools libclang-dev clang-tidy cppcheck clang-format valgrind less gdb lldb net-tools traceroute whois curl wget exa
git config --global http.sslVerify "false"
echo insecure >> ${home_dir}/.curlrc

# conda
if [[ ${arg_array[@]} =~ "all" || ${arg_array[@]} =~ "conda" ]]; then
    echo "installing miniconda"
    cd ${home_dir}/Downloads
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod a+rwx Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -b -p ${home_dir}/miniconda3
    bash ${home_dir}/miniconda3/bin/activate
    ${home_dir}/miniconda3/bin/conda install -y -c conda-forge python-kaleido jupyter seaborn numpy matplotlib plotly scipy pymongo toml tomli tomlkit
    source ${home_dir}/miniconda3/bin/activate
fi

# neovim
if [[ ${arg_array[@]} =~ "all" || ${arg_array[@]} =~ "neovim" ]]; then
    echo "installing neovim stable"
    cd ${home_dir}/Downloads
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
    tar -xvzf nvim-linux64.tar.gz
    cd nvim-linux64
    sudo cp -r bin/nvim /usr/local/bin
    sudo cp -r lib/nvim/ /usr/local/lib
    sudo cp -r share/nvim /usr/local/share
    sudo cp -r man/man1/ /usr/local/man
fi

# rust
if [[ ${arg_array[@]} =~ "all" || ${arg_array[@]} =~ "rust" ]]; then
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# todo
