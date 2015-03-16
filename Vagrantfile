VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 
config.vm.provider "virtualbox" do |vb|
  
        #vb.gui = true
        vb.customize ["modifyvm", :id, "--memory", "512"]
        vb.cpus = 1
        #Change the mac from default to not interrupt communication on network.The mac might already exist, same thing for hostname below.
        vb.customize ["modifyvm", :id, "--macaddress1", "08002789D551" ]
end

#defines Machine to use for Base
config.vm.box = "Ubuntu1404" 

#general network and machine settings
config.vm.guest = :linux
#modify the host name and above mac from defaults.Otherwise, collitions could occur on the network
#config.vm.hostname = "tradeshowserver"

# forward ssh ports
config.vm.network :forwarded_port, guest: 22, host: 22, id: "ssh", auto_correct: true
config.vm.network :forwarded_port, guest: 80, host: 80, id: "http", auto_correct: true
config.vm.network :forwarded_port, guest: 81, host: 81, id: "phpmyadmin", auto_correct: true
config.vm.network :forwarded_port, guest: 143, host: 143, id: "imap", auto_correct: true
config.vm.network :forwarded_port, guest: 25, host: 25, id: "smtp", auto_correct: true
config.vm.network :forwarded_port, guest: 8090, host: 8090, id: "vlc", auto_correct: true
config.winrm.max_tries = 10
config.ssh.insert_key="False"
config.ssh.username="vagrant"
config.ssh.password="vagrant"
  
#Installs Apache, PHPmyadmin, MYSQL, standard LAMP for joomla site replication
config.vm.provision :shell, path: "install-LAMP.sh"
#config.vm.provision :shell, path: "replicatewebsite.sh"
config.vm.provision :shell, path: "DVWA.sh"
#config.vm.provision :shell, path: "install-bind9.sh"
#config.vm.provision :shell, path: "install-emailserver.sh"
#config.vm.provision :shell, path: "install-DHCP.sh"
#config.vm.provision :shell, path: "install-VLC.sh"
#config.vm.provision :shell, path: "setipandshutdown.sh"


end
