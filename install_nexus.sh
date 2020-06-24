#!/bin/bash

IP=$(hostname -I | awk '{print $2}')

echo "START - install nexus - "$IP

#Install Oracle JDK
cd /opt

echo "Downloading Oracle JDK..."
apt-get install -qq -y yum >/dev/null
echo "Configure JDK start."

sudo mkdir -p /var/lib/java
cd /var/lib/java
# required to put java 8 tar in vagrant directory, or change os to debian stresh64 and use default jre
sudo cp /vagrant/jdk-8u251-linux-x64.tar.gz /var/lib/java
sudo tar -zxf jdk-8u251-linux-x64.tar.gz


export JAVA_HOME=/var/lib/java/jdk1.8.0_251
export JRE_HOME=/var/lib/java/jdk1.8.0_251/jre
export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin

echo "Configure JDK end."
java -version

#Install Nexus
sudo mkdir -p /opt/nexus
cd /opt/nexus
echo "Downloading Nexus..."
sudo wget -nv http://download.sonatype.com/nexus/3/nexus-3.23.0-03-unix.tar.gz
sudo tar -zxf nexus-3.23.0-03-unix.tar.gz
sudo rm nexus-3.23.0-03-unix.tar.gz

sudo useradd nexus -p nexus
sudo chown nexus:nexus /opt/nexus/ -R

sed -i 's+.*INSTALL4J_JAVA_HOME_OVERRIDE=.*+INSTALL4J_JAVA_HOME_OVERRIDE=/var/lib/java/jdk1.8.0_251+' /opt/nexus/nexus-3.23.0-03/bin/nexus


FILE=/etc/init.d/nexus
if [ -f "$FILE" ]; then
    echo "$FILE exist"
else 
    sudo ln -s /opt/nexus/nexus-3.23.0-03/bin/nexus /etc/init.d/nexus
fi
cd /etc/init.d
sudo update-rc.d nexus defaults
sudo service nexus start
echo "Nexus installed."