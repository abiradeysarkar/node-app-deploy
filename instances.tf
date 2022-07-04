module "ec2_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "bastion-host"

  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  key_name               = "AWS-upgrad"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ingress-all-test.id]
  subnet_id              = module.vpc.public_subnets[2]

  tags = {
    Terraform   = "true"
  }
}
module "ec2_jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "jenkins-host"

  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  key_name               = "AWS-upgrad"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ingress-all.id]
  subnet_id              = module.vpc.private_subnets[1]

  tags = {
    Terraform   = "true"
  }
}
module "ec2_app" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "app-host"

  ami                    = "ami-08d4ac5b634553e16"
  instance_type          = "t2.micro"
  key_name               = "AWS-upgrad"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ingress-all.id]
  subnet_id              = module.vpc.private_subnets[1]

  tags = {
    Terraform   = "true"
  }
}