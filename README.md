# terraform-aws-ec2
provision ec2 via terraform

### Objectives
- Provision VM on AWS EC2 instance by using Terraform.

### Recall

1. Research terraform registry document
2. Create IAM users
3. Attach Security group and keypair
4. Write scrip
5. Write IAC

### Set up

1. Write `provider.tf` to init terraform registry [ref](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
    1. create IAM user with programmatic functional
        1. attach to user group EC2_FullAccess
        2. Save access_id and access_key in `aws configure`
    2. run `terraform init` 
    3. run `terraform validate` to check syntax error
2. Write `ec2.tf` to provision ec2 instance based on requirements [ref](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
    1. choose your preference ami and instance_type
    2. run `terraform plan` to see which resources are going to create
    3. run `terraform apply` to provision resource
    4. run `terraform destroy` to remove infrastructure
3. Attach security group [ref](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
    1. Define Inbound and Outbound rules
    2. Attach the security group to aws_resource
    3. Create rsa.pem key pair
    4. Define key_name
4. Write `script.sh`
    1. define bootstrap to connect to webserver (Apache2)
