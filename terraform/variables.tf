variable "project_id" {
    type = string
}

variable "region" {
    type = string
    default = "us-central1"
}

variable "zone" {
    type = string
    default = "us-central1-b"
}

variable "network_name" {
    type = string
    default = "my vpc"
}

variable "private_network" {
    type = string
    default = "my subnet"
}