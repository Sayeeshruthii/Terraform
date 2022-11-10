resource "aws_internet_gateway" "sayeeigw" {
    vpc_id = aws_vpc.sayeevpc.id

    tags = {
      "Name" = "sayee_igw"
    }

    depends_on = [
      aws_vpc.sayeevpc
    ]
  
}

resource "aws_route_table" "sayee_publicrt" {

    vpc_id = aws_vpc.sayeevpc.id
    route{
        cidr_block = local.anywhere
        gateway_id = aws_internet_gateway.sayeeigw.id
    } 

    depends_on = [
    aws_vpc.sayeevpc,
    aws_subnet.sayee_subnets[0],
    aws_subnet.sayee_subnets[1]
    ]

    tags = {
      "Name" = "sayee_publicrt"
    }
}

resource "aws_route_table_association" "sayee_webrtassociation" {

    count = 2
    route_table_id = aws_route_table.sayee_publicrt.id
    subnet_id = aws_subnet.sayee_subnets[count.index].id

    depends_on = [
      aws_route_table.sayee_publicrt
    ]
}

# create private route table
resource "aws_route_table" "sayee_privatert" {
  vpc_id = aws_vpc.sayeevpc.id
  tags = {
      "Name" = "sayee_privatert"
    }

  depends_on = [ 
    aws_vpc.sayeevpc,
    aws_subnet.sayee_subnets[2],
    aws_subnet.sayee_subnets[3],
    aws_subnet.sayee_subnets[4],
    aws_subnet.sayee_subnets[5],
   ]

  
}


# create private route table associations
resource "aws_route_table_association" "sayee_privateassociation" {

  count = 4
  route_table_id = aws_route_table.sayee_privatert.id
  subnet_id =  aws_subnet.sayee_subnets[count.index + 2].id

  depends_on = [ 
    aws_route_table.sayee_privatert
   ]

}