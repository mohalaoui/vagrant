#!/bin/bash

## install dev

IP=$(hostname -I | awk '{print $2}')

echo "START - install dev - "$IP

echo "[1]: install utils"
apt-get update -qq >/dev/null
apt-get install -qq -y sshpass wget vim gnupg2 curl default-jre>/dev/null

echo "END - install dev"