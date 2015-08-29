# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "morungos/centos67"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.

  config.vm.synced_folder ".", "/vagrant", disabled: true

  # For VirtualBox, set RAM availability, and use two CPUs.
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
    v.customize ["modifyvm", :id, "--nictype1", "Am79C973"]
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning.yml"
    ansible.verbose = "v"
  end

end
