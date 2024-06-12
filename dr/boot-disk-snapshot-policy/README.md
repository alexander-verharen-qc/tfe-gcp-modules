# `boot-disk-snapshot_policy` Terraform Module

## Overview

The `boot-disk-snapshot_policy` module allows you to create and manage scheduled snapshot policies for Google Compute Engine (GCE) instance boot disks, whether managed or unmanaged. This module supports both daily and weekly snapshot schedules, providing flexibility to suit your requirements. The secondary purpose is to assist with a boot disk backup prior to executing patch updates.

## Features

- Create boot disk snapshot policies for GCE instances.
- Schedule snapshots either daily or weekly.
- Automatically handle instance name transformation from underscores to dashes.
- Attach snapshot policies to the inferred boot disks of specified instances.
- Input of instance names and zones works for unmanaged instances

## Usage

### Prerequisites

- Ensure you have the [Google Cloud SDK](https://cloud.google.com/sdk) installed and authenticated.
- Set up Terraform and configure it to use your Google Cloud project.

### Example Usage

#### Daily Snapshot Schedule

```hcl
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

locals {
  instance_zone_map = {
    "ps_cen_dc_01"  = "us-central1-a"
    "ps_cen_monitor" = "us-central1-b"
    "ps_cen_scc_01"  = "us-central1-c"
  }
}

module "snapshot_policy_daily_us_central1_os_patch_updates" {
  source             = "../modules/boot-disk-snapshot-policy" # ensure you update the path to your module!
  policy_name        = "daily-us-central1-os-patch-updates"
  region             = "us-central1"
  start_time         = "18:00"
  max_retention_days = 60
  instance_zone_map  = local.instance_zone_map
  snapshot_label     = "daily-us-central1-os-patch-updates"
  schedule_type      = "daily"
}
```
#### Weekly Snapshot Schedule
```hcl
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

locals {
  instance_zone_map = {
    "ps_cen_dc_01"  = "us-central1-a"
    "ps_cen_monitor" = "us-central1-b"
    "ps_cen_scc_01"  = "us-central1-c"
  }
}

module "snapshot_policy_weekly_us_central1_os_patch_updates" {
  source             = "../modules/boot-disk-snapshot-policy" # ensure you update the path to your module!
  policy_name        = "weekly-us-central1-os-patch-updates"
  region             = "us-central1"
  start_time         = "18:00"
  max_retention_days = 60
  instance_zone_map  = local.instance_zone_map
  snapshot_label     = "weekly-us-central1-os-patch-updates"
  schedule_type      = "weekly"
  weekly_day         = "WEDNESDAY"
}
```
## Module Inputs

| Name                | Description                                            | Type   | Default     | Required |
|---------------------|--------------------------------------------------------|--------|-------------|----------|
| `policy_name`       | The name of the snapshot policy                        | string | n/a         | yes      |
| `region`            | The region where the snapshot policy will be created   | string | `us-central1` | no       |
| `start_time`        | The start time of the snapshot (HH:MM format)          | string | `15:00`     | no       |
| `max_retention_days`| The maximum number of days to retain snapshots         | number | `60`        | no       |
| `instance_zone_map` | Mapping of instance names to their respective zones    | map(string) | n/a       | yes      |
| `snapshot_label`    | Label for the snapshot policy                          | string | n/a         | yes      |
| `schedule_type`     | Type of snapshot schedule (`daily` or `weekly`)        | string | `daily`     | no       |
| `weekly_day`        | Day of the week for weekly snapshots (e.g., `MONDAY`)  | string | `MONDAY`    | no       |

## Module Outputs

| Name                | Description                                     |
|---------------------|-------------------------------------------------|
| `snapshot_policy_name` | The name of the created snapshot policy        |
| `attached_disks`    | Details of the disks to which the policy is attached |
