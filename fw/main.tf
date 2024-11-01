
data "google_compute_network" "existing_network" {
  name    = var.name_network_exist
  project = var.gcp_project
}

data "google_compute_subnetwork" "subnetwork" {
  name   = var.name_subnetwork_exist
  region = var.name_region_subnetwork
}

resource "google_compute_firewall" "dataproc_firewall" {
  name    =  var.name_firewall_tcp_dataproc
  network = data.google_compute_network.existing_network.id

  allow {
    protocol = "tcp"
    ports    = [var.value_firewall_tcp_dataproc]
  }

  source_tags = [var.name_tag_dataproc]
  target_tags   = [var.name_tag_dataproc]
}

resource "google_compute_firewall" "allow_udp" {
  name    = var.name_firewall_udp_dataproc
  network = data.google_compute_network.existing_network.id

  allow {
    protocol = "udp"
    ports    = [var.value_firewall_udp_dataproc]
  }
  source_tags = [var.name_tag_dataproc]
  target_tags   = [var.name_tag_dataproc]  
}

resource "google_compute_firewall" "allow_icmp" {
  name    = var.name_firewall_icmp_dataproc
  network = data.google_compute_network.existing_network.id

  allow {
    protocol = "icmp"
  }

 source_tags = [var.name_tag_dataproc]
  target_tags   = [var.name_tag_dataproc] 
}


output "tag_use_dataproc" {
    value = var.name_tag_dataproc
    description = "Tag to be used for dataproc instances"
}

output "firewall_tcp_dataproc" {
    value = google_compute_firewall.dataproc_firewall.name
    description = "Firewall rule to allow tcp traffic to dataproc"
}

output "firewall_udp_dataproc" {
    value = google_compute_firewall.allow_udp.name
    description = "Firewall rule to allow udp traffic to dataproc"
}

output "firewall_icmp_dataproc" {
    value = google_compute_firewall.allow_icmp.name
    description = "Firewall rule to allow icmp traffic to dataproc"
}

output "subnetwork_id" {
  value = data.google_compute_subnetwork.subnetwork.id
}