#!/usr/bin/env bash

export ARTIFACTORY_HOME=/opt/Artifactory
export ARTIFACTORY_DATA_PATH=/var/Artifactory
export ARTIFACTORY_USER=artifactory
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.60-2.b27.el7_1.x86_64

#add the user
useradd $ARTIFACTORY_USER

ARTIFACTORY_FILE=jfrog-artifactory-oss-4.2.0.zip
rm -rf /tmp/$ARTIFACTORY_FILE
wget https://bintray.com/artifact/download/jfrog/artifactory/$ARTIFACTORY_FILE -O /tmp/$ARTIFACTORY_FILE

echo 'unzipping artifactory...'
rm -rf $ARTIFACTORY_HOME
unzip /tmp/$ARTIFACTORY_FILE -d /opt
mv /opt/artifactory-oss-4.2.0 $ARTIFACTORY_HOME
rm -rf /tmp/$ARTIFACTORY_FILE

# put the data and backup folders on a shared mount e.g.
mkdir -p $ARTIFACTORY_DATA_PATH/backup
ln -s $ARTIFACTORY_DATA_PATH/backup $ARTIFACTORY_HOME/backup
mkdir -p $ARTIFACTORY_DATA_PATH/data
ln -s $ARTIFACTORY_DATA_PATH/data $ARTIFACTORY_HOME/data

#start the install script using the artifactory user
$ARTIFACTORY_HOME/bin/installService.sh $ARTIFACTORY_USER

service artifactory start

#echo 'optionally reenable firewalld or iptables...'
#systemctl start firewalld
#systemctl enable firewalld
