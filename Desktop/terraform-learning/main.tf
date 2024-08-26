
resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidrBlock

}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.sub_cidr_1
  availability_zone       = var.subnet1_azz
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.sub_cidr_2
  availability_zone       = var.subnet2_azz
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
}

resource "aws_route_table_association" "rt_association1" {
  route_table_id = aws_route_table.main_route_table.id
  subnet_id      = aws_subnet.subnet1.id
}
resource "aws_route_table_association" "rt_association2" {
  route_table_id = aws_route_table.main_route_table.id
  subnet_id      = aws_subnet.subnet2.id
}

resource "aws_security_group" "sg" {
  name   = "sg"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "mys3bucket" {
  bucket = "abhaybucket4826"
}

resource "aws_instance" "myinstance1" {
  instance_type          = "t2.micro"
  ami                    = "XXXXXXXX"
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.sg.id]

}
resource "aws_instance" "myinstance2" {
  instance_type          = "t2.micro"
  ami                    = "XXXXXXXX"
  subnet_id              = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.sg.id]
}

resource "aws_lb" "myalb" {
  name               = "myalb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.sg.id]
  subnets         = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_lb_target_group" "my_tg" {
  name     = "mytg"
  port     = 80
  protocol = "HTTP"

  vpc_id = aws_vpc.main_vpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "tgattach1" {
  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id        = aws_instance.myinstance1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "tgattach2" {
  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id        = aws_instance.myinstance2.id
}

resource "aws_lb_listener" "alb_listner" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.my_tg.arn
    type             = "forward"
  }
}
