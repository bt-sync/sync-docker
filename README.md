# Resilio Sync

<https://www.resilio.com>

Sync uses peer-to-peer technology to provide fast, private file sharing for teams and individuals. By skipping the cloud, transfers can be significantly faster because files take the shortest path between devices. Sync does not store your information on servers in the cloud, avoiding cloud privacy concerns.

## Usage

```bash
# path to folder on the host to be mounted to container as Sync storage folder
DATA_FOLDER=/path/to/data/folder/on/the/host
mkdir -p $DATA_FOLDER

# port to access the webui on the host
WEBUI_PORT=8888

# ensure you have the latest image locally
docker pull resilio/sync

# run container from downloaded image
docker run -d --name Sync \
           -p 127.0.0.1:$WEBUI_PORT:8888 \
           -p 55555/tcp \
           -p 55555/udp \
           -v $DATA_FOLDER:/mnt/sync \
           -v /etc/localtime:/etc/localtime:ro \
           --restart always \
           resilio/sync
```

Note 1: we need to mount `/etc/localtime` from host OS to container to ensure container's time is synced with the host's time.

Note 2: you can use our official Docker image `resilio/sync` hosted on <https://hub.docker.com/u/resilio> or build image manually:

```bash
git clone git@github.com:bt-sync/sync-docker.git
cd sync-docker
docker build -t resilio/sync .
```

Be sure to always run docker container with `--restart` parameter to allow Docker daemon to handle Sync container (launch at startup as well as restart it in case of failure).

Go to `http://localhost:$WEBUI_PORT` in a web browser to access the web UI.

If you need to run Sync under specific user inside your container - use `--user` [parameter](https://docs.docker.com/engine/reference/run/#user) or [set](https://www.linuxserver.io/docs/puid-pgid/) `PUID` and `PGID` env vars for container.

Running Sync in docker container via [docker-compose](https://docs.docker.com/compose/) is described [here](https://github.com/bt-sync/sync-docker/tree/master/docker-compose).

## Volumes

- `/mnt/sync` - folder inside the container that contains the [storage folder](https://help.resilio.com/hc/en-us/articles/206664690-Sync-Storage-folder), [configuration file](https://help.resilio.com/hc/en-us/articles/206178884) and default download folder

- `/etc/localtime` - file (symlink) that [configures](https://unix.stackexchange.com/questions/85925/how-can-i-examine-the-contents-of-etc-localtime) the system-wide timezone of the local system that is used by applications for presentation to the user

## Ports

- `8888` - Webui port
- `55555` - Listening port (both TCP and UDP) for Sync traffic (you can change it, but in this case change it in Sync [settings](https://help.resilio.com/hc/en-us/articles/204762669-Sync-Preferences) as well)

Find more info [here](https://help.resilio.com/hc/en-us/articles/204754759-What-ports-and-protocols-are-used-by-Sync-) about ports used by Sync.

### LAN access

If you do not want to limit the access to the webui - do not specify `localhost` address in `-p` parameter,
in this case every person in your LAN will be able to access web UI via `http://<your_ip_address>:<WEBUI_PORT>`:

```bash
WEBUI_PORT=8888

docker run -d --name Sync \
           -p $WEBUI_PORT:8888 \
           -p 55555/tcp \
           -p 55555/udp \
           -v $DATA_FOLDER:/mnt/sync \
           -v /etc/localtime:/etc/localtime:ro \
           --restart always \
           resilio/sync
```

You can also force web UI to work over https instead of http. To do this you need to add `force_https` parameter in
config file in `webui` section with `true` value. More info about config file parameters is [here](https://help.resilio.com/hc/en-us/articles/206178884-Running-Sync-in-configuration-mode).

### Extra directories

If you need to mount extra directories, mount them in `/mnt/mounted_folders`:

```bash
OTHER_DIR=/path/to/some/dir/on/host
OTHER_DIR2=/path/to/some/another/dir/on/host

docker run -d --name Sync \
           -p 127.0.0.1:$WEBUI_PORT:8888 \
           -p 55555/tcp \
           -p 55555/udp \
           -v $DATA_FOLDER:/mnt/sync \
           -v $OTHER_DIR:/mnt/mounted_folders/DIR_NAME \
           -v $OTHER_DIR2:/mnt/mounted_folders/DIR_NAME2 \
           -v /etc/localtime:/etc/localtime:ro \
           --restart always \
           resilio/sync
```

Note: do not create directories at the root of `/mnt/mounted_folders` from the Sync web UI since they will not be mounted to the host. You need to mount those first as described above and then add them in Sync via web UI.

## Miscellaneous

- Additional info and various Sync guides can be found in our [help center](https://help.resilio.com)
- If you have any questions left, please contact us via [support page](https://help.resilio.com/hc/en-us/requests/new?ticket_form_id=91563) or visit our forum at [https://forum.resilio.com](https://forum.resilio.com)
- Read our [official blog](https://www.resilio.com/blog/)
- Docker [hub](https://hub.docker.com/r/resilio/sync/)
- Discover our [other products](https://www.resilio.com/sync-vs-connect/)
- Learn [legal information](https://www.resilio.com/legal/privacy/)
- If you found some security vulnerability in our product - please follow [this article](https://help.resilio.com/hc/en-us/articles/360000294599-How-to-Report-Security-Vulnerabilities-to-Resilio-Inc-)
