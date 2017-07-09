FROM haskell:8.0

MAINTAINER Juji <him@jujiyangasli.com>

# install latex packages
RUN apt-get update -y \
  && apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
    texlive-latex-base \
    texlive-xetex latex-xcolor \
    texlive-math-extra \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-bibtex-extra \
    fontconfig \
    lmodern \
    curl \
    fonts-liberation

# install ms corefonts
# RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
# RUN apt-get install -y ttf-mscorefonts-installer

# will ease up the update process
# updating this env variable will trigger the automatic build of the Docker image
ENV PANDOC_VERSION "1.19.2.1"
ENV NODE_MAJOR_VERSION "6"

# install pandoc
RUN cabal update && cabal install pandoc-${PANDOC_VERSION}

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_${NODE_MAJOR_VERSION}.x | bash -
RUN apt-get install -y nodejs
