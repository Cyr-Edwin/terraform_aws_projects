# Access S3 bucket from EC2 Instance using IAM Role with Terraform

<h6> Services Used</h6>

* Simple Storage Service (S3)

* Elastic Compute Service (EC2)

<h6> Key Concepts<h6>

1 - **Session Manager**

> AWS Systems Manager Session Manager is a managed resource that allows users to manage, access, and troubleshoot EC2 instances

2 - **for_each**

> Meta-argument accepts a **map**/**set** of **strings**, and creates an instance for each item in that map or set.


3 - **fileset**

> Enumerates a set of regular file names with a path and pattern given. **fileset(path, pattern)**

4 - **iam_instance_profile**

> Provide  IAM instance profile to EC2