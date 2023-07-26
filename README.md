# terraform-aws-ec2
provision ec2 via terraform

### Recall

1. Research terraform registry doc
2. Create IAM users
3. Write IAC

### Notes

1. Write `provider.tf` to init terraform registry [read more](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
    1. create IAM user with programmatic functional
        1. attach to user group EC2_FullAccess
        2. Save access_id and access_key in `aws configure`
    2. run `terraform init` 
    3. run `terraform validate` to check syntax error
2. Write `ec2.tf` to provision ec2 instance based on requirements [read more](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
    1. choose your preference ami and instance_type
    2. run `terraform plan` to see which resources are going to create
    3. run `terraform apply` to provision resource
    4. run `terraform destroy` to remove infrastructure
