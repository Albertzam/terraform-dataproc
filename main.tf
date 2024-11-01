module "apis" {
  source = "./apis"
  gcp_project = var.gcp_project
  gcp_region = var.gcp_region
}

module "fw" {
  source = "./fw"
  name_tag_dataproc = var.name_tag_dataproc
  name_firewall_tcp_dataproc = var.name_firewall_tcp_dataproc
  name_firewall_icmp_dataproc = var.name_firewall_icmp_dataproc
  name_firewall_udp_dataproc = var.name_firewall_udp_dataproc
  gcp_project = var.gcp_project
  name_network_exist = var.name_network_exist
  name_subnetwork_exist = var.name_subnetwork_exist
  name_region_subnetwork = var.name_region_subnetwork
}

module "gcs" {
  source = "./gcs"
  dataproc_bucket_name = var.dataproc_bucket_name
}

module "service_account" {
  source = "./sa"
  gcp_project = var.gcp_project
  gcp_region = var.gcp_region
}

module "dataproc" {
  depends_on = [module.gcs, module.service_account, module.fw]
  source = "./dataproc"
  nw_name_subnetwork = var.nw_name_subnetwork
  nw_region_subnetwork = var.nw_region_subnetwork
  dataproc_bucket_name = module.gcs.bucket_name
  dtp_region_cluster = var.gcp_region
  dtp_name_cluster = "mycluster"
  dtp_gce_cluster = {
    internal_ip_only = true
    service_account = module.service_account.service_account
    service_account_scopes = ["cloud-platform"]
    tags = [module.fw.tag_use_dataproc]
    subnetwork = module.fw.subnetwork_id
  }
}