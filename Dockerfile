FROM ubuntu:20.04

SHELL ["/bin/bash", "--login", "-c"]

# Set up my non-root user
ARG username=jordan
ARG uid=1000
ARG gid=100

ENV USER $username
ENV UID $uid
ENV GID $gid
ENV HOME /home/$USER

RUN adduser --disabled-password \
    --gecos "Non-root user" \
    --uid $UID \
    --gid $GID \
    --home $HOME \
    $USER

ENV LANG en_US.utf8

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
RUN apt update

RUN apt install -y git \
                curl \
                screen \
                vim \
                mkalias \
                zip \
                unzip



# USER $USER

ENV MINICONDA_VERSION 4.9.2
ENV CONDA_DIR $HOME/Miniconda3


# Install conda and my environment(s)
RUN curl https://repo.anaconda.com/miniconda/Miniconda3-py39_$MINICONDA_VERSION-Linux-x86_64.sh > ~/miniconda.sh && \
    chmod +x ~/miniconda.sh && ~/miniconda.sh -b -p $CONDA_DIR && rm ~/miniconda.sh

ENV PATH $CONDA_DIR:$PATH

RUN echo ". $CONDA_DIR/etc/profile.d/conda.sh" >> ~/.profile
RUN conda init bash

# Install nvm/npm/node
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
RUN export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm install node
# RUN nvm install node

# Install docker CLI, such that my container can access the host system's docker daemon
ENV DOCKERVERSION=20.10.5
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz

CMD ["sleep", "inf"]