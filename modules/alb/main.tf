data "aws_elb_service_account" "main" {}

# ==================================
# S3 Bucket for ALB
# ==================================
resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  idle_timeout       = 60
  subnets            = var.public_subnet_ids
  security_groups    = [var.security_group_alb_id]

  access_logs {
    bucket  = aws_s3_bucket.alb_log.id
    prefix  = "alb"
    enabled = true
  }
}

# ==================================
# ALB Target Group
# ==================================
resource "aws_lb_target_group" "main" {
  name                 = var.alb_target_group_name
  vpc_id               = var.vpc_id
  port                 = 80
  target_type          = "ip"
  protocol             = "HTTP"
  deregistration_delay = 300
  health_check {
    path                = "/healthz"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
  }
  depends_on = [
    aws_lb.main
  ]
}

# ==================================
# S3 Bucket for ALB log
# ==================================
resource "aws_s3_bucket" "alb_log" {
  bucket = var.alb_log_name
}

resource "aws_s3_bucket_lifecycle_configuration" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  rule {
    id = aws_s3_bucket.alb_log.id
    filter {
      prefix = "logs/"
    }
    expiration {
      days = 365
    }
    status = "Enabled"
  }
}

# ==================================
# S3 Bucket Policy for ALB log
# ==================================
resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]
    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.main.arn]
    }
  }
}

# ==================================
# HTTP LoadBalancer Listener
# ==================================
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}


# ==================================
# HTTP LoadBalancer Listener Rule
# ==================================
resource "aws_lb_listener_rule" "main" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
