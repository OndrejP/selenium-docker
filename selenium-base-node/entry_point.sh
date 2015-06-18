#!/bin/bash
export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

if [ ! -e /home/seluser/config.json ]; then
  echo No Selenium Node configuration file, the node-base image is not intended to be run directly. 1>&2
  exit 1
fi

if [ -z "$HUB_PORT_4444_TCP_ADDR" ]; then
  echo Not linked with a running Hub container 1>&2
  exit 1
fi

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
 -role node \
 -hub http://$HUB_PORT_4444_TCP_ADDR:$HUB_PORT_4444_TCP_PORT/grid/register \
 ${BROWSERDETAIL} \
 ${BROWSERBIN} \
 -nodeConfig /home/seluser/config.json &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait $NODE_PID

