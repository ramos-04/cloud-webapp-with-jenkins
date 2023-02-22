#!/bin/bash
# This script tries to leverage the 'userdata' functionality of the EC2 service in AWS cloud. When the EC2 instance will be launched, this script will run during the boot time, thus, ultimately installing Docker and a CodeDeploy agent.

# When you encounter an error in a bash script, by default, it throws an error message to stderr, but continues its execution in the rest of the script. In fact you see the same behavior in a terminal window; even if you type a wrong command by accident, it will not kill your terminal. You will just see the "command not found" error, but you terminal/bash session will still remain. If any command returns a non-zero(error) status, then it could be caught and the script execution can be terminated immediately by using the set -e command. However, one special error condition not captured by set -e is when an error occurs somewhere inside a pipeline of commands. This is because a pipeline returns a non-zero status only if the last command in the pipeline fails. Any error produced by previous command(s) in the pipeline is not visible outside the pipeline, and so does not kill a bash script. Thus, -o pipefail option is added.

set -o pipefail -e



# A Bash trap allows you to execute a function when a signal is trapped. When any command inside the shellscript will return a non-zero status(error), the trap command will trap it and send to the fucntion. $? is a builtin shell variable which stores the exit status of the last run command.

trap 'catcherror $? $LINENO' ERR

# The below function acts like a catch block used in exception handling(observed in different programming languages). It will print the error code and the line number on which the error was generated. The script will be exited later. If you dont want to exit the script on a particular error, then you can manage the exit command inside catch block flexibly by creating conditions.

catcherror()
{
  echo "Error code $1 generated on Line $2"
  exit 1
}

# printing the username
echo "Username is $(whoami)"

# validating the user (the script should be run as a root user)
        if [ "$(whoami)" != "root" ]; then
                        echo  "Script should be run as a root user"
                        exit -1
        fi

# update the packages
apt update -y

# installing certain prerequisites which let 'apt' use packages over HTTPS
apt install -y apt-transport-https ca-certificates curl software-properties-common

# adding the GPG key for the official docker repository to our system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# adding the docker repository to APT sources
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# updating the package database with the docker packages from the newly added repo
apt update -y

# installing docker
apt install -y docker-ce

# validating the installation of docker by checking the version
docker version

# installing ruby as it is required for the functioning of the codedeploy agent
echo "installing ruby"
apt-get install -y ruby

# installing the codedeploy agent. Replace the AWS Region as per your environment.
echo "downloading codedeploy agent"
wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install

# allocating executable permissions to the script
echo "providing executable permissions to the script"
chmod +x ./install

echo "installing codedeploy agent"
./install auto

service codedeploy-agent start

# checking the status of the codedeploy agent
echo "checking the status of the codedeploy agent"
service codedeploy-agent status


