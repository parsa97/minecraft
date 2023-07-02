variable "vsphere_server" {
  description = "Vsphere server address"
  type        = string
}

variable "vsphere_password" {
  description = "Vsphere password"
  type        = string
}

variable "vsphere_user" {
  description = "Vsphere user"
  type        = string
}

variable "vsphere_folder_name" {
  description = "Vsphere folder name under datacenter"
  type        = string
  default     = null
}

variable "vsphere_datacenter_name" {
  description = "Vsphere datacenter name"
  type        = string
}

variable "vsphere_datastore_name" {
  description = "Vsphere datastore name"
  type        = string
}

variable "vsphere_cluster_name" {
  description = "Vsphere cluster name"
  type        = string
}

variable "vsphere_network_name" {
  description = "Vsphere network name"
  type        = string
}

variable "vspehre_template_name" {
  description = "Vsphere template name"
  type        = string
}

variable "vsphere_vm_domain_name" {
  description = "Vsphere virtual machine domain name"
  type        = string
}

variable "vsphere_dns_servers" {
  description = "Vsphere virtual macnine default dns servers"
  type        = list(string)
  default     = ["8.8.8.8","1.1.1.1"]
}

variable "vsphere_vms" {
  description = "List of vcenter vms"
  type                   = list(object({
    name                 = string
    cpus                 = number
    memory               = number
    root_disk_size       = number
    ipv4                 = string
    netmask              = number
    gateway              = string
  }))
  default = []
}
