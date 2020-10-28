#
# Experiment environment set-up Dockerfile.
# Ubuntu + Vim + MySQL-server.
#

# Pull base image.
FROM ubuntu:20.04

# Speeding download with resort of aliyun mirrors.
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse\ndeb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse\ndeb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse\ndeb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse\ndeb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse\ndeb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse\ndeb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse\ndeb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse\ndeb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse\ndeb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" > /etc/apt/sources.list

# Install applications.
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common  && \
  apt-get install -y sudo curl git htop man unzip wget cmake gdb zsh tmux global vim

# # vim 8.2
# RUN add-apt-repository ppa:jonathonf/vim && \
#   apt-get update && \
#   apt-get install -y vim

# Add user, do not use root user directly.
RUN useradd --create-home --no-log-init --shell /bin/zsh shen && \
    adduser shen sudo && \
    echo 'shen:abc123' | chpasswd

# Swith to my user.
USER shen

# Set environment variables.
ENV HOME /home/shen

# Define working directory.
WORKDIR /home/shen

# Install vim-plug and clone my vimrc
RUN git clone https://github.com/junegunn/vim-plug.git && \
  mkdir -p ~/.vim/autoload && \
  mv ~/vim-plug/plug.vim ~/.vim/autoload/plug.vim && \
  rm -rf ~/vim-plug && \
  git clone https://github.com/shenyunlong/dot-file && \
  ln -s ~/dot-file/.vimrc ~/.vimrc && \
  ln -s ~/dot-file/.tmux.conf ~/.tmux.conf

# Install oh-my-zsh
RUN wget https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
# Download mysql-8.0.21
RUN wget https://dev.mysql.com/get/Downloads/MySQL-7.0/mysql-8.0.21.tar.gz && \
  tar -zxvf mysql-8.0.21.tar.gz


# Add files.
# ADD root/.bashrc /root/.bashrc
# ADD root/.gitconfig /root/.gitconfig
# ADD root/.scripts /root/.scripts
