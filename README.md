# jenkins-docker-runner
A docker image that can be a SSH slave for Jenkins and run docker commands inside it.

It has become more and more common to use Jenkins to run docker.
However you need to configure a machine as Jenkins slave and install docker engine, etc.
And what if you have already moved away from using virtual machines to use dockers? Use this image

## Overview
This project is very simple. It does the following things:

### Build time
1. Install docker engine
2. Install Java 7 runtime
3. Install openssh-server and expose port 22 for Jenkins to ssh

### Runtime (entrypoint.sh)
1. Create a user jenkins and add it to the group 'docker' so that user can run docker
2. Start openssh-server
3. Start docker engine
4. If ENV variable $DOCKER_USERNAME and $DOCKER_PASSWORD are provided, it will login with that user. So that it can pull private docker images.
5. execute CMD (If not provided on command line, it will tail docker engine log)

#**IMPORTANT**: MUST USE --privileged
Here is an example run command:
```
docker run --privileged -it --rm -P -e JENKINS_PASSWORD=password -e DOCKER_USERNAME=sunshineo -e DOCKER_PASSWORD=****** sunshineo/jenkins-docker-runner
```
And try some docker command like:
```
docker run hello-world
```
