terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

module "vpc" {
  source         = "git::https://github.com/akmara1/jenkins-modules.git//vpc?ref=main"
  project = "prod"
  availability_zones_count_public = 2
  env = "prod"
}

module "eks" {
  source         = "git::https://github.com/akmara1/jenkins-modules.git//eks?ref=main"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.subnets_public
  project = "prod"
  node_groups = {  
    cluster1 = {  
      node_group_name = "test1"  
      desired_size    = 2 
      max_size        = 3
      min_size        = 1 
  
      ami_type       = "AL2_x86_64"  
    } 
  }
}
