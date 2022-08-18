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

# Oh-My-Zsh
RUN apt-get install zsh -y
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
RUN cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
RUN chsh -s $(which zsh)
# CUSTOMIZE ZSH
RUN git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/themes/powerlevel9k
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel9k\/powerlevel9k"/g' ~/.zshrc
RUN echo 'export TERM="xterm-256color"' | cat - ~/.zshrc > /tmp/out && mv /tmp/out ~/.zshrc

# starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes
RUN echo '' >> $HOME/.bashrc
RUN echo '# Start the starship prompt.' >> $HOME/.bashrc
RUN echo 'eval "$(starship init bash)"' >> $HOME/.bashrc
RUN echo 'eval "$(starship init zsh)"'  >> $HOME/.zshrc

# nala
RUN echo "deb https://deb.volian.org/volian/ scar main" | tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
RUN wget -qO - https://deb.volian.org/volian/scar.key | tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
RUN apt-get update && apt-get install --yes nala

# bat
RUN ln -s /usr/bin/batcat /usr/bin/bat

# Add user script
RUN mkdir -p ~/.local/bin
COPY init_user.sh ~/.local/bin

# Chad
COPY chad.bf /var/local/chad.bf
COPY chadify.bash /var/local/chadify.bash
RUN echo 'bash /var/local/chadify.bash' >> $HOME/.bashrc
RUN echo 'bash /var/local/chadify.bash'  >> $HOME/.zshrc
RUN apt-get install --yes bf

