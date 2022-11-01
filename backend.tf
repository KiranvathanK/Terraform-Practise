terraform {
backend "s3" {
  bucket         = "terraform-best-practices"
  key            = "terraform.tfstate"
  region         = "us-east-1"
}
}
