# Variables for the SME-DIMZ WordPress deployment

variable "aws_region" {
  default = "eu-north-1"
}

variable "project_name" {
  default = "sma-dimz-wordpress"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "root_volume_size" {
  default = 20
}

variable "key_pair_name" {
  description = "Name of your existing EC2 key pair"
  type        = string
}

variable "ssh_allowed_cidrs" {
  description = "IP addresses allowed to SSH in. Change this to your own IP."
  default     = ["0.0.0.0/0"]
}

variable "enable_cloudfront" {
  description = "Set to true if you want to add CloudFront in front of the site"
  default     = false
}
