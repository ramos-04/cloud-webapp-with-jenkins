# Cloud-Project
The project involves the design and deployment of a website on cloud leveraging different features of AWS.

# Modules
1. Django webserver:
This module possesses the application source code of a single page website designed using the Django framework. It can be found at the path 'cloud-project/webserver/django_project'

2. Containerization:
The Django server is containerized. The Dockerfile can be viewed in order to dive into details.

3. Cloudformation:
It involves a provision for 'infrastructure as code'. A template is designed to create a stack of AWS resources on the fly. The stack will include the following resources -

           A. EC2 instance with Docker software and CodeDeploy agent installed (configured the 'ec2-userdata.sh' script as userdata)
           B. Security group for SSH access
           C. Security group for Django web server access
           D. IAM role and an instance profile for EC2 to gain S3 read permissions. This is required to fetch build artifacts from the S3 bucket during the CodePipeline operations.

4. CI/CD Pipeline:
AWS service CodePipeline is used to implement a CI/CD pipeline in cloud to expedite operations like build, test, deploy, etc. It comprises of three stages. The first stage involves the source code repository. In our case, we're using GitHub, however, it can be replaced with AWS CodeCommit, etc. During this stage, the latest source code will be checked out and stored as an artifact(source code artifact) in the S3 bucket. The next stage is the build stage represented by AWS CodeBuild service where the previously stored artifact will be taken as an input and a docker image will be built out of it. Thus, this will give rise to a new artifact called the build artifact which will be stored back to the S3 bucket. We can store the newly built docker image in Elastic Container Registry(ECR), however, I avoided the same, just in order to play around a bit. In the last stage, the build artifact will be deployed in the EC2 instance using the AWS CodeDeploy service. After a successful deployment, we'll able to access our website. 


   ![alt text](https://github.com/ramos-04/cloud-project/blob/master/images/AWS-CICD-Pipeline.png)

# Testing
Successful testing was carried out on an AWS cloud EC2 instance created from the AMI - ubuntu-bionic-18.04-amd64-server-20200408

# Others
The below standalone entities can be used if you don't wish to follow the CI/CD pipeline.

1. Deployment:
A script named 'docker-deploy.sh' is created to carry out the below important operations.

           A. Checking out source code from Github
           B. Building Docker images from the code
           C. Deploy the images to spin up containers

