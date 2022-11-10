//AWS Configuration


variable "region" {}

# credentials account 
variable "profile" {}


#================================= MAIN BAKEND TF ===========================================================================
#=======================================================================================================================
# general info


variable "additional_tags" {
  default     = {}
  description = "Additional resource tags"
  type        = map(string)
}


variable "bucket-name" {}
variable "tagging" {}
