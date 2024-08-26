<img width="521" alt="Screenshot 2024-08-26 at 3 30 39 PM" src="https://github.com/user-attachments/assets/5aa464e3-63a5-4af3-80bf-e30cf1b176fa">


# AWS-Infrastructure-Automation-with-Terraform
Automated AWS Infrastructure Deployment with Terraform: VPC, EC2, Load Balancer, and S3 Integration
This project showcases the automation of AWS infrastructure using Terraform. It involves setting up a VPC with public subnets, deploying EC2 instances, configuring a load balancer for traffic distribution, and integrating with an S3 bucket for storage. Terraform automates the creation and management of these resources, making the entire deployment process efficient and repeatable

VPC (Virtual Private Cloud):

The entire setup is within a VPC. This virtual network is dedicated to your AWS account, where you can launch AWS resources in a logically isolated section.
Subnets:

The VPC is divided into two public subnets. These subnets are public because they are likely associated with an Internet Gateway, allowing instances within them to have public IP addresses and access the Internet.
EC2 Instances:

There are two EC2 instances within these public subnets. EC2 (Elastic Compute Cloud) instances represent the virtual servers where applications run.
Elastic Load Balancer (ELB):

The load balancer is represented by the orange icon between the EC2 instances. It distributes incoming application traffic across multiple EC2 instances, increasing availability and fault tolerance.
Amazon S3:

An S3 bucket is connected to the infrastructure. S3 (Simple Storage Service) is used to store and retrieve any amount of data at any time. The connection suggests that the EC2 instances may be interacting with the S3 bucket, possibly for storing or retrieving data.
Route Tables and Routing:

The route tables and routing are implied in the image but not explicitly shown. These are associated with the subnets and VPC to control the traffic flow within the network.
CIDR Blocks:

On the left side, you see the CIDR blocks 172.16.0.0, 172.16.1.0, and 172.16.2.0. These represent IP address ranges assigned to the subnets within the VPC.
Explanation:
This diagram represents a typical scenario where Terraform is used to create and manage AWS infrastructure. In this case:

Terraform would define the VPC, subnets, EC2 instances, load balancer, and S3 bucket.
The public subnets allow the EC2 instances to be accessible over the internet, often used for web servers or load balancers.
The load balancer distributes traffic between the EC2 instances to ensure no single instance is overwhelmed, providing better scalability and availability.
S3 is used for data storage, accessible by the EC2 instances, perhaps for hosting a static website, storing logs, or serving static assets.
This setup is commonly used for deploying web applications on AWS, where the application servers (EC2) are publicly accessible and interact with S3 for storage purposes. Terraform automates the provisioning and configuration of all these resources, making it easier to manage infrastructure as code.
