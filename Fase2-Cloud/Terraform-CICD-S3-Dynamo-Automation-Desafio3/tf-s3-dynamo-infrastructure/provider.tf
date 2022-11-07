# credentials from ~/.aws/  
provider "aws" {
  alias   = "bootcamp-tlz-account"
  region  = var.region
  profile = var.profile
}

