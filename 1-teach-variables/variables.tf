# The file where you decide which variables you need to be available.
variable "image_id" {
    type = string
    default = "ami-08b26b905b0d17561"
}
variable "instance_type" {
    type = string
    default = "t2.micro"
}
variable "region" {
    type = string
    default = "us-east-1"
}
variable "app_name" {
    type = string
    default = ""
}
variable "key_name" {
    type = string
    default = ""
}