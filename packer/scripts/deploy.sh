#!/bin/bash
cd ~/
apt --assume-yes install git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
cp ~/puma.service /etc/systemd/system/puma.service
systemctl enable puma
systemctl start puma
