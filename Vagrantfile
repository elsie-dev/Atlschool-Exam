# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/bionic64"
    master.vm.hostname = "Master"
    master.vm.network "private_network", type: "dhcp"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end 
  end



  config.vm.define "slave" do |slave|
    slave.vm.box = "ubuntu/bionic64"
    slave.vm.hostname = "Slave"
    slave.vm.network "private_network", type: "dhcp"
    slave.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
  end
end
