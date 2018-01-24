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


ENV VSCODE_VERSION 1.19.2
RUN wget -O /tmp/vscode.deb https://vscode-update.azurewebsites.net/$VSCODE_VERSION/linux-deb-x64/stable/
RUN dpkg -i /tmp/vscode.deb && rm /tmp/vscode.deb

RUN adduser developer
USER developer 
RUN echo 0 | code --install-extension ms-vscode.cpptools

USER root
ENV PROXYGEN_VERSION 2018.01.22.00
ADD proxygen-$PROXYGEN_VERSION.tar.gz /opt
RUN cd /opt/proxygen-$PROXYGEN_VERSION/proxygen && ./deps.sh && ./reinstall.sh

USER developer


