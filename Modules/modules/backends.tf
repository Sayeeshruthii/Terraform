terraform {
  backend "s3"{
      bucket = "terraformsayee"
      key = "environments/terraform.tfstate"
      region = "us-west-2"
      dynamodb_table = "terraformsayee"
  }
}