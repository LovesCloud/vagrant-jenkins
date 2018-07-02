# -*- mode: ruby -*-
# vi: set ft=ruby :

memory = 2048
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "centos/7"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false


  config.vm.network "private_network", ip: "172.16.10.12", auto_config: false
  config.vm.network "forwarded_port", guest: 8080, host: 5000,
    auto_correct: true
 
  
  # config.vm.network "public_network"

  # config.vm.synced_folder "../data", "/vagrant_data"
 
   config.vm.provider "virtualbox" do |v|
      v.name = "jenkins-vm"
      v.customize ["modifyvm", :id, "--memory", "#{memory}"]
      
     
   end
  config.vm.provision "shell", path: "bootstrap.sh", privileged: true
end
