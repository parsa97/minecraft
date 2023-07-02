data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter_name
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vspehre_template_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "default" {
  for_each = {
      for vm in var.vsphere_vms: vm.name => vm
    }
  name             = each.value.name
  folder           = var.vsphere_folder_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = each.value.cpus
  memory           = each.value.memory
  guest_id         = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    thin_provisioned = false
    size  = each.value.root_disk_size
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = each.value.name
        domain    = var.vsphere_vm_domain_name
      }
      network_interface {
        ipv4_address = each.value.ipv4
        ipv4_netmask = each.value.netmask
      }
      ipv4_gateway = each.value.gateway
      dns_server_list = var.vsphere_dns_servers
    }
  }
}
