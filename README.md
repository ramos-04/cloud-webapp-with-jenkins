# Cloud-Webapp-With-Jenkins
This tech stack will deploy a web app on AWS cloud and a CICD pipeline will be built using Jenkins as the CI server.

# Modules
1. Architecture:



      ![alt text](https://github.com/ramos-04/cloud-webapp-with-jenkins/blob/9f46665465bb8bfcb50fc4335e85dd672a1f93e7/images/architecture.png)


2. EC2 Instance with Autoscaling Group:
A web server developed using Python Django framework is deployed on the EC2 instances managed by an auto scaling group. The server is containerized using Docker. The Dockerfile can be viewed in order to dive into details. When the EC2 instance is launched, Docker and a CodeDeploy agent are automatically installed(during the boot time). The installation is accomplished using the 'userdata' functionality of AWS. The codedeploy agent is installed to carry out the application deployment using the AWS CodeDeploy service.

3. Application Load Balancer(ALB): 
An ALB is sitting in front of the EC2 instance. It automatically distributes the incoming application traffic, detects unhealthy instances, and reroutes traffic to healthy instances until the unhealthy instances have been restored. This entity can be leveraged when there will be a fleet of EC2 instances spinned up using an Auto Scaling Group. 

6. CI/CD Pipeline:
A CI/CD pipeline is developed in the cloud to expedite operations like build, test, deploy, etc. In our case, we're using a GitHub repository for storing and maintaining the source code, however, alternatives like AWS CodeCommit, Bitbucket, etc also can be used. Whenever a developer commits code/feature to the Github repository, Github(using its web hook functionality) will trigger the Jenkins server residing in a public EC2 instance. The Jenkins server will build the latest source code and construct docker images out of it. It will push the docker images to Elastic Container Registry(ECR). Then, the Jenkins server will create a codedeploy compatible deployment artifact and upload it on a S3 bucket. Later, the Jenkins server will trigger the AWS codedeploy service to perform a new deployment with the latest docker images. In response to this, the codedeploy service will perform the deployment on the EC2 instances in the autoscaling group. It is important to note that no AWS credentials are stored in the Jenkins server EC2 instance, instead, IAM roles are attached to the instance in order to provision the necessary permissions.


   ![alt text](https://github.com/ramos-04/cloud-webapp-with-jenkins/blob/40fb80f71025f2d8d4fb95587ef6c896bb3382e5/images/AWS-CICD-Pipeline.png)

7. Cloudformation:
In order to set up and configure all the AWS resources, we'll need to hit 100 clicks on the AWS console. Furthermore, if we wish to repeat the same setup on a different AWS account, then the manual procedure needs to be reiterated. Wouldn't it be cool if we automate this complete job? Well, the AWS Cloudformation service acting as 'Infrastructure as Code' can help us with this. Different templates are designed to create the AWS resources on the fly. Kindly refer the Readme file present at the path 'cloud-project/cloudformation/' for further details.
         
8. SSL/TLS termination at the Infrastructure Level:
We can implement security(SSL/TLS) in the application in order to make it secure. What if someone else can do this for us? What if we spend our valuable time focussing more on the implementation of business core requirements? Wouldn't it aid us to get an edge over our competition? AWS offers us a way to configure security at the infrastructure level. We have made the application load balancer(ALB) itself TLS secured. Self-signed certificates created using the OpenSSL library can be imported in AWS using IAM or AWS Certificate Manager(ACM).     

9. Security Groups:
They are acting as firewalls, filtering the traffic at the EC2 instance level. One security group is sitting on top of the ALB permitting access to only a specific set of clients. This set of clients can be configured by the user through 'Parameters' in AWS Cloudformation. A second security group is attached to the EC2 instance which enables HTTP traffic only from the load balancer and SSH traffic only from a specific set of clients. 

10. Monitoring:
AWS CloudWatch is used for monitoring purposes. The logs generated during various operations are stored in CloudWatch. If any failure is encountered, we can immediately access the logs for troubleshooting purposes.

# Deployment

Kindly refer the Readme file present at the path 'cloud-project/cloudformation/'. This file will represent steps to deploy the different cloudformation stacks.

