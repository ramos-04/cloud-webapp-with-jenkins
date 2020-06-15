# cloud-project
The project involves the design and deployment of a website on cloud leveraging different features of AWS.

# modules
1. Django webserver:
This module possesses the application source code of a single page website designed using the Django framework. It can be found at the path 'cloud-project/webserver/django_project'

2. Containerization:
The Django server is containerized. The Dockerfile can be viewed in order to dive into details.

3. Docker installation:
A script is designed to install docker. If you have a fresh Ubuntu EC2 instance, all you have to do is just run the script 'docker-install.sh'. It takes care of the complete installation of docker on your instance. 

4. Deployment:
A script named 'docker-deploy.sh' is created to carry out the below important operations. As of now, these operations are handled using a script, but soon they will be performed using any CI/CD tool 

           A. Checking out source code from Github
           B. Building Docker images from the code
           C. Deploy the images to spin up containers
            
5. Cloudformation:
It involves a provision for 'infrastructure as code'. A template is designed to create a stack of AWS resources on the fly. The stack will include the following resources -

           A. EC2 instance with Docker software installed (configuring the 'docker-install.sh' script as userdata)
           B. Security group for SSH access
           C. Security group for Django webserver access

# testing
A successful testing was carried out on an AWS cloud EC2 instance created from the AMI - ubuntu-bionic-18.04-amd64-server-20200408
