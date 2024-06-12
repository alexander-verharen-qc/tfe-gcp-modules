resource "google_compute_resource_policy" "snapshot_policy" {
  name   = var.policy_name
  region = var.region

  snapshot_schedule_policy {
    dynamic "schedule" {
      for_each = var.schedule_type == "daily" ? [1] : []
      content {
        daily_schedule {
          days_in_cycle = 1
          start_time    = var.start_time
        }
      }
    }

    dynamic "schedule" {
      for_each = var.schedule_type == "weekly" ? [1] : []
      content {
        weekly_schedule {
          day_of_weeks {
            day        = var.weekly_day
            start_time = var.start_time
          }
        }
      }
    }

    snapshot_properties {
      labels = {
        snapshot-policy = var.snapshot_label
      }
    }

    retention_policy {
      max_retention_days    = var.max_retention_days
      on_source_disk_delete = "APPLY_RETENTION_POLICY"
    }
  }
}

data "google_compute_instance" "instances" {
  count = length(var.instance_zone_map)
  name  = replace(keys(var.instance_zone_map)[count.index], "_", "-")
  zone  = values(var.instance_zone_map)[count.index]
}

locals {
  instance_data_resources = [
    for idx in range(length(var.instance_zone_map)) : {
      name = replace(keys(var.instance_zone_map)[idx], "_", "-")
      zone = values(var.instance_zone_map)[idx]
      disk = data.google_compute_instance.instances[idx].boot_disk[0].device_name
    }
  ]
}

resource "google_compute_disk_resource_policy_attachment" "disk_attachment" {
  count = length(var.instance_zone_map)
  name  = google_compute_resource_policy.snapshot_policy.name
  disk  = local.instance_data_resources[count.index].disk
  zone  = local.instance_data_resources[count.index].zone
}