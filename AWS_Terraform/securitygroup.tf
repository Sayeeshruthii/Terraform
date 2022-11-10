#create security group for webapp
resource "aws_security_group" "sayee_webSG" {
    name = "sayee_webSG"
    vpc_id = aws_vpc.sayeevpc.id
    description = "Open SSH and HTTP for web"
    ingress  {
      cidr_blocks = [local.anywhere]
      description = "open ssh for web"
      from_port = "22"
      protocol = "tcp"
      to_port = "22"
    } 
    ingress  {
      cidr_blocks = [local.anywhere]
      description = "open http for web"
      from_port = "80"
      protocol = "tcp"
      to_port = "80"
    } 

    egress{
     cidr_blocks = [local.anywhere]
      description = "open all for web"
      from_port = 0
      protocol = -1
      to_port = 0
    }
    tags = {
      "name" = "sayee_webSG"
    }

}

# Create app security group
resource "aws_security_group" "sayee_appsg" {
  name = "sayee_appsg"
  description = "open port 8080 and 22 within vpc"
  vpc_id = aws_vpc.sayeevpc.id

  ingress {
    cidr_blocks = [ var.vpc_cidr ]
    description = "open ssh port"
    from_port = local.ssh
    protocol = local.tcp
    to_port = local.ssh
  }

  ingress {
    cidr_blocks = [ var.vpc_cidr ]
    description = "open app port"
    from_port = local.appport
    protocol = local.tcp
    to_port = local.appport
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "sayee_appsg"
  }

  depends_on = [ aws_route_table.sayee_privatert, aws_route_table.sayee_publicrt ]
  
}

# Create db security group
resource "aws_security_group" "sayeedbsg" {
  name = "sayeedbsg"
  description = "open port 3306 within vpc"
  vpc_id = aws_vpc.sayeevpc.id

  ingress {
    cidr_blocks = [ var.vpc_cidr ]
    description = "open app port"
    from_port = local.dbport
    protocol = local.tcp
    to_port = local.dbport
  }

  tags = {
    "Name" = "sayee_dbsg"
  }

   depends_on = [ aws_route_table.sayee_privatert, aws_route_table.sayee_publicrt ]
  
  
}