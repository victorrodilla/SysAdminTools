#!/bin/bash
username=$1
urlterraform=$2

# Installing repos

dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm 
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf update -y


#Installing git
dnf install -y git

# Installing docker

dnf install -y docker-ce 

# Assign permissions
groupadd docker 
useradd ${username} 
usermod -aG docker ${username}
# Maube you need log out, and log in to work with docker

#Enabling docker

systemctl start docker 
systemctl enable docker 

#Disabling firewall
systemctl stop firewalld
systemctl disable firewalld

#Installing wget, unzip, install python and configure

dnf install -y wget unzip python3
ln -s /usr/bin/python3 /usr/bin/python

#Installing Terraform

wget -qO terraform.zip $urlterraform 
unzip -q terraform.zip -d /usr/bin/
rm terraform.zip 

#Installing Ansible

#dnf install ansible (2.9.17)
pip3 install -y ansible
