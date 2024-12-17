provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "voting_app_iacm" {
  ami = "ami-0b0ea68c435eb488d" 
  instance_type = "t2.micro" # Got to https://aws.amazon.com/ec2/instance-types/t2/ for a full T2 instance type list.
  
  tags = {
    Name = "voting_app_iacm"
  }
}
