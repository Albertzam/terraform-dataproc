variable gcp_region {
  type        = string
  description = "Region de GCP donde se crearán los componentes."
}

variable gcp_project {
  type        = string
  description = "ID del proyecto de GCP donde se crearán los componentes."
}


variable dataproc_bucket_name {
  description = "Name to bucket use dataproc"
  type        = string
}

variable nw_name_subnetwork {
  description = "Name of the network in the project"
  type        = string
}

variable nw_region_subnetwork {
  description = "Region of the subnetwork in the project to use instances"
  type        = string
}

variable name_tag_dataproc{
  description = "Name of the tag to apply to dataproc instances"
  type        = string
}

variable name_firewall_udp_dataproc  {
  description = "Name of the firewall rule to allow udp traffic to dataproc"
  type        = string
}

variable name_firewall_icmp_dataproc  {
  description = "Name of the firewall rule to allow icmp traffic to dataproc"
  type        = string
}


variable name_firewall_tcp_dataproc  {
  description = "Name of the firewall rule to allow tcp traffic to dataproc"
  type        = string
}

variable name_network_exist {
  type = string
  description = "Name of the network in the project"
}

variable name_subnetwork_exist {
  type= string
}

variable name_region_subnetwork {
  type=string

}