Resilio Sync
===============

Sync uses peer-to-peer technology to provide fast, private file sharing for teams and individuals. By skipping the cloud, transfers can be significantly faster because files take the shortest path between devices. Sync does not store your information on servers in the cloud, avoiding cloud privacy concerns.

# Usage

    DATA_FOLDER=/path/to/data/folder/on/the/host
    WEBUI_PORT=[ port to access the webui on the host ]

    mkdir -p $DATA_FOLDER

    docker run -d --name Sync \
      -p 127.0.0.1:$WEBUI_PORT:8888 -p 55555 \
      -v $DATA_FOLDER:/mnt/sync \
      --restart on-failure \
      resilio/sync

Go to localhost:$WEBUI_PORT in a web browser to access the webui.

#### LAN access

If you do not want to limit the access to the webui to localhost, run instead:

    docker run -d --name Sync \
      -p $WEBUI_PORT:8888 -p 55555 \
      -v $DATA_FOLDER:/mnt/sync \
      --restart on-failure \
      resilio/sync

#### Extra directories

If you need to mount extra directories, mount them in /mnt/mounted_folders:

    docker run -d --name Sync \
      -p 127.0.0.1:$WEBUI_PORT:8888 -p 55555 \
      -v $DATA_FOLDER:/mnt/sync \
      -v <OTHER_DIR>:/mnt/mounted_folders/<DIR_NAME> \
      -v <OTHER_DIR2>:/mnt/mounted_folders/<DIR_NAME2> \
      --restart on-failure \
      resilio/sync

Do not create directories at the root of mounted_folders from the Sync webui since this new folder will not be mounted on the host.

# Volume

* /mnt/sync - State files and Sync folders

# Ports

* 8888 - Webui
* 55555 - Listening port for Sync traffic

# Help

Additional info can be found at [help center](https://help.getsync.com).
If you have any questions left, please contact us via [support page](https://help.getsync.com/hc/en-us/requests/new?ticket_form_id=91563).
