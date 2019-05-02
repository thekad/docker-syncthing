#!/bin/sh
set -x

# if this if the first run, generate a config
if [ ! -f /syncthing/config/config.xml ]; then
  echo "generating config"
  /syncthing/syncthing -generate="/syncthing/config"
fi

# expose the web ui outside the container
sed -e "s#<address>.*:.*</address>#<address>0.0.0.0:${SYNCTHING_HTTP_PORT}</address>#" -i /syncthing/config/config.xml

# start syncthing
/syncthing/syncthing -home="/syncthing/config"
