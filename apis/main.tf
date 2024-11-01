resource "google_project_service" "compute" {
  project = var.gcp_project
  service = "compute.googleapis.com"
}

resource "google_project_service" "cloudresourcemanager" {
  project = var.gcp_project
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "dataproc" {
  project = var.gcp_project
  service = "dataproc.googleapis.com"
}


output "compute" {
  value = google_project_service.compute.service
  description = "Compute Engine API"
}

output "cloudresourcemanager" {
  value = google_project_service.cloudresourcemanager.service
  description = "Cloud Resource Manager API"
}

output "dataproc" {
  value = google_project_service.dataproc.service
  description = "Dataproc API"
}
