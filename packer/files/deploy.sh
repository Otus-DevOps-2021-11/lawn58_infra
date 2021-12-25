#!/bin/bash

WORK_DIR=/opt/dude

sleep 30
sudo apt-get install -y git
mkdir $WORK_DIR && cd $WORK_DIR
git clone -b monolith https://github.com/express42/reddit.git
cd $WORK_DIR/reddit && bundle install

cat > /etc/systemd/system/dude.service << EOF

[Unit]
Description=wtf is this dude?!
Documentation=https://otus.ru

[Service]
Type=simple
WorkingDirectory=/opt/dude/reddit
ExecStart=/usr/local/bin/puma
SyslogIdentifier=DudeService

[Install]
WantedBy=multi-user.target

EOF

systemctl enable dude
systemctl start dude

