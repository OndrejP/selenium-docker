#!/bin/bash
export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

# TODO: Look into http://www.seleniumhq.org/docs/05_selenium_rc.jsp#browser-side-logs
/usr/bin/Xvfb \
 -screen 0 $GEOMETRY \
 -ac +extension RANDR \
 1>/home/seluser/Xvfb.log \
 2>/home/seluser/Xvfb.error.log  &

/usr/lib/WindowMaker/wmaker \
 1>/home/seluser/wmaker.log \
 2>/home/seluser/wmaker.error.log &


java -jar /opt/selenium/selenium-server-standalone.jar \
 -Djava.net.preferIPv4Stack=true \
 -singleWindow -timeout 60 \
 &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait $NODE_PID

