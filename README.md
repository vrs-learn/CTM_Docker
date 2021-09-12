# This setup is tested for 9.0.20

## Fixing the CTM package.
The control-m api has a bug where it only accepts the zipped tar file. Make sure the tar file has an extension of .tar
The .tar file should be zipped with gzip or zip.

## Download the Control-m git solution for running agent in docker container.
https://github.com/controlm/automation-api-community-solutions/tree/master/3-infrastructure-as-code-examples

## To build the image, run below command:

> docker build --tag=ctmagdocker --network=host --build-arg CTMHOST=<EM Server Name> --build-arg CTMENV=ctmdev .

## To start a container based on the image:

> docker run --net host -v /soft/ctmagent/ctmDocker:/home/ec2-user/ctmDocker -e CTM_ENV=ctmdev -e CTM_SERVER=<DATACENTER NAME> -e CTM_HOSTGROUP=appgroup01 -e CTM_AGENT_PORT=7006 -dt ctmagdocker

## To delete the agent from the Control-M server, run below:
> sudo docker exec -it ctmag2 /home/ec2-user/decommission_controlm.sh