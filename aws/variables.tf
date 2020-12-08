# variable defines the 'region' variable. 
variable "region" {
  description = "the region of the instance"
  default     = "us-west-2" # default makes the region variable optional. 
  # If default is not set, the variables must be set:
  # 1. In a `terraform.tfvars` or `*.auto.tfvars` file
  # 2. With the `-var` flag (eg. `terraform apply -var 'region=us-west-2')
  # 3. With exported shell variables prefixed with `TF_VAR` (eg. `export TF_VAR_region = "us-west-2")
  # 4. Terraform CLI UI (will prompt after `terraform apply`)
}

# variable amis is a map from the region to our preferred ami in that region
variable "amis" {
  description = "a miap of ami's available for each supported region"
  type        = map(string) # type is implicitly defined by the defauly value, but if no default is present this can enforce the type needed in `terraform.tfvars`
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-fc0b939c"
  }
}
