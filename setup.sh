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
sudo apt install -y build-essential git clang cmake clang clang-tools libclang-dev clang-tidy cppcheck clang-format valgrind less gdb lldb net-tools traceroute whois curl wget
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
fi


# todo


