
locals {
  roles_service_account_master = [
    "roles/dataproc.worker",
    "roles/storage.objectViewer",
    "roles/iam.serviceAccountUser",
    "roles/compute.instanceAdmin.v1",
    "roles/storage.objectCreator",
    "roles/storage.objectUser"
  ]
  roles_service_account_dataproc = [
    "roles/storage.insightsCollectorService",
    "roles/storage.objectViewer",
    "roles/iam.serviceAccountUser",
    "roles/compute.instanceAdmin.v1"
  ]
}

data "google_project" "project" {
}

resource "google_service_account" "service_account" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

resource "google_project_iam_member" "service_account_roles" {
  for_each = toset(local.roles_service_account_master)
  project  = var.gcp_project
  role     = each.value
  member   = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_iam_member" "service_account_roles_service_account_dataproc" {
  for_each = toset(local.roles_service_account_dataproc)
  project  = var.gcp_project
  role     = each.value
  member   = "serviceAccount:service-${data.google_project.project.number}@dataproc-accounts.iam.gserviceaccount.com"
}

output "service_account" {
  value = google_service_account.service_account.email
  description = "Service Account Email"
}

output roles_service_account {
    value = local.roles_service_account_master
    description = "Roles to be assigned to the service account"
}

output service_account_dataproc { 
    value = "service-${data.google_project.project.number}@dataproc-accounts.iam.gserviceaccount.com"
    description = "Roles to be assigned to the service account"
}

output service_account_roles_dataproc {
    value = local.roles_service_account_dataproc
    description = "Roles to be assigned to the service account"
}