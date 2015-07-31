# sync-docker

Dockerfile for BitTorrent Sync

## Volume

### /mnt/sync

State files and Sync folders

## Ports

### 8888

Webui

### 55555

Listening port for Sync traffic

## Usage

		$ DATA_FOLDER=<folder where Sync folders will be on the host>
		$ WEBUI_PORT=<port of the webui on the host>

		$ mkdir $DATA_FOLDER

		$ docker run -d --name Sync \
			  -p 127.0.0.1:$WEBUI_PORT:8888 -p 55555 \
			  -v $DATA_FOLDER:/mnt/sync \
			  --restart on-failure \
			  bittorrent/sync

Go to http://localhost:$WEBUI_PORT to access the webui.
