terraform {
  backend "s3" {
    bucket = "demo-lab-docker "
    key    = "img/"
    region = "us-east-1"
  }
}