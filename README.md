# vagrant provisioning
- required to install virtualBox : https://www.virtualbox.org/wiki/Downloads
- if you want to use java8 you have 2 choice
  - choose stretsh64 debian and use apt-get install -qq -y default-jre>/dev/null
  - download jdk8 from oracle and put it vagrant directory

- you can modify number of CPUs and RAM in vagrantfile

## debian buster64 and stretch64

### install dev environment
install_dev.sh

### install jenkins
install_jenkins.sh

### install nexus
install_nexus.sh

### install mongodb
install_mongodb.sh

### install keycloak
install_keycloak.sh