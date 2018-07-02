#!/bin/bash
echo -e "\033[32m Loves Cloud Centos/7 Vagrant.  \033[0m"
echo -e "\033[32m ============================  \033[0m"
echo -e "\033[32m Going to Install: 033[0m"
echo -e "\033[32m \n\t - Java8\n\t - Jenkins \n\t - Docker 18"

function install_java()
{
	echo -e "\033[32m Starting Oracle Java Install.  \033[0m"
	echo -e "\033[32m ============================  \033[0m"
	echo "\n\n\n"
	cd /opt

	if [ -f "jdk-8u45-linux-x64.rpm" ];then
		echo -e "\033[31m Jdk package already exist. I will remove it for you. \033[0m"
		rm jdk-8u45-linux-x64.rpm
	fi

	#echo 'download java rpm'
	echo -e "\033[32m Ready to  download java rpm  \033[0m"

	wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.rpm"

	#echo 'downloaded. begin to install'
	echo -e "\033[32m Downloaded. Begin to install  \033[0m"

	rpm -ivh jdk-8u171-linux-x64.rpm

	java -version
	if [ "$?" = "0" ]; then
		#echo 'install java successfully.'
		echo -e "\033[32m Install java successfully.  \033[0m"
	else
		#echo 'install java failed'
		echo -e "\033[31m Install java failed.  \033[0m"
	fi
}

function install_jenkins()
{
	echo -e "\033[32m Installing Jenkins on Vagrant box.  \033[0m"
    sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
    sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
    sudo yum install -y jenkins
    sudo service jenkins start
    sudo chkconfig jenkins on
    sudo usermod -aG docker jenkins
    echo -e "\033[32m Installed Jenkins on Vagrant box.  \033[0m"
}

function install_docker()
{
    echo -e "\033[32m Installing docker.  \033[0m"
	
	sudo yum install -y yum-utils device-mapper-persistent-data lvm2
	sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
	sudo yum install -y docker-ce-18.03.0.ce-1.el7.centos
    sudo usermod -aG docker $USER
    sudo systemctl start docker
    sudo systemctl enable docker
    echo -e "\033[32m Installed Docker on Vagrant box.  \033[0m"

}

function install_commons()
{
	yum update -y
	sudo yum install -y git vim wget curl 
}

echo -e "\033[32m Running Vagrant Box Setup  \033[0m"
echo -e "\033[32m ============================  \033[0m"

install_commons
install_java
install_docker
install_jenkins

echo -e "\033[32m Vagrant Box Setup Complete  \033[0m"
echo -e "\033[32m ============================  \033[0m"
