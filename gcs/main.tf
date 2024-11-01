resource "google_storage_bucket" "dataproc" {
  name                        = var.dataproc_bucket_name
  location                    = var.location
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access
  labels                      = var.labels
  
  versioning {
    enabled = var.versioning
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy == null ? [] : [""]
    content {
      retention_period = var.retention_policy.retention_period
      is_locked        = var.retention_policy.is_locked
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    iterator = rule
    content {
      action {
        type          = rule.value.action.type
        storage_class = rule.value.action.storage_class
      }
      condition {
        age                        = rule.value.condition.age
        created_before             = rule.value.condition.created_before
        custom_time_before         = rule.value.condition.custom_time_before
        days_since_custom_time     = rule.value.condition.days_since_custom_time
        days_since_noncurrent_time = rule.value.condition.days_since_noncurrent_time
        matches_prefix             = rule.value.condition.matches_prefix
        matches_storage_class      = rule.value.condition.matches_storage_class
        matches_suffix             = rule.value.condition.matches_suffix
        noncurrent_time_before     = rule.value.condition.noncurrent_time_before
        num_newer_versions         = rule.value.condition.num_newer_versions
        with_state                 = rule.value.condition.with_state
      }
    }
  }
}

output "bucket_name" {
  value = google_storage_bucket.dataproc.name
}