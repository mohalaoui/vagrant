# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # jenkins server
  config.vm.define "jenkins-pipeline" do |jenkins|
    jenkins.vm.box = "debian/buster64"
    jenkins.vm.hostname = "jenkins-pipeline"
    jenkins.vm.box_url = "debian/buster64"
    jenkins.vm.network :private_network, ip: "192.168.5.2"
    jenkins.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "jenkins-pipeline"]
      v.customize ["modifyvm", :id, "--cpus", "2"]
    end
    config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
      service ssh restart
    SHELL
    jenkins.vm.provision "shell", path: "install_jenkins.sh"
  end

  # serveur dev
  config.vm.define "srvdev-pipeline" do |srvdev|
    srvdev.vm.box = "debian/stretch64"
    srvdev.vm.hostname = "srvdev-pipeline"
    srvdev.vm.box_url = "debian/stretch64"
    srvdev.vm.network :private_network, ip: "192.168.5.3"
    srvdev.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "srvdev-pipeline"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
    config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
      service ssh restart
    SHELL
	srvdev.vm.provision "shell", path: "install_dev.sh"
  end


  # serveur prod
  config.vm.define "srvprod-pipeline" do |srvprod|
    srvprod.vm.box = "debian/buster64"
    srvprod.vm.hostname = "srvprod-pipeline"
    srvprod.vm.box_url = "debian/buster64"
    srvprod.vm.network :private_network, ip: "192.168.5.4"
    srvprod.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "srvprod-pipeline"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
    config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
      service ssh restart
    SHELL
  end

  # Serveur keycloak
  config.vm.define "keycloak-pipeline" do |keycloak|
    keycloak.vm.box = "debian/stretch64"
    keycloak.vm.hostname = "keycloak-pipeline"
    keycloak.vm.box_url = "debian/stretch64"
    keycloak.vm.network :private_network, ip: "192.168.5.5"
    keycloak.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "keycloak-pipeline"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
	keycloak.vm.provision "shell", path: "install_keycloak.sh"
  end

  # Serveur Nexus
  config.vm.define "nexus-pipeline" do |nexus|
    nexus.vm.box = "debian/buster64"
    nexus.vm.hostname = "nexus-pipeline"
    nexus.vm.box_url = "debian/buster64"
    nexus.vm.network :private_network, ip: "192.168.5.6"
    nexus.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "nexus-pipeline"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
    config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
      service ssh restart
    SHELL
    nexus.vm.provision "shell", path: "install_nexus.sh"
  end

  # Serveur Mongodb
  config.vm.define "mongodb-pipeline" do |mongodb|
    mongodb.vm.box = "debian/buster64"
    mongodb.vm.hostname = "mongodb-pipeline"
    mongodb.vm.box_url = "debian/buster64"
    mongodb.vm.network :private_network, ip: "192.168.5.7"
    mongodb.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "mongodb-pipeline"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
    config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
      service ssh restart
    SHELL
    mongodb.vm.provision "shell", path: "install_mongodb.sh"
  end
  
  # Serveur Postgres
  config.vm.define "postgres-pipeline" do |postgres|
    postgres.vm.box = "debian/buster64"
    postgres.vm.hostname = "postgres-pipeline"
    postgres.vm.box_url = "debian/buster64"
    postgres.vm.network :private_network, ip: "192.168.5.8"
    postgres.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "postgres-pipeline"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
    end
    postgres.vm.provision "shell", path: "install_srvpostgres.sh"
  end


end

