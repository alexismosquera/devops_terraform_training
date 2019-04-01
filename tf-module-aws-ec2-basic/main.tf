##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "AlexisVPC"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.7.0"

  name        = "example"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["190.240.66.234/32"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "1.19.0"

  user_data                   = "${var.user_data}"
  tenancy                     = "${var.tenancy}"
  ephemeral_block_device      = "${var.ephemeral_block_device}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  disable_api_termination     = "${var.disable_api_termination}"

  #vpc_security_group_ids               = "${var.vpc_security_group_ids}"
  vpc_security_group_ids               = ["${module.security_group.this_security_group_id}"]
  #vpc_security_group_ids = []

  iam_instance_profile                 = "${var.iam_instance_profile}"
  root_block_device                    = "${var.root_block_device}"
  ebs_optimized                        = "${var.ebs_optimized}"
  ipv6_address_count                   = "${var.ipv6_address_count}"
  private_ip                           = "${var.private_ip}"
  instance_type                        = "${var.instance_type}"
  placement_group                      = "${var.placement_group}"
  volume_tags                          = "${var.volume_tags}"
  tags                                 = "${merge(var.default_tags,var.extra_tags)}"
  ami                                  = "${var.ami}"
  name                                 = "${var.name}"
  ebs_block_device                     = "${var.ebs_block_device}"
  network_interface                    = "${var.network_interface}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  instance_count                       = "${var.instance_count}"
  cpu_credits                          = "${var.cpu_credits}"
  subnet_id                            = "${var.subnet_id}"
  source_dest_check                    = "${var.source_dest_check}"
  subnet_ids                           = "${var.subnet_ids}"
  key_name                             = "${var.key_name}"
  use_num_suffix                       = "${var.use_num_suffix}"
  monitoring                           = "${var.monitoring}"
  ipv6_addresses                       = "${var.ipv6_addresses}"
}

# resource "aws_eip" "eip" {
#   count    = "${var.attach_eip ? 1 : 0}"
#   vpc      = true
#   instance = "${module.ec2.id[0]}"
# }

##################################################################################
# DATA
##################################################################################

# data "aws_availability_zones" "available" {}

# ##################################################################################
# # RESOURCES
# ##################################################################################

# # NETWORKING #
# resource "aws_vpc" "vpc" {
#   cidr_block           = "${var.network_address_space}"
#   enable_dns_hostnames = "true"

#   tags = {
#     Name        = "VPC Alexis"
#     Description = "VPC 10.1.0.0/16"
#   }
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = "${aws_vpc.vpc.id}"
# }

# resource "aws_subnet" "subnet1" {
#   cidr_block              = "${var.subnet1_address_space}"
#   vpc_id                  = "${aws_vpc.vpc.id}"
#   map_public_ip_on_launch = "true"
#   availability_zone       = "${data.aws_availability_zones.available.names[0]}"
# }

# resource "aws_subnet" "subnet2" {
#   cidr_block              = "${var.subnet2_address_space}"
#   vpc_id                  = "${aws_vpc.vpc.id}"
#   map_public_ip_on_launch = "true"
#   availability_zone       = "${data.aws_availability_zones.available.names[1]}"
# }

# # ROUTING #
# resource "aws_route_table" "rtb" {
#   vpc_id = "${aws_vpc.vpc.id}"

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = "${aws_internet_gateway.igw.id}"
#   }
# }

# resource "aws_route_table_association" "rta-subnet1" {
#   subnet_id      = "${aws_subnet.subnet1.id}"
#   route_table_id = "${aws_route_table.rtb.id}"
# }

# resource "aws_route_table_association" "rta-subnet2" {
#   subnet_id      = "${aws_subnet.subnet2.id}"
#   route_table_id = "${aws_route_table.rtb.id}"
# }

# # SECURITY GROUPS #
# # Nginx security group 
# resource "aws_security_group" "nginx_sg" {
#   name        = "nginx_sg"
#   description = "Nginx Security Group"
#   vpc_id      = "${aws_vpc.vpc.id}"
# }

# # SSH access from Alexis Laptop
# resource "aws_security_group_rule" "ssh_Alexis" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["${var.trusted_networks}"]
#   security_group_id = "${aws_security_group.nginx_sg.id}"
#   description       = "ssh ingress from Alexis laptop"
# }

# # HTTP access from anywhere
# resource "aws_security_group_rule" "http_Alexis" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   cidr_blocks       = ["${var.trusted_networks}"]
#   security_group_id = "${aws_security_group.nginx_sg.id}"
#   description       = "http ingress from Alexis laptop"
# }

# resource "aws_security_group_rule" "egress_all" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = "${aws_security_group.nginx_sg.id}"
#   description       = "All ports open for egress traffic"
# }

# # INSTANCES #
# resource "aws_instance" "nginx1" {
#   ami                    = "ami-02bcbb802e03574ba"
#   instance_type          = "t2.micro"
#   subnet_id              = "${aws_subnet.subnet1.id}"
#   vpc_security_group_ids = ["${aws_security_group.nginx_sg.id}"]

#   key_name = "${var.key_name}"

#   connection {
#     agent = true
#     user  = "ec2-user"

#     #  private_key = "${file(var.private_key_path)}"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo amazon-linux-extras install nginx1.12 -y",

#       #    "sudo yum install nginx -y",
#       #    "sudo service nginx start",     
#       "systemctl start nginx",

#       "echo '<html><head><title>Blue Team Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">Blue Team</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html",
#     ]
#   }
# }

##################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
  value = "${module.ec2.key_name}"
}
