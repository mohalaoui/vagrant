#!/bin/bash

# This script downloads and installs Keycloak.
# Use the VERSION environment variable below to define the version to be used.

IP=$(hostname -I | awk '{print $2}')

echo "START - install keycloak - "$IP

VERSION=10.0.2

DOWNLOAD_URL=http://downloads.jboss.org/keycloak/${VERSION}/keycloak-${VERSION}.tar.gz

# Install Java
echo "Installing Java 8 JDK and utils ..."
apt-get update -qq >/dev/null
apt-get install -qq -y sshpass wget vim gnupg2 curl default-jre>/dev/null

# Install Keycloak
if [ -f "/vagrant/downloads/keycloak-${VERSION}.tar.gz" ];
then
    echo "Installing Keycloak from /vagrant/downloads/keycloak-${VERSION} ..."
else
    echo "Downloading Keycloak ${VERSION} ..."
    mkdir -p /vagrant/downloads
    wget -q -O /vagrant/downloads/keycloak-${VERSION}.tar.gz "${DOWNLOAD_URL}"
    if [ $? != 0 ];
    then
        echo "FATAL: Failed to download Keycloak from ${DOWNLOAD_URL}"	
        exit 1
    fi

    echo "Installing Keycloak ..."
fi

tar xfz /vagrant/downloads/keycloak-${VERSION}.tar.gz -C /opt
rm -f /opt/keycloak
ln -s /opt/keycloak-${VERSION} /opt/keycloak

cp -f /vagrant/wildfly.conf /etc/default/wildfly.conf

sudo useradd keycloak -p keycloak
sudo chown keycloak:keycloak /opt/keycloak-${VERSION}/ -R

chmod -R g+rw /opt/keycloak-${VERSION}

source /etc/default/wildfly.conf
mkdir -p /var/log/wildfly
chown -R ${JBOSS_USER} /var/log/wildfly /opt/keycloak-${VERSION}

cd /opt/keycloak-${VERSION}/bin/
sudo -u keycloak ./add-user-keycloak.sh --user admin --password admin --realm master


sudo cat > /etc/systemd/system/keycloak.service <<EOF

[Unit]
Description=Jboss Application Server
After=network.target

[Service]
Type=idle
User=keycloak
Group=keycloak
ExecStart=/opt/keycloak-${VERSION}/bin/standalone.sh -b 0.0.0.0
TimeoutStartSec=600
TimeoutStopSec=600

[Install]
WantedBy=multi-user.target
EOF

# Start Keycloak
echo "Starting Keycloak ..."

sudo systemctl daemon-reload
sudo systemctl enable keycloak
sudo systemctl start keycloak
