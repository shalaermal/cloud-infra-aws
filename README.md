# Cloud Infrastructure on AWS with Terraform

This project provisions a basic AWS cloud infrastructure using Terraform.

It includes an EC2 instance, Security Group configuration, networking through the default VPC/subnet, and an SQS queue.

---

## Overview

The infrastructure includes:

- EC2 instance running Amazon Linux 2023
- Security Group with SSH and HTTP access
- Default VPC and default subnet usage
- Public IP assignment
- AWS SQS queue
- Simple Python HTTP server returning `Hello World`

---

## Architecture

```text
Internet
   |
Internet Gateway
   |
Default VPC / Public Subnet
   |
Security Group
   |
EC2 Instance
   |
HTTP Port 80
```

The EC2 instance starts a minimal Python web server using `user_data`.

---

## Tech Stack

- Terraform
- AWS EC2
- AWS Security Groups
- AWS SQS
- Amazon Linux 2023

---

## Project Structure

```text
.
├── providers.tf
├── variables.tf
├── locals.tf
├── network.tf
├── main.tf
├── sql.tf
├── outputs.tf
└── screenshots/
```

---

## Prerequisites

Before running this project, make sure you have:

- Terraform installed
- AWS CLI installed and configured
- An AWS account with permissions to create AWS resources

Verify AWS authentication:

```bash
aws sts get-caller-identity
```

---

## Clone Repository

```bash
git clone https://github.com/shalaermal/cloud-infra-aws.git
cd cloud-infra-aws
```

---

## Terraform Commands

### Initialize Terraform

```bash
terraform init
```

### Review Execution Plan

```bash
terraform plan
```

### Apply Infrastructure

```bash
terraform apply
```

Terraform will create:

- EC2 instance
- Security Group
- SQS queue

After deployment, Terraform outputs:

- EC2 Public IP
- SQS Queue URL

---

## Test the Application

Open the EC2 public IP in your browser:

```text
http://<instance-public-ip>
```

Expected response:

```text
Hello World
```

---

## Variables

| Variable | Description | Default |
|----------|-------------|----------|
| `project` | Project name for tagging | `aws-infra-cloud` |
| `instance_type` | EC2 instance type | `t2.micro` |
| `key_name` | EC2 SSH key pair | `null` |
| `region` | AWS region | `us-east-1` |
| `allowed_ssh_cidr` | Allowed SSH CIDR | `0.0.0.0/0` |
| `allowed_http_cidr` | Allowed HTTP CIDR | `0.0.0.0/0` |

---

## Security Note

For demo purposes, SSH access may be configured as:

```hcl
allowed_ssh_cidr = "0.0.0.0/0"
```

For better security, restrict SSH access to your own public IP:

```hcl
allowed_ssh_cidr = "YOUR_PUBLIC_IP/32"
```

If SSH is not required, leave:

```hcl
key_name = null
```

---

## Deployment Evidence

### Terraform Apply Success

![Terraform Apply](screenshots/01-terraform-apply-success.png)

Shows successful resource creation:

- EC2 instance
- Security Group
- SQS queue
- Public IP output

### EC2 Instance Running

![EC2 Instance](screenshots/02-ec2-instance-running.png)

The EC2 instance is successfully running and publicly accessible.

### Security Group Configuration

![Security Group](screenshots/03-security-group-config.png)

Inbound rules configured:

- Port 22 (SSH)
- Port 80 (HTTP)

### Route Table Configuration

![Route Table](screenshots/04-route-table-igw.png)

The default route table allows internet access through the Internet Gateway.

### Terraform Destroy

![Terraform Destroy](screenshots/05-terraform-destroy.png)

All infrastructure resources successfully removed.

---

## Destroy Infrastructure

To remove all created AWS resources:

```bash
terraform destroy
```

---

## Notes

This project demonstrates Infrastructure as Code (IaC) using Terraform on AWS.

It is intended as a lightweight cloud infrastructure example for learning, practice, and DevOps portfolio purposes.
