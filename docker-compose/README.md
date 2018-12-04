# Run Resilio Sync via docker-compose on Ubuntu Linux

- Install docker and docker-compose:
```
sudo apt update
sudo apt install docker.io docker-compose
```

- Add your user into `docker` group and then re-login to your account:
```
sudo usermod -aG docker <your_user>
```

- Run Sync:

```
bash deploy.sh up <path_to_data>
```
where `path_to_data` is path to folder to be mounted in container as well as to be whitelisted in webui, for example:

```
bash deploy.sh up /home/user/data
```

- Stop Sync w/o removing its storage volume (`sync_storage`):
```
bash deploy.sh down
```
