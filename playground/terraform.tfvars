aws_profile = "myaws"
aws_region = "us-east-1"
cidr = "10.0.0.0/16"
cidrs = {
    "public1" = "10.0.1.0/24"
    "public2" = "10.0.2.0/24"
    "private1" = "10.0.3.0/24"
    "private4" = "10.0.4.0/24"
}
localip = "0.0.0.0/0"
key_name = "kryptonite"
public_key_path = "/Users/ramad008/.ssh/kryptonite.pub"
instance_type ="t2.micro"


# Free tier eligible
# Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-0de53d8956e8dcf80 (64-bit x86) / ami-06b382aba6c5a4f2c (64-bit Arm)
# Amazon Linux AMI 2018.03.0 (HVM), SSD Volume Type - ami-0080e4c5bc078760e - image includes AWS command line tools, Python, Ruby, Perl, and Java. The repositories include Docker, PHP, MySQL, PostgreSQL, and other packages.
# Red Hat Enterprise Linux 7.6 (HVM), SSD Volume Type - ami-011b3ccf1bd6db744 (64-bit x86) / ami-0e3688b4a755ad736 (64-bit Arm)
# Ubuntu Server 18.04 LTS (HVM), SSD Volume Type - ami-0a313d6098716f372 (64-bit x86) / ami-01ac7d9c1179d7b74 (64-bit Arm)
# 
ami_id_ansible = "ami-011b3ccf1bd6db744"
ami_id_chef = "ami-011b3ccf1bd6db744"
ami_rhel = "ami-011b3ccf1bd6db744"
ami_ubuntu = "ami-0a313d6098716f372"