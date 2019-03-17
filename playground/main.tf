provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
}

data "aws_availability_zones" "available" {}

#### VPC 
resource "aws_vpc" "vpc_ans" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = true
}

#### Internet Gateway
resource "aws_internet_gateway" "ig_ans" {
  vpc_id = "${aws_vpc.vpc_ans.id}"
}

#### Route Tables
resource "aws_route_table" "rt_public_ans" {
  vpc_id = "${aws_vpc.vpc_ans.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig_ans.id}"
  }

  tags {
    Name = "public"
  }
}

resource "aws_default_route_table" "rt_private_ans" {
  default_route_table_id = "${aws_vpc.vpc_ans.default_route_table_id}"

  tags {
    Name = "private"
  }
}

#### Subnets
resource "aws_subnet" "public1_ans" {
  vpc_id                  = "${aws_vpc.vpc_ans.id}"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  cidr_block              = "${var.cidrs["public1"]}"
  map_public_ip_on_launch = true

  tags {
    Name = "public1"
  }
}

#### Subnet association
resource "aws_route_table_association" "public1_ans_assoc" {
  subnet_id      = "${aws_subnet.public1_ans.id}"
  route_table_id = "${aws_route_table.rt_public_ans.id}"
}

### Security Group
resource "aws_security_group" "sg_public_ans" {
  name        = "sg_public"
  description = "Used for public instances to ssh"
  vpc_id      = "${aws_vpc.vpc_ans.id}"

  # SSH
  ingress {
    protocol    = "tcp"
    from_port   = "22"
    to_port     = "22"
    cidr_blocks = ["${var.localip}"]
  }

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound internet traffic
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${var.localip}"]
  }
}

### Key Pair
resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

### AWS Instances

###### Ansible PlayGround Nodes
resource "aws_instance" "dev1" {
  count                  = 2
  subnet_id              = "${aws_subnet.public1_ans.id}"
  instance_type          = "${var.instance_type}"
  ami                    = "${var.ami_rhel}"
  vpc_security_group_ids = ["${aws_security_group.sg_public_ans.id}"]
  key_name               = "${aws_key_pair.auth.id}"

  tags {
    Name = "ansible-${count.index}"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_dns} >> playbooks/hosts_rhel"
  }

  #
  #provisioner "local-exec" {
  #  command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.dev.id} && ansible-playbook -i aws_hosts wordpress.yml"
  #}
  #
}

resource "aws_instance" "ubuntu" {
  count                  = 2
  subnet_id              = "${aws_subnet.public1_ans.id}"
  instance_type          = "${var.instance_type}"
  ami                    = "${var.ami_ubuntu}"
  vpc_security_group_ids = ["${aws_security_group.sg_public_ans.id}"]
  key_name               = "${aws_key_pair.auth.id}"

  tags {
    Name = "ubuntu-${count.index}"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_dns} >> playbooks/hosts_ubuntu "
  }
}

/*
###### Chef Work Station Node
data "template_file" "init" {
  template = "${file("chef_ws_init.tpl")}"
}

resource "aws_instance" "chef_ws" {
  subnet_id              = "${aws_subnet.public1_ans.id}"
  ami                    = "${var.ami_id_chef}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.sg_public_ans.id}"]
  key_name               = "${aws_key_pair.auth.id}"
  user_data = "${data.template_file.init.rendered}"

  tags {
    Name = "chef-workstation"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > aws_hosts"
  }
  # provisioner "local-exec" {
  #   command = "sudo su - && cd /tmp && curl -O https://packages.chef.io/files/stable/chefdk/2.5.3/el/7/chefdk-2.5.3-1.el7.x86_64.rpm && rpm -Uvh chefdk-2.5.3-1.el7.x86_64.rpm"
  # }  
}
*/

