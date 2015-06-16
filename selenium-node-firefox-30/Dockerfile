FROM ondrejp/selenium-base-node
MAINTAINER Ondrej Prochazka <docker@ond.cz>

USER seluser
WORKDIR /home/seluser/

#=========
# Firefox
#=========
RUN wget -q -O firefox.tar.bz2 \
 http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/30.0b9/linux-x86_64/en-US/firefox-30.0b9.tar.bz2 \
 && tar -jxf firefox.tar.bz2

#========================
# Selenium Configuration
#========================
COPY config.json /home/seluser/config.json
COPY config.sh /home/seluser/config.sh

USER root
RUN chown seluser: \
 /home/seluser/config.json \
 /home/seluser/config.sh

USER seluser
