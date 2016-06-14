# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  # config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
  config.vm.box = "puppetlabs/debian-8.2-64-puppet"

  # config.vm.network :public_network

  config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: [".git/", "_build/", "rel"]

  config.vm.define "build", primary: true do |node|
    node.vm.provision "puppet" do |puppet|
      puppet.environment_path = "puppet/environments"
      puppet.environment = "test"
      puppet.module_path = "puppet/modules"
    end
  end

end
