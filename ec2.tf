# data "aws_ssm_parameter" "amzn2_ami" {
#   name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
# }

# module "ec2" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name = "bastion-server-dev"

#   ami                         = data.aws_ssm_parameter.amzn2_ami.value
#   instance_type               = "t2.micro"
#   availability_zone           = "ap-northeast-1a"
#   subnet_id                   = element(module.network.public_subnets, 0)
#   vpc_security_group_ids      = [module.security_groups.security_group_bastion_id]
#   associate_public_ip_address = true
# }
