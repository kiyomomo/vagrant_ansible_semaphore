#!/usr/bin/env bash
#mysql
sudo yum remove -y mariadb-libs
sudo yum -y localinstall http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
sudo yum -y install mysql-community-server
sudo systemctl stop mysqld
sudo systemctl set-environment MYSQLD_OPTS="--skip-grant-tables"
sudo systemctl start mysqld
sudo chkconfig mysqld on

#git
sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
sudo yum -y install git2u yum-utils
sudo yum-config-manager --disable ius

#wget
sudo yum -y install wget

#ansible
sudo yum -y install ansible

#ansible-semaphore
mkdir -p /home/vagrant/ansible_semaphore
wget https://github.com/ansible-semaphore/semaphore/releases/download/v2.5.1/semaphore_2.5.1_linux_amd64.tar.gz
chown vagrant:vagrant xvzf /home/vagrant/semaphore_2.5.1_linux_amd64.tar.gz
tar xvzf semaphore_2.5.1_linux_amd64.tar.gz -C /home/vagrant/ansible_semaphore
chown vagrant:vagrant -R /home/vagrant/ansible_semaphore

#version check
mysqld --version
git --version
ansible --version
echo "ansible semaphore version" && /home/vagrant/ansible_semaphore/semaphore --version
