variable "policy_name" {
  description = "The name of the snapshot policy"
  type        = string
}

variable "region" {
  description = "The region where the snapshot policy will be created"
  type        = string
  default     = "us-central1"
}

variable "start_time" {
  description = "The start time of the snapshot (HH:MM format)"
  type        = string
  default     = "15:00"
}

variable "max_retention_days" {
  description = "The maximum number of days to retain snapshots"
  type        = number
  default     = 60
}

variable "instance_zone_map" {
  description = "Mapping of instance names to their respective zones"
  type        = map(string)
}

variable "snapshot_label" {
  description = "Label for the snapshot policy"
  type        = string
}

variable "schedule_type" {
  description = "Type of snapshot schedule ('daily' or 'weekly')"
  type        = string
  default     = "daily"
}

variable "weekly_day" {
  description = "Day of the week for weekly snapshots (e.g., 'MONDAY', 'TUESDAY')"
  type        = string
  default     = "MONDAY"
}
