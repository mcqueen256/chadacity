FROM ubuntu:latest

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Australia/Brisbane apt-get -y install tzdata
RUN apt-get install --yes \
    bat \
    build-essential \
    curl \
    exa \
    sudo \
    wget \
    zsh

# git
RUN apt-get install --yes git vim
RUN git config --global url.https://github.com/.insteadOf git://github.com/
RUN git config --global core.editor "vim"

# fonts
RUN apt-get install locales
RUN locale-gen "en_US.UTF-8"
RUN LC_ALL=en_US.UTF-8
RUN LANG=en_US.UTF-8
RUN git clone https://github.com/powerline/fonts.git --depth=1
RUN sh fonts/install.sh
RUN rm -rf fonts

# nala
RUN echo "deb https://deb.volian.org/volian/ scar main" | tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
RUN wget -qO - https://deb.volian.org/volian/scar.key | tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
RUN apt-get update && apt-get install --yes nala

# bat
RUN ln -s /usr/bin/batcat /usr/bin/bat

# Add user script
RUN mkdir -p /root/.local/bin
COPY util/init_user.sh /root/.local/bin
COPY util/create_user_ubuntu.22.04.sh /root/.local/bin

# Chad
COPY chad.bf /var/local/chad.bf
COPY chadify.bash /var/local/chadify.bash
RUN echo 'bash /var/local/chadify.bash' >> $HOME/.bashrc
RUN echo 'bash /var/local/chadify.bash'  >> $HOME/.zshrc
RUN apt-get install --yes bf

# Install Starship.rs for the root user
RUN mkdir -p /root/bin
RUN curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir $HOME/bin --yes > /dev/null

RUN sh /root/.local/bin/create_user_ubuntu.22.04.sh dev
USER dev
# USER is not defined by default.
ENV USER=dev
WORKDIR /home/dev/
RUN mkdir -p /home/dev/Development/chadacity
COPY . /home/dev/Development/chadacity
# Before this point ~/.zshrc does not exist
RUN echo 'export SHELL=$(which zsh)' > /home/dev/.zshrc
RUN SHELL=$(which zsh) zsh /home/dev/Development/chadacity/setup_ubuntu.22.04.zsh
RUN rm -rf ~/Development

ENTRYPOINT zsh