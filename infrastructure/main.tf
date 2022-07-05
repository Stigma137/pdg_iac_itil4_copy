 # Configure the AWS Provider
 provider "aws" {
   version = "~> 4.0"
   region  = var.region
 }

# ### VPC ###

# resource "aws_vpc" "main" {
#   cidr_block                     = var.vpc_cidr_block
#   enable_dns_hostnames           = var.enable_dns_hostnames
#   enable_dns_support             = var.enable_dns_support
#   enable_classiclink_dns_support = var.enable_classiclink_dns_support

#   tags = var.project_tags
# }

# ### Subnets ###

# resource "aws_subnet" "public" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = var.public_ip
#   map_public_ip_on_launch = var.map_public_ip_on_launch
#   availability_zone = data.aws_availability_zones.available.names[0]

#   tags = merge(var.project_tags, {
#     Name = "public-subnet"
#   })
# }

# resource "aws_subnet" "public1" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = var.public1_ip
#   map_public_ip_on_launch = var.map_public_ip_on_launch
#   availability_zone = data.aws_availability_zones.available.names[1]

#   tags = merge(var.project_tags, {
#     Name = "public-subnet-1"
#   })
# }

# resource "aws_subnet" "private" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = var.private_ip
#   availability_zone = data.aws_availability_zones.available.names[2]

#   tags = merge(var.project_tags, {
#     Name = "private-subnet"
#   })
# }

# resource "aws_subnet" "private1" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = var.private1_ip
#   availability_zone = data.aws_availability_zones.available.names[3]

#   tags = merge(var.project_tags, {
#     Name = "private-subnet-1"
#   })
# }

# ### Gateways ###

# resource "aws_internet_gateway" "internet_gateway" {
#   vpc_id = aws_vpc.main.id

#   tags = merge({
#     Name = "internet gw"
#   }, var.project_tags)
# }

 resource "aws_eip" "nat_gateway" {
     vpc = var.vpc
}

 resource "aws_nat_gateway" "nat_gateway" {
   allocation_id = aws_eip.nat_gateway.id
   subnet_id     = "subnet-0280ecc5985e2678a"

   tags = merge({  
     Name = "NAT gw"
   }, var.project_tags)
 }

# ### Route tables ###

# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = var.cidr_block_nat
#     gateway_id = aws_internet_gateway.internet_gateway.id
#   }

#   tags = merge(var.project_tags, {
#     Name = "main"
#   })
# }

 resource "aws_route_table" "private" {
   vpc_id = "vpc-0ed312fbac4fb2ba3"

   route {
     cidr_block = var.cidr_block_nat
     gateway_id = aws_nat_gateway.nat_gateway.id
   }

   tags = merge(var.project_tags, {
     Name = "private-route-table"
   })
 }


# resource "aws_route_table_association" "public" {
#   subnet_id      = aws_subnet.public.id
#   route_table_id = aws_route_table.public.id
# }

 resource "aws_route_table_association" "private" {
   subnet_id      = "subnet-006411107512e33d7"
   route_table_id = aws_route_table.private.id
 }

# ### Security Groups ###

# resource "aws_security_group" "public" {
#   name = var.public_secure_group_name
#   description = "Allow all neccesary traffic for the frontend"
#   vpc_id = aws_vpc.main.id

#   egress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.http_port
#     to_port    = var.http_port
#   }

#   egress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.https_port
#     to_port    = var.https_port
#   }

#   egress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.public_ip]
#     from_port  = var.ssh_port
#     to_port    = var.ssh_port

#   }

#   ingress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.api_port
#     to_port    = var.api_port
#   }

#   egress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.api_port
#     to_port    = var.api_port
#   }

#   ingress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.ui_port
#     to_port    = var.ui_port
#   }

#   egress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.ui_port
#     to_port    = var.ui_port
#   }

#   ingress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.ssh_port
#     to_port    = var.ssh_port

#   }

#   ingress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.http_port
#     to_port    = var.http_port
#   }

#   ingress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.https_port
#     to_port    = var.https_port
#   }

#   tags = merge(var.project_tags, {
#     Name = "public-security-group"
#   })
# }

# resource "aws_security_group" "private" {
#   name = var.private_secure_group_name
#   description = "Allow all neccesary traffic for the backend"
#   vpc_id = aws_vpc.main.id

#   ingress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.ssh_port
#     to_port    = var.ssh_port
#   }

#   egress {
#     protocol   = "icmp"
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = 1
#     to_port    = 2
#   }

#   ingress {
#     protocol   = "icmp"
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = 1
#     to_port    = 2
#   }

#   egress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.ssh_port
#     to_port    = var.ssh_port
#   }

#   ingress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.vpc_cidr_block]
#     from_port  = var.db_port
#     to_port    = var.db_port
#   }

#   egress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.vpc_cidr_block]
#     from_port  = var.db_port
#     to_port    = var.db_port
#   }


#   ingress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.api_port
#     to_port    = var.api_port
#   }

#   egress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.api_port
#     to_port    = var.api_port
#   }

#   ingress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.ui_port
#     to_port    = var.ui_port
#   }

#   egress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.ui_port
#     to_port    = var.ui_port
#   }

#   egress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.http_port
#     to_port    = var.http_port
#   }

#   egress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.cidr_block_nat]
#     from_port  = var.https_port
#     to_port    = var.https_port
#   }

#   egress {
#     protocol   = var.tcp_protocol
#     cidr_blocks = [var.vpc_cidr_block]
#     from_port  = var.linux_distro_port
#     to_port    = var.last_unused_port
#   }

#   tags = merge(var.project_tags, {
#     Name = "private-security-group"
#   })

# }

# data "aws_availability_zones" "available" {

# }