# terraform-aws-ec2
provision High Availability Servers via terraform

### Objectives
- Provision infrastructure to automate deploy webserver using Terraform.
- Configure security, network, and load balancer.
- Use Ansible to change configure firewall of the webservers.

### Recall

1. Research terraform registry document
2. Create IAM users
3. Attach Security group and keypair
5. Write scrip
6. Write IAC (VPC, Security Group, EC2, Load Balancer, RDS)

### Set up

1. Write `vpc.tf` to provision virtual private cloud env used in the project. [ref](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
2. Write `provider.tf` to init terraform registry [ref](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
    1. create IAM user with programmatic functional
        1. attach to user group EC2_FullAccess
        2. Save access_id and access_key in `aws configure`
    2. run `terraform init` 
    3. run `terraform validate` to check syntax error
3. Write `ec2.tf` to provision ec2 instance based on requirements [ref](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
    1. choose your preference ami and instance_type
    2. run `terraform plan` to see which resources are going to create
    3. run `terraform apply` to provision resource
    4. run `terraform destroy` to remove infrastructure
4. Attach security group [ref](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
    1. Define Inbound and Outbound rules
    2. Attach the security group to aws_resource
    3. Create rsa.pem key pair
    4. Define key_name
5. Write `script.sh`
    1. define bootstrap to connect to webserver (Apache2)
6. Write `alb.tf` to provision application load balancer to receive request from internet and distribute load equally. [ref](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment)
7. Write configuration management in Ansible to change firewall setting. [ref](https://docs.ansible.com/ansible/latest/collections/community/general/ufw_module.html)

### Next Steps
1. Add automate testing
2. Implement state management tools like S3
3. Build CI/CD
4. Modularization and Reusability
