terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.4.1"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

terraform {
  backend "s3" {
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
  }
}

