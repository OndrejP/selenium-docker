#!/bin/bash
export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

# Need to define concrete browser details
# BROWSERDETAIL=-browser browserName=firefox,version=24.8,platform=LINUX,maxInstances=1
# BROWSERBIN=-Dwebdriver.firefox.bin=/home/seluser/firefox/firefox-bin
if [ -e /home/seluser/config.sh ] ; then 
  . /home/seluser/config.sh
fi

# TODO: Look into http://www.seleniumhq.org/docs/05_selenium_rc.jsp#browser-side-logs
/usr/bin/Xvfb :99 \
 -screen 0 $GEOMETRY \
 -ac +extension RANDR \
 1>/home/seluser/Xvfb.log \
 2>/home/seluser/Xvfb.error.log  &

DISPLAY=:99 /usr/lib/WindowMaker/wmaker \
 1>/home/seluser/wmaker.log \
 2>/home/seluser/wmaker.error.log &


DISPLAY=:99 java -jar /opt/selenium/selenium-server-standalone.jar \
 -Djava.net.preferIPv4Stack=true \
 -singleWindow -timeout 60 \
 -forcedBrowserMode "*firefox /home/seluser/firefox/firefox-bin" \
 -Dwebdriver.firefox.profile=WebDriver \
 -Dwebdriver.firefox.bin=/home/seleuser/firefox.firefox-bin \
 &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait $NODE_PID

