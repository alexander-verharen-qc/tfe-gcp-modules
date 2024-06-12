output "snapshot_policy_name" {
  value = google_compute_resource_policy.snapshot_policy.name
}

output "attached_disks" {
  value = google_compute_disk_resource_policy_attachment.disk_attachment
}