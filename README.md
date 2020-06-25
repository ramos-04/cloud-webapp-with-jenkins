# Cloud-Project
The project involves the design and deployment of a website on cloud leveraging different features of AWS.

# Modules
1. Architecture:



      ![alt text](https://github.com/ramos-04/cloud-project/blob/master/images/architecture.png)


1. EC2 Instance:
A web server developed using Python Django framework is running in an EC2 instance. The server is containerized using Docker and the Dockerfile can be viewed in order to dive into details. When the EC2 instance is launched, Docker and a CodeDeploy agent are automatically installed(during the boot time). The installation is accomplished using the 'userdata' functionality of AWS. The agent is installed to carry out the application deployment using the AWS CodeDeploy service.

2. Application Load Balancer(ALB): 
An ALB is sitting in front of the EC2 instance. It automatically distributes the incoming application traffic, detects unhealthy instances, and reroutes traffic to healthy instances until the unhealthy instances have been restored. This entity can be leveraged when there will be a fleet of EC2 instances spinned up using an Auto Scaling Group. 

3. Security at the infrastructure level:
We can implement SSL/TLS termination in the application in order to make it secure. What if someone else can handle this for us? What if we spend our valuable time focussing more on the implementation of business core requirements? Wouldn't it aid us to get an edge over our competition? AWS offers us a way to configure security at the infrastructure level. We've made the application load balancer(ALB) itself TLS secured.     

4. Security Groups:
They are acting as firewalls, filtering the traffic. One security group is sitting on top of the ALB permitting access to only a specific set of clients. This set of clients can be configured by the user through 'Parameters' in AWS Cloudformation. A second security group is attached to the EC2 instance which enables HTTP traffic only from the load balancer and SSH traffic only from a specific set of clients. 

5. CI/CD Pipeline:
AWS service CodePipeline is used to implement a CI/CD pipeline in the cloud to expedite operations like build, test, deploy, etc. It comprises of three stages. The first stage involves the operation of checking out the latest source code from a repository and storing it as an artifact(source code artifact) in the S3 bucket. In our case, we're using the GitHub repository for maintaining the code, however, alternatives like AWS CodeCommit, Bitbucket, etc can too be used. The next stage is the build stage which is carried out by the AWS CodeBuild service. This stage will take the previously-stored source code artifact as an input and a docker image will be built out of it. Thus, this will give rise to a new artifact called the build artifact which will be stored back to the S3 bucket. We can store the newly built docker image in Elastic Container Registry(ECR), however, I avoided the same, just to play around a bit. In the last stage, the build artifact will be deployed in the EC2 instance using the AWS CodeDeploy service. After a successful deployment, we'll able to access our website. During the complete process, it was great to note that the AWS CodeBuild service uses a docker image to build any artifact. The concept of "CI/CD using Docker" which is widely practised lately is undoubtedly a great way to speed up the process and save resources.  


   ![alt text](https://github.com/ramos-04/cloud-project/blob/master/images/AWS-CICD-Pipeline.png)


6. Cloudformation:
In order to set up and configure all the AWS resources, we'll need to hit 100 clicks on the AWS console. Furthermore, if we wish to repeat the same setup on a different AWS account, then the manual procedure needs to be reiterated. Wouldn't it be cool if we automate this complete job? Well, the automation is carried out using the AWS Cloudformation service acting as 'Infrastructure as Code'. A template is designed to create the following stack of resources on the fly.

           A. EC2 instance with Docker software and CodeDeploy agent installed (configured the 'ec2-userdata.sh' script as userdata)
           B. Security group for the EC2 instance to allow HTTP traffic only from the ALB and SSH traffic only from a predefined set of clients. 
           C. Security group for ALB to permit access only for a predefined set of clients.
           D. IAM role and an Instance Profile for the EC2 instance to gain S3 read permissions. This is required to fetch build artifacts from the S3 bucket during the CodePipeline operations.
           E. TLS secured Application Load Balancer
           F. CodeBuild project
           G. CodeDeploy project
           H. CodePipeline
           
7. Complete Automation:
As afore-discussed, Cloudformation has played a significant role in achieving complete automation. Now. we just have to run a single command. And that's it!!! Our website will be up. The following sequence of operations will occur automatically after running the command-

          A. The complete infrastructure will be provisioned(creation of all the required AWS resources)
          B. A CI/CD Pipeline will be created and triggered
          C. Latest source code from the repository will be checked out
          D. It will be built to create artifacts
          E. And finally, the artifacts will be deployed on an EC2 instance
          F. The website is live
          
Also, if you wish to bring down everything, then again, you just require a single command.
           
           
8. Monitoring:
AWS CloudWatch is used for monitoring purposes. The logs generated during various operations of the CI/CD pipeline are stored in CloudWatch. It becomes handy while troubleshooting issues.

           
# Testing
Successful testing has been carried out using the EC2 instance AMI - ubuntu-bionic-18.04-amd64-server-20200408

# Others
The below standalone entities can be used if you don't wish to get along with the CI/CD pipeline.

1. Deployment:
A script named 'docker-deploy.sh' is created to carry out the below important operations.

           A. Checking out source code from Github
           B. Building Docker images from the code
           C. Deploy the images to spin up containers

