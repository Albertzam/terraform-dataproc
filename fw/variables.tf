
variable name_firewall_tcp_dataproc  {
  description = "Name of the firewall rule to allow tcp traffic to dataproc"
  type        = string
}

variable value_firewall_tcp_dataproc {
  description = "Value of the firewall rule to allow tcp traffic to dataproc"
  type        = string
  default     = "0-65535"  
}

variable name_tag_dataproc{
  description = "Name of the tag to apply to dataproc instances"
  type        = string
}

variable name_firewall_udp_dataproc  {
  description = "Name of the firewall rule to allow udp traffic to dataproc"
  type        = string
}


variable value_firewall_udp_dataproc {
  description = "Value of the firewall rule to allow tcp traffic to dataproc"
  type        = string
  default     = "0-65535"  
}


variable name_firewall_icmp_dataproc  {
  description = "Name of the firewall rule to allow icmp traffic to dataproc"
  type        = string
}

variable gcp_project {
  type        = string
  description = "ID del proyecto de GCP donde se crearán los componentes."
}

variable name_network_exist {
  type = string
  description = "Name of the network in the project"
}

variable name_subnetwork_exist {
  type = string
  description = "Name of subnetwork"
}

variable name_region_subnetwork {
  type = string
  description = "Region of subnetwork"
}