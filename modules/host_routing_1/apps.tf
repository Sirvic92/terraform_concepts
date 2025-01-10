resource "aws_instance" "app_instances" {
  count         = var.no_instances
  ami           = data.aws_ami.amazon_linux_2022.id
  instance_type = var.instance_type

  subnet_id = element(var.private_subnet_ids, count.index)

  security_groups = [
    aws_security_group.app_security_group.id, # Attach the app security group
  ]
  key_name = "window-pair" 
  user_data = <<-EOF
              #!/bin/bash
              # Install Apache
              yum update -y
              yum install -y httpd
              service httpd start
              chkconfig httpd on

              # Change background color based on instance count index
              INSTANCE_COLOR=""
              if [ ${count.index} -eq 0 ]; then
                INSTANCE_COLOR="rgba(173, 216, 230, 0.9)" # Light blue with 90% opacity
              elif [ ${count.index} -eq 1 ]; then
                INSTANCE_COLOR="rgba(144, 238, 144, 1)" # Light green with full opacity
              else
                INSTANCE_COLOR="rgba(255, 255, 0, 0.7)" # Yellow with 70% opacity
              fi

              # Create an HTML file with the background color and instance IP address
              echo "<html><head><style>body { background-color: $INSTANCE_COLOR; }</style></head><body>" > /var/www/html/index.html
              echo "<h1>Instance IP: $(hostname -I)</h1>" >> /var/www/html/index.html
              echo "</body></html>" >> /var/www/html/index.html
              EOF

  tags = merge(var.tags, {
    Name = format("%s-%s-%s", var.tags["environment"], var.tags["project"], count.index + 1)
  })
}


# Attaching EC2 Instances to respective Target Groups
resource "aws_lb_target_group_attachment" "blue_attachment" {
  target_group_arn = aws_lb_target_group.blue.arn
  target_id        = aws_instance.app_instances[0].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "green_attachment" {
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = aws_instance.app_instances[1].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "yellow_attachment" {
  target_group_arn = aws_lb_target_group.yellow.arn
  target_id        = aws_instance.app_instances[2].id
  port             = 80
}

resource "aws_route53_record" "blue_cname" {
  zone_id = "Z044792516DN6EM1D3IHF"
  name    = "blue.sirvictech.com"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.app_alb.dns_name]
}

resource "aws_route53_record" "green_cname" {
  zone_id = "Z044792516DN6EM1D3IHF"
  name    = "green.sirvictech.com"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.app_alb.dns_name]
}

resource "aws_route53_record" "yellow_cname" {
  zone_id = "Z044792516DN6EM1D3IHF"
  name    = "yellow.sirvictech.com"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.app_alb.dns_name]
}