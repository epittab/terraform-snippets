variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_region_az" {
  type    = string
  default = "us-east-1c"
}

variable "callback_url" {
  type    = string
  default = "http://localhost:5173/auth/token"
}

