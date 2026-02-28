resource "aws_instance" "web" {
  ami                    = data.aws_ssm_parameter.al2023.value
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = var.key_name
  associate_public_ip_address = true

  tags = {
  Name = "${var.project}-web"
  }

# Latest Amazon Linux 2023 AMI(x86_64) via SSM
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

# Pick a default subnet from the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

  # Minimal Python web server serving "Hello World"
  user_data = <<EOF
  #!/bin/bash
  dnf -y install python3
  echo "Hello World" > /home/ec2-user/index.html
  cd /home/ec2-user
  nohup python3 -m http.server 80 --bind 0.0.0.0 >/var/log/web.log 2>&1 &
  EOF

}