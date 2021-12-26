#!/bin/bash

echo "enter service account name"
read SVC_ACCT
echo "ented your folder id on yandex-cloud"
read FOLDER_ID

yc iam service-account create --name $SVC_ACCT --folder-id $FOLDER_ID

ACCT_ID=$(yc iam service-account get $SVC_ACCT | \
grep ^id | \
awk '{print $2}')

yc resource-manager folder add-access-binding --id $FOLDER_ID \
--role editor \
--service-account-id $ACCT_ID

yc iam key create --service-account-id $ACCT_ID --output ./key.json

cat  > immutable.json  << EOF

{
    "builders": [
        {
            "type": "yandex",
            "service_account_key_file": "key.json",
            "folder_id": "hello_dude",
            "source_image_family": "ubuntu-1604-lts",
            "image_name": "reddit-base-{{timestamp}}",
            "image_family": "reddit-full",
            "ssh_username": "ubuntu",
            "use_ipv4_nat": "true",
            "platform_id": "standard-v1"
        }
    ],
    "provisioners": [
        {
            "type": "shell",
            "script": "scripts/install_ruby.sh",
            "execute_command": "sudo {{.Path}}"
        },
        {
            "type": "shell",
            "script": "scripts/install_mongodb.sh",
            "execute_command": "sudo {{.Path}}"
        },
        {
            "type": "shell",
            "script": "files/deploy.sh",
            "execute_command": "sudo {{.Path}}"
        }
    ]
}

EOF


mkdir scripts

cat > scripts/install_mongodb.sh << EOF

#!/bin/bash

sleep 30

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-get --assume-yes update
sudo apt-get --assume-yes install mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

EOF

cat > scripts/install_ruby.sh << EOF

#!/bin/bash

sleep 30
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

EOF

mkdir files

cat > files/deploy.sh << EOF

#!/bin/bash

WORK_DIR=/opt/dude

sleep 30
sudo apt-get install -y git
mkdir /opt/dude && cd /opt/dude
git clone -b monolith https://github.com/express42/reddit.git
cd /opt/dude/reddit && bundle install
#puma    --- dont run, because instance cant stop and complete create image :(

EOF


packer build  immutable.json



yc compute image list

echo "enter your ID"
read IMG_ID

yc compute instance create \
  --name packer-test \
  --zone ru-central1-a \
  --create-boot-disk name=disk1,size=10,image-id=$IMG_ID \
  --public-ip \
  --ssh-key /home/user/.ssh/appuser.pub  # edit this





