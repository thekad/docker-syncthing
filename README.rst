.. image:: https://img.shields.io/github/tag/thekad/docker-syncthing
   :alt: Github release
   :target: https://github.com/thekad/docker-syncthing/releases

.. image:: https://img.shields.io/docker/build/thekad/syncthing
   :alt: Docker build status
   :target: https://hub.docker.com/r/thekad/syncthing

.. image:: https://quay.io/repository/thekad/syncthing/status
   :alt: Quay build status
   :target: https://quay.io/repository/thekad/syncthing

Easy File Sharing 
-----------------

Just a simple `Syncthing <https://syncthing.net>_` file sharing solution


Running
=======

An ephemeral container with web UI listening on standard port 8384::

    docker run --publish localhost:8384:8384 docker.io/thekad/syncthing:latest

An ephemeral container listening on a different port::

    docker run --publish localhost:8080:8384 docker.io/thekad/syncthing:latest

A container with persistent config/data::

    docker run --publish localhost:8384:8384 --volume /etc/syncthing:/syncthing/config:rw --volume /var/lib/syncthing:/syncthing/Data:rw docker.io/thekad/syncthing:latest

Syncthing by default runs as the syncthing user inside the container, if you
want your data to be owned by someone different you'll need to pass the --user
option (combine with the above volume example to persist your data)::

    docker run --publish localhost:8384:8384 --user=`id -u` docker.io/thekad/syncthing:latest


Remarks
=======

* Syncthing's web UI has no authentication, CHANGE RIGHT AWAY
* In all cases, if the configuration doesn't exist, a simple configuration will
  be created

