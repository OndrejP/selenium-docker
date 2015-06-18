FROM ondrejp/selenium-node-firefox
MAINTAINER Ondrej Prochazka <docker@ond.cz>

USER root

#=====
# VNC
#=====
RUN apt-get update -qqy \
  && apt-get -qqy install \
    x11vnc \
  && rm -rf /var/lib/apt/lists/*

#=================
# Locale settings
#=================
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8 \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    language-pack-en \
  && rm -rf /var/lib/apt/lists/*

#=======
# Fonts
#=======
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable \
  && rm -rf /var/lib/apt/lists/*

#===============
# Browser detail
#===============
ENV BROWSERDETAIL="-browser browserName=firefox,version=debug,platform=LINUX,maxInstances=1"

#==============================
# Scripts to run Selenium Node
#==============================
COPY entry_point.sh /selen-node-debug
RUN chmod +x /selen-node-debug

USER seluser

EXPOSE 5900

CMD /selen-node-debug