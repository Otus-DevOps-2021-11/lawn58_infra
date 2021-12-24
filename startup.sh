#!/bin/bash

# установка yc CLI
curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
source /home/$USER/.bashrc
#exec -l $SHELL

# инициализация профиля
yc init
yc config profile list

#---------------------------------------------------------------

yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=./metadata.yml
