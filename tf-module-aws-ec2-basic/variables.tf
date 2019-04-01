##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}

#variable "private_key_path" {}

# variable "region" {
#   description = "Region in which the resources will be deployed"
#   default     = "us-east-2"
# }

variable "key_name" {
  description = "Key pair to be used on the region"

  #  default     = "devops_training_us-east-2"
}

# variable "network_address_space" {
#   description = "VPC address space"
#   default     = "10.1.0.0/16"
# }

# variable "subnet1_address_space" {
#   description = "Address space for the subnet 1"
#   default     = "10.1.0.0/24"
# }

# variable "subnet2_address_space" {
#   description = "Address space for the subnet 2"
#   default     = "10.1.1.0/24"
# }

# variable "trusted_networks" {
#   description = "Trusted networks/host attached to the sg"
#   default     = "190.240.66.234/32"
# }

# variable "aws_access_key" {
#   description = "AWS access key" #Bad practice
# }

# variable "aws_secret_key" {
#   description = "AWS secret key"
# }

##############################

variable "aws_region" {}

variable "default_tags" {
  description = "Alexis Tags"
  type        = "map"
}

variable "extra_tags" {
  type = "map"
}

variable "attach_eip" {
  default = "false"
}

variable "name" {
  description = "Name to be used on all resources as prefix"
}

variable "instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "ami" {
  description = "ID of AMI to use for the instance"
}

variable "placement_group" {
  description = "The Placement Group to start the instance in"
  default     = ""
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  default     = "default"
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  default     = ""
}

variable "instance_type" {
  description = "The type of instance to start"
}

# variable "key_name" {
#   description = "The key name to use for the instance"
#   default     = ""
# }

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = "list"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  default     = ""
}

variable "subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  default     = []
  type        = "list"
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  default     = false
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  default     = ""
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  default     = true
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = ""
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  default     = ""
}

variable "ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
  default     = 0
}

variable "ipv6_addresses" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  default     = {}
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  default     = []
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  default     = []
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  default     = []
}

variable "cpu_credits" {
  description = "The credit option for CPU usage (unlimited or standard)"
  default     = "standard"
}

variable "use_num_suffix" {
  description = "Always append numerical suffix to instance name, even if instance_count is 1"
  default     = "false"
}
