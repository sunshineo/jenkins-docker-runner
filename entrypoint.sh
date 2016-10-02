#!/bin/bash

# Add a user for jenkins. And make sure it is in the docker group
# https://github.com/evarga/docker-images/blob/master/jenkins-slave/Dockerfile
# http://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo
useradd -m -d /home/jenkins -s /bin/sh -g docker jenkins
echo "jenkins:$JENKINS_PASSWORD" | chpasswd

# start sshd so jenkins can connect
/etc/init.d/ssh start

# start docker engin
service docker start
# Wait for daemon to start or login will fail
sleep 5

if [ -z "$DOCKER_USERNAME" ];
then
	echo "No docker username set. Will not login to docker. Will only be able to pull public images."
else
	echo "Will try to login to docker as $DOCKER_USERNAME"
	docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
fi

exec "$@"
