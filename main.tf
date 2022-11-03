resource "aws_key_pair" "terraform_best_practices_demo" {
  key_name   = "terraform-best-practices-demo-key"
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}
resource "aws_instance" "e1" {
  ami           = var.instance_1_ami
  instance_type = var.instance_1_type
  tags = {
    Name = var.instance_1_name
  }
}

resource "aws_instance" "e2" {
  ami           = var.instance_2_ami
  instance_type = var.instance_2_type
  tags = {
    Name = var.instance_2_name
  }
  provisioner "local-exec" {
    command    = "echo The IP address of the Server is ${self.private_ip}"
    on_failure = continue
  }
}

module "website_s3_bucket_1" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_name = var.website_s3_bucket_1_name

  tags = {
    Terraform   = var.terraform
    Environment = var.environment
  }
	
}

module "website_s3_bucket_2" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_name = var.website_s3_bucket_2_name

  tags = {
    Terraform   = var.terraform
    Environment = var.environment

  }
	
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform_locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
