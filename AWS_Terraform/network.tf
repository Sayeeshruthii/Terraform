resource "aws_vpc" "sayeevpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      "Name" = "sayee_vpc"
    }
  
}

//looping subnets
 resource "aws_subnet" "sayee_subnets" {
     //Developer can increase count
     count = local.count
     
     vpc_id = aws_vpc.sayeevpc.id
     //cidrsubnet("10.0.0.0/16",newbits,number)
     cidr_block = cidrsubnet(var.vpc_cidr,8,count.index)
     //concatenate region name + logic
     availability_zone = "${var.region}${count.index %2 == 0 ? "a" : "b"}"

     tags = {
       "Name" = local.subnets[count.index]
     }

    //waits till VPC is created
     depends_on = [
       aws_vpc.sayeevpc
     ]
  
 }