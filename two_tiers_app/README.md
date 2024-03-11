# TWO-Tier Infrastructure in AWS using Terraform 

## Description
This project deploys a Two-Tier architecture in AWS and uses Terraform in a modular approach for reusability, maintainability , and scalability.

### Aws Services used

* Route 53
* AWS Certificate Manager (ACM)
* Web Application Firewall (WAF)
* Virtual Private Network (VPC)
* Elastic Compute Service (EC2)
* Relation Database Service (RDS)

### Architecture Diagram

#### Steps

#### Step 1: Set up the Environment and Prerequisites 
* Create AWS account
* Download Terraform from the official website (https://www.terraform.io/)
* Create ACCESS KEY SECRET KEY in AWS
* Use those keys to create your **profile** in your Command Line Interface (CLI) (https://spacelift.io/blog/terraform-aws-provider)

#### Step 2: Create Modules
 1 - Security Group module