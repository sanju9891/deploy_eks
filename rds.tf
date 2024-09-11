resource "aws_db_subnet_group" "rds_subnet" {
    name = "rds-subnet-group"
    subnet_ids = aws_subnet.private_subnet.*.id
    tags = {
      Name = "rds-subnet-group"
    }
}

resource "aws_db_instance" "default" {
    allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    name = "mydb"
    username = "admin"
    password = "password"
    db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    publicy_accessible = false
    skip_final_snapshot = true
    tags = {
      Name = "my-rds-instance"
    }
}

resource "aws_security_group" "rds_sg" {
    vpc_id = aws_vpc.my_vpc.id
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "rds-security-group"
    }
}