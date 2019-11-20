# terraform-aws-k3s

**Note: requires Terraform v0.12**


Provision a k3s server node and two workers nodes on AWS eu-west-1 using an Ubuntu image spread across each availability zones.

For the AWS credentials I am using the default location in $HOME/.aws/credentials. 

AWS Infrastructure

```
platform: Ubuntu
user: using `ubuntu` user to connect to the instances
ami: instance AMI ID (default: ami-17d11e6e; in eu-west-1)
instance_type: AWS instance type (default: t2.micro)
aws_vpc: main VPC in 10.0.0.0/16 range
aws_subnet: list of subnet ranges (public: ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"], private: ["10.0.4.0/24", "10.0.5.0/24"])
availability_zones: (default: ["eu-west-1a", "eu-west-1b", "eu-west-1c"])
```

Database

```
name: name of the RDS DB (default: k3sdb)
user: username used to connect to the RDS database (default: root)
RDS_PASSWORD: password used to connect to the RDS database (required)
```

Export the db pass like so: 

```
TF_VAR_RDS_PASSWORD=password
```
