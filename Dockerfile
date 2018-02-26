FROM ubuntu:16.04


RUN apt-get update -q && apt-get install -y --no-install-recommends \
  sudo \
  gcc \
  g++ \
  make \
  tmux \
  wget \
  software-properties-common \
  vim \ 
  vim-gnome \
  libnotify4 \
  libnss3 \
  libxtst6 \
  libxss1 \
  libsecret-1-0 \
  libxkbfile1 \
  libx11-xcb1

ENV VSCODE_VERSION 1.20.1
RUN wget -O /tmp/vscode.deb https://vscode-update.azurewebsites.net/$VSCODE_VERSION/linux-deb-x64/stable/
RUN dpkg -i /tmp/vscode.deb && rm /tmp/vscode.deb

RUN groupadd -g 1000 developer && useradd -u 1000 -g 1000 developer
RUN echo "developer:developer" | chpasswd 
RUN adduser developer sudo 
RUN mkdir /home/developer
RUN chown developer /home/developer

USER developer 
RUN echo 0 | code --install-extension ms-vscode.cpptools

USER root
ENV PROXYGEN_VERSION 2018.02.26.00
ADD https://github.com/facebook/proxygen/archive/v$PROXYGEN_VERSION.tar.gz /opt
RUN cd /opt && tar -zxpvf v$PROXYGEN_VERSION.tar.gz && cd /opt/proxygen-$PROXYGEN_VERSION/proxygen && ./deps.sh && ./reinstall.sh

USER developer


