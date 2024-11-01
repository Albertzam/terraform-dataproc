
variable gcp_region {
  default     = "us-central1"
  type        = string
  description = "Region de GCP donde se crearán los componentes."
}

variable gcp_project {
  default     = "sandbox-second"
  type        = string
  description = "ID del proyecto de GCP donde se crearán los componentes."
}


variable force_destroy {
  description = "Optional map to set force destroy keyed by name, defaults to false."
  type        = bool
  default     = true
}

variable iam {
  description = "IAM bindings in {ROLE => [MEMBERS]} format."
  type        = map(list(string))
  default     = {
    "roles/storage.objectViewer" = ["user:albertozmfim@gmail.com"],
  }
}

variable labels {
  description = "Labels to be attached to all buckets."
  type        = map(string)
  default     = {}
}

variable lifecycle_rules {
  description = "Bucket lifecycle rule."
  type = map(object({
    action = object({
      type          = string
      storage_class = optional(string)
    })
    condition = object({
      age                        = optional(number)
      created_before             = optional(string)
      custom_time_before         = optional(string)
      days_since_custom_time     = optional(number)
      days_since_noncurrent_time = optional(number)
      matches_prefix             = optional(list(string))
      matches_storage_class      = optional(list(string)) # STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE, DURABLE_REDUCED_AVAILABILITY
      matches_suffix             = optional(list(string))
      noncurrent_time_before     = optional(string)
      num_newer_versions         = optional(number)
      with_state                 = optional(string) # "LIVE", "ARCHIVED", "ANY"
    })
  }))
  default  = {}
  nullable = false
  validation {
    condition = alltrue([
      for k, v in var.lifecycle_rules : v.action != null && v.condition != null
    ])
    error_message = "Lifecycle rules action and condition cannot be null."
  }
  validation {
    condition = alltrue([
      for k, v in var.lifecycle_rules : contains(
        ["Delete", "SetStorageClass", "AbortIncompleteMultipartUpload"],
        v.action.type
      )
    ])
    error_message = "Lifecycle rules action type has unsupported value."
  }
  validation {
    condition = alltrue([
      for k, v in var.lifecycle_rules :
      v.action.type != "SetStorageClass"
      ||
      v.action.storage_class != null
    ])
    error_message = "Lifecycle rules with action type SetStorageClass require a storage class."
  }
}

variable location {
  description = "Bucket location."
  type        = string
  default     = "us-central1"
}

variable logging_config {
  description = "Bucket logging configuration."
  type = object({
    log_bucket        = string
    log_object_prefix = optional(string)
  })
  default = null
}

variable name {
  description = "Bucket name suffix."
  type        = string
  default     ="sandbox-second"
}


variable prefix {
  description = "Optional prefix used to generate the bucket name."
  type        = string
  default     = null
  validation {
    condition     = var.prefix != ""
    error_message = "Prefix cannot be empty, please use null instead."
  }
}

variable project_id {
  description = "Bucket project id."
  type        = string
  default     = "sandbox-second"
}

variable retention_policy {
  description = "Bucket retention policy."
  type = object({
    retention_period = number
    is_locked        = optional(bool)
  })
  default = null
}

variable storage_class {
  description = "Bucket storage class."
  type        = string
  default     = "STANDARD"
  validation {
    condition     = contains(["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "Storage class must be one of STANDARD, NEARLINE, COLDLINE, ARCHIVE."
  }
}

variable uniform_bucket_level_access {
  description = "Allow using object ACLs (false) or not (true, this is the recommended behavior) , defaults to true (which is the recommended practice, but not the behavior of storage API)."
  type        = bool
  default     = true
}

variable versioning {
  description = "Enable versioning, defaults to false."
  type        = bool
  default     = false
}

variable dataproc_bucket_name {
  description = "Name to bucket use dataproc"
  type        = string
}


