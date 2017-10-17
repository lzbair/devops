# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  bitbucket.vm.box = "nespresso-basebox-el7"
  bitbucket.vm.box_url = "http://hqchrepo2.nespresso.com/vagrant-images/nespresso-basebox-el7/current.json
  config.ssh.insert_key = false
  config.ssh.private_key_path = "./modules/hiera/baseboxes/keys/vagrant_access_rsa"

  if Vagrant.has_plugin?("vagrant-hostmanager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.memory = 1024
    vb.cpus = 2
    vb.gui = false
    vb.linked_clone = true
  end

  config.vm.define "rampuplab-instance", autostart: true do |rampup|
    rampup.vm.host_name = "rampuplab.nespresso.com"
    rampup.vm.network "private_network", ip: "192.168.56.11"
  end

  # create hiera file in vagrant machine
  config.vm.provision :shell, :inline => "ln -sf /vagrant/modules/hiera/hiera-vagrant.yaml /etc/puppetlabs/puppet/hiera.yaml"

  # Use puppet provisionner to configure everything else
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "modules"
    puppet.options = "-v"
    puppet.manifest_file  = "vagrant.pp"
    puppet.facter = { "vagrant_box" => true }
  end

end
