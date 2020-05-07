data "aws_availability_zones" "available" {}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  sizes = {
    "XXS" = "t3.nano"
    "XS" = "t3.micro"
    "S" = "t3.small"
    "M" = "t3.medium"
    "L" = "t3.large"
    "XL" = "t3.xlarge"
    "XXL" = "t3.2xlarge"
  }

  # Ensure a consistent spread of nodes across AZs.
  # Fails when nodes are removed from anywhere else but the end of the list.
  # That is why changes to "subnet_id" are ignored on the instances.
  ordered_masters = sort(keys(var.masters))
  ordered_workers = sort(keys(var.workers))

  template_params = merge(
    var.template_params,
    {
      cp_endpoint = module.lb_masters.this_lb_dns_name
    }
  )
}
