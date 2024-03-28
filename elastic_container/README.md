# Launch an Application on Elastic Container Service (ECS) with Terraform

## Overview
This project demonstrates the usage of serverless compute to save time and cost with ECS Fargate during the launch of an Application

### Service used

* Elastic Container Service (ECS)

#### Elastic Container Service 
![alt text](image.png)

1- **What is ECS?**

ECS is a managed containers orchestrator. It can be put in the same family as Docker Swarm and Kubernetes. Orchestrator means managing the lifecycle of containers(create/restart, destroy) , deploying , load-balancing application traffic accross multiple servers , and autoscaleing to handle variance in traffic

2- **What is ECS cluster?**

![alt text](image-1.png)

Ecs cluster is a set of resources that containers will run on. Those resources are based of EC2 virtual machines

3- **ECS launch types**

    - EC2 launch type : customers manage the underlying EC2 instances
    
    - Fargate launch type: AWS manage the underlying infrastructure


4 - **ECS components**

    - ECS Task Definition:   template that describes how container(s) are supposed to be launched

    ![alt text](image-2.png)

    - ECS Task :  running containers with instruction defined in the Task Definition

    ![alt text](image-3.png)

     - ECS Services : ensures that a certain number of Tasks are running at all the times

     ![alt text](image-4.png)

     - ECS and Load Balancer: LB can be assigned to route external traffic to your Service

     ![alt text](image-5.png)

