#!/bin/bash

## install server mongodb

IP=$(hostname -I | awk '{print $2}')

echo "START - install Mongodb - "$IP

echo "[1]: install Mongodb"
apt-get update -qq >/dev/null
apt-get install -qq -y vim wget curl gnupg >/dev/null

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

sudo apt-get update
sudo apt-get install -y mongodb-org

echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

echo "[2]: run Mongodb"
systemctl daemon-reloads
systemctl enable mongod
systemctl start mongod

echo "[3]: verify run Mongodb"
sudo systemctl status mongod

echo "FIN - install Mongodb !"

