# goresteasy (Vim, Go, Git, Ubuntu)
#
# VERSION 1.0.0
#
# Build image example:
#   docker build -t goresteasy:1.0.0 .
#
# This Dockerfile is used to build a base development environment with vim, go,
# and git all running on Ubuntu 18.10 base image.
#
# Using the Ubuntu Linux 18.10 image, we will add the following:
#   vim,  go, and git.
#
# At the time of this creation, we have the following versions:
#   Vim => 8.1, Go => 1.11.1, Git => 2.19.1
#   Ubuntu => 18.10
#
# Running a container example:
#   docker run -it --name=goresteasy --hostname=godev --rm [image-id-here]
#   **Note: the --rm flag is optional.  It will remove the container on exit.
# -------------------------------------------------------------------
FROM ubuntu:18.10
MAINTAINER John F. Hogarty <hogihung@gmail.com>

# Create the development and directores for cloudmeta-server
RUN mkdir -p /usr/local/development/go/src/github.com/hogihung

# Change our working directory
WORKDIR /usr/local/development/go

# Update and install all of the required packages.
RUN apt-get update -y && \
    apt-get install -y curl htop tar tree wget && \
    apt-get install -y software-properties-common dos2unix

# Update Ubuntu, Install Vim, and Git
RUN add-apt-repository -y ppa:jonathonf/vim && \
    apt-get update -y && \
    apt-get install -y vim git-core

#  DO I NEED?
# RUN apt-get install -y build-essential libssl-dev libreadline-dev \
#     libncurses5 libncurses5-dev zlib1g-dev m4 wx-common libwxgtk3.0-dev \
#     libsctp1 autoconf

# INSTALL GO
RUN cd /tmp && \
    wget https://dl.google.com/go/go1.12.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.12.4.linux-amd64.tar.gz

RUN echo "" >> /root/.bashrc && \
    echo "# Go Support" >> /root/.bashrc && \
    echo "export PATH=\$PATH:/usr/local/go/bin" >> /root/.bashrc && \
    echo "export GOPATH=$HOME/Documents/PROGRAMMING/golang" >> /root/.bashrc

# Add .bashrc.local file with aliases to address RVM and Elixir conflict due to PATH
RUN touch $HOME/.bashrc.local && \
    echo "" >> $HOME/.bashrc && \
    echo "# Pull in aliases and other settings from bashrc.local file" >> $HOME/.bashrc && \
    echo "source $HOME/.bashrc.local" >> $HOME/.bashrc

# Customize vim based off of repo: https://github.com/hogihung/docker-vim-demo
RUN cd /root && \
    git clone https://github.com/hogihung/rest_easy_go.git /usr/local/development/go/src/github.com/hogihung/rest_easy_go && \
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
    git clone https://github.com/lifepillar/vim-solarized8.git ~/.vim/pack/themes/opt/solarized8 

COPY dot_vimrc /root/.vimrc

RUN dos2unix /root/.vimrc && \
    vim +PluginInstall +qall

# Login shell by default so rvm is sourced automatically and 'rvm use' can be used
ENTRYPOINT /bin/bash -l



