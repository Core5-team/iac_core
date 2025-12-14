variable "common_tags" {
  type = map(string)
  default = {
    "CreatedBy"   = "Terraform"
    "Environment" = "stage"
    "Repository"  = "https://github.com/Core5-team/iac_core/"
    "Module"      = "s3"
  }
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}
