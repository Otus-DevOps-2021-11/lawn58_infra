#!/bin/bash
set -e
APP_DIR=${1:-$HOME}
sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
#echo "enter mongodb host ip"
#read DATABASE_URL
#export DATABASE_URL
sudo systemctl start puma
sudo systemctl enable puma
