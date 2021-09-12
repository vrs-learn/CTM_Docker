#!/bin/bash

#CTM_ENV="ctmdev"
#CTM_SERVER="clm-aus-u1ks3d"
#CTM_HOSTGROUP="appgroup01"
#CTM_AGENT_PORT=7006

# Get the container ID and hostname. Combine them to get the agent alias
CID=$(cat /proc/1/cgroup | grep 'docker/' | tail -1 | sed 's/^.*\///' | cut -c 1-12)
AGHOST=$(hostname)
ALIAS=$AGHOST:$CID

echo Container ID is $CID and Alias is $ALIAS

#cd
#source .bash_profile

# Set up cli environment based on "docker run" CTMENV environment variable
# ctmDocker directory should be mounted by "-v" "docker run" argument. The following is a sample docker run:
# docker run --net host -v /soft/ctmagent/ctmDocker:/home/ec2-user/ctmDocker -e CTM_ENV=ctmdev -e CTM_SERVER=clm-aus-u1ks3d -e CTM_HOSTGROUP=appgroup01 -dt ctmagdocker
cp -f ctmDocker/$CTM_ENV/*.secret /home/ec2-user/
ctm env del myctm
ctm env add myctm `cat endpoint.secret` `cat username.secret` `cat password.secret`
ctm env set myctm

echo run and register controlm agent [$ALIAS] with controlm [$CTM_SERVER], environment [$CTM_ENV] 
ctm provision agent::setup $CTM_SERVER $ALIAS $CTM_AGENT_PORT

echo add or create a controlm hostgroup [$CTM_HOSTGROUP] with controlm agent [$ALIAS]
ctm config server:hostgroup:agent::add $CTM_SERVER $CTM_HOSTGROUP $ALIAS 

# loop forever
while true; do echo woke up && sleep 120; done

exit 0