#!/bin/sh

# Directory in which librarian-puppet should manage its modules directory
PUPPET_DIR=/etc/puppet/

# NB: librarian-puppet might need git installed. If it is not already installed
# in your basebox, this will manually install it at this point using apt or yum

echo 'vagrant    ALL=(ALL)  NOPASSWD:ALL' >> /etc/sudoers

mkdir ~/.ssh
cd ~/.ssh
wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
mv vagrant.pub authorized_keys
chmod 0700 authorized_keys
chown vagrant:vagrant authorized_keys
apt-get -y update
#apt-get install -y puppet-common
apt-get install -y ruby1.9.1-dev
apt-get install -y build-essential checkinstall

$(which git > /dev/null 2>&1)
FOUND_GIT=$?
if [ "$FOUND_GIT" -ne '0' ]; then
  echo 'Attempting to install git.'
  $(which apt-get > /dev/null 2>&1)
  FOUND_APT=$?
  $(which yum > /dev/null 2>&1)
  FOUND_YUM=$?

  if [ "${FOUND_YUM}" -eq '0' ]; then
    yum -q -y makecache
    yum -q -y install git
    echo 'git installed.'
  elif [ "${FOUND_APT}" -eq '0' ]; then
    apt-get -q -y install git
    echo 'git installed.'
  else
    echo 'No package installer available. You may need to install git manually.'
  fi
else
  echo 'git found.'
fi

if [ ! -d "$PUPPET_DIR" ]; then
  mkdir -p $PUPPET_DIR
fi
cp /vagrant/puppet/Puppetfile $PUPPET_DIR

if [ "$(gem search -i librarian-puppet)" = "false" ]; then
  sudo gem install puppet
  sudo gem install librarian-puppet
  cd $PUPPET_DIR && librarian-puppet install --clean
else
  cd $PUPPET_DIR && librarian-puppet update
fi


