FROM ondrejp/selenium-base
MAINTAINER Ondrej Prochazka <docker@ond.cz>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

#===================
# Timezone settings
# Possible alternative:
# https://github.com/docker/docker/issues/3359#issuecomment-32150214
#===================
ENV TZ "US/Pacific"
RUN echo "US/Pacific" | sudo tee /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

#========================
# Ignore google-analytics
#========================
RUN echo -e "\n127.0.0.1       www.google-analytics.com google-analytics.com googleads.g.doubleclick.net" >>/etc/hosts \
 && echo -e "\n::1     www.google-analytics.com google-analytics.com" >>/etc/hosts


#==============
# VNC and Xvfb
#==============
RUN apt-get update -qqy \
  && apt-get -qqy install \
 xvfb \
 wmaker \
 libasound2 \
 libatk1.0-0 \
 libc6 \
 libcairo2 \
 libdbus-1-3 \
 libdbus-glib-1-2 \
 libfontconfig1 \  
 libfreetype6 \  
 libgcc1 \
 libgdk-pixbuf2.0-0 \
 libglib2.0-0 \
 libgtk2.0-0 \ 
 libpango-1.0-0 \
 libpangocairo-1.0-0 \
 libstartup-notification0 \
 libstdc++6 \
 libx11-6 \  
 libxext6 \
 libxrender1 \
 libxt6 \
  && rm -rf /var/lib/apt/lists/*

#==============================
# Scripts to run Selenium Node
#==============================
COPY entry_point.sh /selen-node
RUN chmod +x /selen-node

#============================
# Some configuration options
#============================
ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :0

USER seluser

CMD ["/selen-node"]
