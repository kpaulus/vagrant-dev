# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|  

  config.vm.box = "opentable/win-2012r2-standard-amd64-nocm"
  config.vm.guest = :windows
  
  config.vm.communicator = "winrm"
  config.vm.provider :virtualbox do |v|
    v.name = "windows"
    v.memory = 2048
    v.cpus = 1
  end
  
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"
  config.winrm.retry_limit = 30
  config.winrm.retry_delay = 10
  
  config.vm.network "private_network", ip: "192.168.123.123"
  config.vm.network :forwarded_port, guest: 1025, host: 1025
  config.vm.network :forwarded_port, guest: 3389, host: 1234
  config.vm.network "forwarded_port", guest: 80, host: 8080, id: "iis-defaultsite"
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
 
  # .NET 4.5 and MS Build Tools
  #config.vm.provision :shell, path: "vagrant-scripts/install-dot-net.ps1"  
  #config.vm.provision :shell, path: "vagrant-scripts/install-dot-net-45.cmd"
  #config.vm.provision :shell, path: "vagrant-scripts/install-msbuild-tools-2013.cmd"
  
  # Database
  #config.vm.provision :shell, path: "vagrant-scripts/install-sql-server.cmd" 
  #config.vm.provision :shell, path: "vagrant-scripts/configure-sql-server.ps1"  
  
  #Restore DB
  #config.vm.provision :shell, path: "vagrant-scripts/create-database.cmd"
  
  # Development Tools
  config.vm.provision :shell, path: "vagrant-scripts/install-chocolatey.cmd"
  config.vm.provision :shell, path: "vagrant-scripts/install-dev-tools.ps1"
  config.vm.provision :shell, path: "vagrant-scripts/install-gem-sass.cmd"
  config.vm.provision :shell, path: "vagrant-scripts/install-gem-compass.cmd"
  config.vm.provision :shell, path: "vagrant-scripts/install-gem-bootstrap.cmd"
  config.vm.provision :shell, path: "vagrant-scripts/install-ms-dev-tools.ps1"

  # IIS   
  #config.vm.provision :shell, path: "vagrant-scripts/install-iis.cmd"
  config.vm.provision :shell, path: "vagrant-scripts/provision-web.ps1"
    
  #Create Website
  #config.vm.provision :shell, path: "vagrant-scripts/copy-website.ps1"
  #config.vm.provision :shell, path: "vagrant-scripts/build-website.cmd"
  #config.vm.provision :shell, path: "vagrant-scripts/creating-website-in-iis.cmd"
  #config.vm.provision :shell, path: "vagrant-scripts/setup-permissions-for-website-folder.ps1"
  
end