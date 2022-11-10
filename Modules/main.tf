provider "aws" {

region = "us-east-1"

}

module "s3" {
    source = "./modules/s3"
}

module "dynamodb" {

    source = "./modules/dynamodb"
    dynamodbname = module.s3.s3name

  
}