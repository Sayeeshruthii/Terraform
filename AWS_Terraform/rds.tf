resource "aws_db_subnet_group" "sayee_dbsubnetgroup" {
    name = "sayee_subnet_group"
    subnet_ids = [ aws_subnet.sayee_subnets[4].id, aws_subnet.sayee_subnets[5].id ]
    tags = {
      "Name" = "sayee db subnet group"
    }

    depends_on = [ 
        aws_subnet.sayee_subnets[4],
        aws_subnet.sayee_subnets[5]
     ]
  
}

resource "aws_db_instance" "sayee_db" {
    allocated_storage = 20
    allow_major_version_upgrade = false
    auto_minor_version_upgrade = false
    backup_retention_period = 0
    db_subnet_group_name = "sayee_subnet_group"
    engine = "mysql"
    engine_version = "8.0.20"
    instance_class = "db.t2.micro"
    name = "sayee_db"
    vpc_security_group_ids = [ aws_security_group.sayeedbsg.id]
    username = "qtdevops"
    password = "admin1234"
    tags = {
      "Name" = "sayee_db"
    }
    skip_final_snapshot  = true

    depends_on = [ 
        aws_db_subnet_group.sayee_dbsubnetgroup
     ]
  
}