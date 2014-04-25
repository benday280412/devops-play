# CI Provisioning Notes

## Virtualbox
* Install the latest version

		deb http://download.virtualbox.org/virtualbox/debian saucy contrib
		wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
		sudo apt-get update
		sudo apt-get install virtualbox-4.3
		sudo apt-get install dkms

##Vagrant

* Download vagrant from web site and install deb
* Install vbguest to keep gues additions upto date

        vagrant plugin install vagrant-vbguest

### Issues

#### ssh access key
    mkdir ~/.ssh
    cd ~/.ssh
    wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
    mv vagrant.pub authorized_keys
    chmod 0700 authorized_keys


#### Won't mount error
* If the following error appears
* Fix with the following
    sudo ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions


##Build Steps

    cd packer
    packer build machine_puppet.json
    vagrant box add packer_virtualbox-iso_virtualbox.box --name benday280412/ubuntu_64_14.04
