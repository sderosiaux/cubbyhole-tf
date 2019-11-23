provider "google" {
  version = ">2.10"

  credentials = file(var.gcp_credentials_file)

  project = var.gcp_project_id
  region = var.gcp_region
  zone = var.gcp_zone
}

//resource "google_compute_network" "vpc_network" {
//  name = "tf-network"
//}
//
//resource "google_compute_instance" "my-vm" {
//  machine_type = var.machine_types[var.environment]
//  name = "tf-instance"
//  boot_disk {
//    initialize_params {
//      image = "cos-cloud/cos-stable"
//    }
//  }
//  provisioner "local-exec" {
//    command = "echo ${google_compute_instance.my-vm.name}: ${google_compute_instance.my-vm.network_interface[0].access_config[0].nat_ip} >> ip_address.txt"
//  }
//
//  network_interface {
//    network = module.network.network_name
//    subnetwork = module.network.subnets_names[0]
//    access_config {
//      // dependency seen by Terraform, no need of "depends_on"
//      nat_ip = google_compute_address.my-static-ip.address
//    }
//  }
//  tags = [
//    "web",
//    "dev"]
//}
//
//resource "google_compute_address" "my-static-ip" {
//  name = "tf-static-ip"
//}

module "mymod" {
  source = "./mymod"
}
//
//module "network" {
//  source = "terraform-google-modules/network/google"
//  version = "1.5.0"
//
//  network_name = "tf-vpc-net"
//  project_id = var.gcp_project_id
//  subnets = [
//    {
//      subnet_name = "subnet-01"
//      subnet_ip = var.cidrs[0]
//      subnet_region = var.gcp_region
//    },
//    {
//      subnet_name = "subnet-02"
//      subnet_ip = var.cidrs[1]
//      subnet_region = var.gcp_region
//      subnet_private_acces = "true"
//    }
//  ]
//
//
//  secondary_ranges = {
//    "subnet-01" = []
//    "subnet-02" = []
//  }
//}