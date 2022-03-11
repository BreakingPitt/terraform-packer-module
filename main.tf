resource "time_static" "this" {}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    Created_by = "Terraform"
    Creation_date = time_static.this.rfc3339
    Deployed_by = "Terraform"
    Environment = var.environment
    Name = var.name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Created_by = "Terraform"
    Creation_date = time_static.this.rfc3339
    Deployed_by = "Terraform"
    Environment = var.environment
    Name = var.name
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Created_by = "Terraform"
    Creation_date = time_static.this.rfc3339
    Deployed_by = "Terraform"
    Environment = var.environment
    Name = var.name
  }
}

resource "aws_subnet" "this" {
  availability_zone       = element(data.aws_availability_zones.this.names, 0)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.cidr_block
  map_public_ip_on_launch = true

  tags = {
    Created_by = "Terraform"
    Creation_date = time_static.this.rfc3339
    Deployed_by = "Terraform"
    Environment = var.environment
    Name = var.name
  }
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}

