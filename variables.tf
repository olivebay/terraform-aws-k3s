variable "platform" {
  default     = "ubuntu"
}

variable "user" {
  default = {
    ubuntu  = "ubuntu"
  }
}

variable "ami" {
    default = {
        eu-west-1 = "ami-17d11e6e"
    }
}

variable "aws_region" {
  default     = "eu-west-1"
}

variable "count_masters" {
  default     = "1"
  description = "The number of servers nodes to launch."
}

variable "count_workers" {
  default     = "2"
  description = "The number of servers nodes to launch."
}

variable "instance_type" {
  default     = "t2.micro"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "RDS_PASSWORD" {
}


