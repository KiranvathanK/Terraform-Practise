terraform {
   backend "s3" {
   bucket         = "git-terraform-best-practices-1"
   key            = "terraform.tfstate"
   region         = "us-east-1"
   dynamodb_table = "terraform_locks"
}
}
