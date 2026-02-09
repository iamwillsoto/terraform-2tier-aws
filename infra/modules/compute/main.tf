data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "this" {
  count                  = length(var.public_subnet_ids)
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = var.public_subnet_ids[count.index]
  vpc_security_group_ids = [var.web_sg_id]

  user_data = templatefile(
    "${path.module}/../../userdata/wordpress.sh",
    {
      db_endpoint = var.db_endpoint
      db_name     = var.db_name
      db_username = var.db_username
      db_password = var.db_password
    }
  )

  tags = {
    Name = "${var.name_prefix}-wordpress-${count.index + 1}"
  }
}
