# Cloud Infrastructure - AWS

This project provisions a basic cloud environment on AWS using Terraform to demonstrate Infrastructure as Code (IaC) principles.  

The setup includes a compute resource (EC2), networking (default VPC + security group), and a message broker (SQS).  

---

## Architecture Overview
- **Compute**: EC2 instance (Amazon Linux 2023) running a minimal Python web service on port 80, returning JSON.  
- **Networking**:  
  - Default VPC for simplicity.  
  - Security Group with ingress rules for SSH (22), HTTP (80), and HTTPS (443).  
  - Egress open to all (0.0.0.0/0).  
- **Message Broker**: Amazon SQS Queue for basic message brokering.
- **User Data**: Runs a minimal Python HTTP server returning "Hello World"    
- **Outputs**:  
  - EC2 Public IP  
  - SQS Queue URL  

![Architecture](architecture.PNG)
---

## Key Design and Tooling Decisions

- **Default VPC**: Used to minimize complexity(for production a custom VPC with public/private subnets, NAT, and load balancer would be preferable).  
- **Compute**: EC2 instance (t2.micro) chosen as the simplest way to demonstrate a running service.  
- **Web Service**: Python’s built-in HTTP server serving "Hello World" (minimal, no external dependencies).  
- **Message Broker**: Amazon SQS queue included to meet task requirements (fully managed and free-tier friendly).  
- **Security Groups**: Opened 22/80/443 to 0.0.0.0/0 for demo simplicity (would restrict to IPs in production).  
- **AMI**: Amazon Linux 2023 pulled from SSM Parameter Store (always up to date, no hardcoding AMI IDs).  
- **Terraform IaC**: Infrastructure written in Terraform and split into logical files (network, compute, sqs, variables, outputs, etc).  
- **Variables & Locals**: Ensure consistent naming, tagging, and easy changes.  
- **Tags**: Applied for clarity and cost tracking.  
- **Outputs**: Expose EC2 IP/DNS and SQS URL for quick testing and verification.  

---

## Trade-offs & Assumptions

- **Security Groups**: Ports 22/80/443 left open to 0.0.0.0/0 for demo purposes.  
    In production these would be restricted to known IPs.  
- **Default VPC**: Used to keep the code short and simple.  
    In production a dedicated VPC with public/private subnets, NAT, and ALB would be used.  
- **Compute Choice**: EC2 chosen as the simplest way to run a Python service.  
    In production, containers (ECS/Fargate) or serverless (Lambda) could reduce ops overhead.
- **SSH Access**: Key pair set to null by default.  
    No SSH required for this demo, but can be enabled if needed.  
- **Free Tier**: Instance type (t2.micro) and services chosen to stay within AWS free tier.  
    Larger instance types or managed services would be used in production workloads. 
- **High Availability**: Single AZ + single instance for demo.  
    In production, multi-AZ deployment with auto-scaling would ensure resilience.  
- **TLS/HTTPS**: Not configured for this demo.  
    In production, traffic would be served over HTTPS via ACM certs + load balancer.  
- **Monitoring/Logging**: Not included in this example.  
    In production, CloudWatch logs/metrics and alarms would be configured.  
- **Web Service**: A minimal “Hello World” service was used only to demonstrate that the instance can run an application.  
    In production, a proper framework would be deployed.
- **Minimal Architecture**: Focused only on task requirements (compute + broker).  
    In production, networking layers, IAM roles, and more advanced design would be needed. 



---

## Setup Instructions
1. Prerequisites
Before running this project, ensure the following are installed and configured:
- [Terraform](https://developer.hashicorp.com/terraform/downloads) 

  Verify installation:  
  ```bash
  terraform -version
- [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

  Verify installation:
  ```bash
  aws --version
- An AWS account with permissions to use:
  - **EC2** (for instance provisioning)
  - **VPC** (read access to the default VPC and subnets)
  - **SQS** (create queue)
  - **IAM** (permissions to use your own credentials)  
  - **SSM Parameter Store** (read access to fetch the latest Amazon Linux 2023 AMI)

2. First-time AWS setup: Configure AWS credentials (one-time setup). 
   - **AWS credentials** (Access Key ID + Secret Access Key)  
  These should be generated from your AWS account.

   Using AWS CLI:

   ```bash
   aws configure
   Enter values when prompted:
   AWS Access Key ID: <your-access-key>
   AWS Secret Access Key: <your-secret-key>
   Default region name: us-east-1
   Default output format: json
   
  Credentials will be stored under ~/.aws/credentials (Linux/Mac) or C:\Users\<you>\.aws\credentials (Windows).

3. Verify your credentials to ensure they are valid:
   ```bash
    aws sts get-caller-identity

   Example output:
     {
        "UserId": "AIDAEXAMPLEID",
        "Account": "123456789012",
        "Arn": "arn:aws:iam::123456789012:user/YourUser"
      }

---
## Run Instructions
1. Clone the repository and enter the project folder:
   ```bash
   git clone https://github.com/esmerehoti/devops-challenge-terraform.git
   cd devops-challenge-terraform
2. Initialize Terraform:
   ```bash
   terraform init
3. Validate the configuration:
   ```bash
   terraform validate
4. Preview what will be created:
   ```bash
   terraform plan
5. Deploy the resources(optional):
   ```bash
   terraform apply
6. Destroy resources to avoid charges(optional):
   ```bash
   terraform destroy
7. Test the web service after apply:
   ```bash
   curl http://<instance_public_ip>/
