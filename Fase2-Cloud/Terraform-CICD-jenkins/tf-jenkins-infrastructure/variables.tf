//AWS Configuration


variable "region" {}

// Availability zones for the region
variable "az1" {}

variable "az2" {}

// VPC for FortiGate Security VPC
variable "vpc-security-cidr" {}

# credentials account 
variable "profile" {}



#Subnets

variable "security-vpc-subnet-public1" {}

variable "security-vpc-subnet-public2" {}


// License Type to create FortiGate-VM

// Provide the license type for FortiGate-VM Instances, either byol or payg.
variable "license_type" {
  default = "payg"
}

// AMIs are for FGTVM-AWS(PAYG) - 7.2.0
variable "ubuntu" {
  type = map(any)
  default = {
    us-east-1      = "ami-08c40ec9ead489470"
    us-east-2      = "ami-0c89751940e00028a"
    us-west-1      = "ami-027023effe0d0cbcb"
    us-west-2      = "ami-0a70f5380706e13ac"
    af-south-1     = "ami-0020b49aee42aac43"
    ap-east-1      = "ami-040df30827808387e"
    ap-southeast-3 = "ami-08b193fa0e26053bc"
    ap-south-1     = "ami-03ce0208e1bf0a4c2"
    ap-northeast-3 = "ami-0dba0e863219fbd2c"
    ap-northeast-2 = "ami-01966ce84e55ce9af"
    ap-southeast-1 = "ami-0abcebf6fa84ec1c9"
    ap-southeast-2 = "ami-0d4a09cac89f2cb2b"
    ap-northeast-1 = "ami-08e9a008d439bd92d"
    ca-central-1   = "ami-0f575e9fe174cc613"
    eu-central-1   = "ami-09b319a3f356c62a3"
    eu-west-1      = "ami-096800910c1b781ba"
    eu-west-2      = "ami-0e0cf6ee5949311d3"
    eu-south-1     = "ami-00c0fd80460334680"
    eu-west-3      = "ami-0a2f70eeaccb4f756"
    eu-north-1     = "ami-0980a6c5462eb20c7"
    me-south-1     = "ami-0e971c7104d9ab577"
    sa-east-1      = "ami-0f857d7ef57d996d7"
  }
}

variable "pathpublickey" {}


variable "size" {}

//  Existing SSH Key on the AWS 
variable "keyname" {}

//  Admin HTTPS access port and firewall config
variable "adminsport" {
  default = "443"
}

variable "bootstrap-jenkins" {}

variable "bucket-name" {}
variable "kms-name" {}

variable "domain_name" {
  description = "domain name (or application name if no domain name available)"
}
