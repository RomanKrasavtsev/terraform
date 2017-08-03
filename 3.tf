resource "aws_instance" "master-instance" {
  ami = "ami-9bf712f4"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  prevent_destroy = true
  create_before_destroy = true
}

resource "aws_instance" "slave-instance" {
  ami = "ami-9bf712f4"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  depends_on = ["aws_instance.master-instance"]
  tags {
    master_hostname = "${aws_instance.master-instance.private_dns}"
  }
  lifecycle {
    ignore_changes = ["tags"]
  }
}
