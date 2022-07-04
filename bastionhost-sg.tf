//API for collecting IP
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

//security.tf
resource "aws_security_group" "ingress-all-test" {
name = "bastion-host-sg"
vpc_id = module.vpc.vpc_id
ingress {
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}
