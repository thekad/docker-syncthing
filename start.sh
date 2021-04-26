#!/bin/sh
set -x

# put binary into place
if [ ! -f /syncthing/syncthing ]; then
  echo "unpacking syncthing"
  tar -C /syncthing -xzf /tmp/syncthing-linux-amd64-v${SYNCTHING_VERSION}.tar.gz syncthing-linux-amd64-v${SYNCTHING_VERSION}/syncthing
  cp -pv /syncthing/syncthing-linux-amd64-v${SYNCTHING_VERSION}/syncthing /syncthing/syncthing
fi

# if this if the first run, generate a config
if [ ! -d /syncthing/config ]; then
  echo "generating config"
  mkdir -pv /syncthing/config
  /syncthing/syncthing -generate="/syncthing/config"
fi

# expose the web ui outside the container
sed -e "s#<address>.*:.*</address>#<address>0.0.0.0:${SYNCTHING_HTTP_PORT}</address>#" -i /syncthing/config/config.xml

# start syncthing
/syncthing/syncthing -home="/syncthing/config"
