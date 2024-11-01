resource "google_dataproc_cluster" "mycluster" {
  name     =  var.dtp_name_cluster
  region   = var.dtp_region_cluster
  graceful_decommission_timeout = "120s"
  labels = var.dtp_labels_cluster

  cluster_config {
    staging_bucket = var.dataproc_bucket_name
    

    dynamic "master_config" {
      for_each = [var.dtp_master_config] 
      iterator = configs
      content {
        num_instances = configs.value.num_instances
        machine_type  = configs.value.machine_type

        disk_config {
          boot_disk_type    = configs.value.boot_disk_type
          boot_disk_size_gb = configs.value.boot_disk_size_gb
        }
      } 
    }

    dynamic "worker_config" {
      for_each = [var.dtp_worker_config]
      iterator = configs
      content {
        num_instances = configs.value.num_instances
        machine_type  = configs.value.machine_type
        min_cpu_platform = configs.value.min_cpu_platform
        #min_num_instances = configs.value.min_num_instances
        disk_config {
          boot_disk_size_gb = configs.value.boot_disk_size_gb
          num_local_ssds    = configs.value.num_local_ssds
        }
      }
      
    }

    dynamic "software_config" {
      for_each = [var.dtp_software_config]
      iterator = configs
      content {
        image_version = configs.value.image_version
        override_properties = configs.value.properties
      }
    }

    dynamic "gce_cluster_config" {
      for_each = [var.dtp_gce_cluster]
      iterator = config
      content {
        tags = config.value.tags
        subnetwork = config.value.subnetwork
        service_account = config.value.service_account
        service_account_scopes = config.value.service_account_scopes
        internal_ip_only = config.value.internal_ip_only
      }
    }

    preemptible_worker_config {
      num_instances = var.dtp_preemptible_worker_num_instances
    }

  }
}
