#!/bin/bash
cd ~
sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
ps aux | grep puma
ss -tulnp | grep 9292