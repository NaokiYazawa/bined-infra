resource "aws_security_group" "alb" {
  name        = var.aws_security_group_alb_name
  description = "For ALB."
  vpc_id      = var.vpc_id
  ingress {
    description = "Allow HTTP from ALL."
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all to outbound."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs" {
  name        = var.aws_security_group_ecs_name
  description = "For ECS."
  vpc_id      = var.vpc_id
  egress {
    description = "Allow all to outbound."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ecs_from_alb" {
  description              = "Allow Application port from Security Group for ALB."
  type                     = "ingress"
  from_port                = var.app_port
  to_port                  = var.app_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
  security_group_id        = aws_security_group.ecs.id
}

resource "aws_security_group" "rds" {
  name        = var.aws_security_group_rds_name
  description = "For RDS."
  vpc_id      = var.vpc_id
  egress {
    description = "Allow all to outbound."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "rds_from_ecs" {
  description              = "Allow RDS port from Security Group for ECS."
  type                     = "ingress"
  from_port                = var.database_port
  to_port                  = var.database_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs.id
  security_group_id        = aws_security_group.rds.id
}

resource "aws_security_group" "bastion" {
  name        = var.aws_security_group_bastion_name
  description = "For Bastion."
  vpc_id      = var.vpc_id
  ingress {
    description = "Allow SSH from ALL."
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["3.112.23.0/29"]
  }
  egress {
    description = "Allow all to outbound."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "rds_from_bastion" {
  description              = "Allow SSH port from Security Group for Bastion."
  type                     = "ingress"
  from_port                = var.database_port
  to_port                  = var.database_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id        = aws_security_group.rds.id
}
