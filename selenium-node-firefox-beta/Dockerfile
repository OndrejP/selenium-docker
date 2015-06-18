FROM ondrejp/selenium-base-node
MAINTAINER Ondrej Prochazka <docker@ond.cz>

USER seluser
WORKDIR /home/seluser/

#=========
# Firefox
#=========
RUN wget -q -O firefox.tar.bz2 \
 http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/39.0b1/linux-x86_64/en-US/firefox-39.0b1.tar.bz2 \
 && tar -jxf firefox.tar.bz2 \
 && sudo ln -s /home/seluser/firefox/firefox-bin /usr/bin/firefox

#===============
# Browser detail
#===============
ENV BROWSERDETAIL="-browser browserName=firefox,version=beta,platform=LINUX,maxInstances=1"

#========================
# Selenium Configuration
#========================
COPY config.json /home/seluser/config.json

USER root
RUN chown seluser: \
 /home/seluser/config.json

USER seluser
