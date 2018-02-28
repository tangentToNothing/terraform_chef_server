variable "region" {
  type = "string"
  description = "Default AWS region for server"
  default = "us-east-1"
}

variable "Tags" {
  type = "map"
  description = "Cloud Tags"
  default = {
    Name = "Chef Server"
  }
}