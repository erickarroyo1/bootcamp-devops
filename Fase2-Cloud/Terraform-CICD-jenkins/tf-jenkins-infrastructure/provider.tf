# credentials from ~/.aws/  
provider "aws" {
  alias   = "bootcamp-tlz-account"
  region  = var.region
  profile = var.profile
}

# credentials from ~/.aws/  
provider "aws" {
  alias   = "lulox-sandbox"
  region  = var.region
  profile = var.profile-sandbox
}
