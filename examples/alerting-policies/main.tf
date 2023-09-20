locals {
  labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

module "lcloud_monitoring" {
  source = "git@git.lcloud.pl:internal/solutions/monitoring-hub/central-monitoring-gcp-client-resources.git"

  endpoint    = var.endpoint
  environment = var.environment
}

/*
 * https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy.html
 */

resource "google_monitoring_alert_policy" "vm_cpu_utlization_policy_normal" {
  display_name = "${var.environment}--vm-cpu-utilization-normal"
  combiner     = "OR"
  enabled      = true

  notification_channels = [
    module.lcloud_monitoring.monitoring_notification_channel_id
  ]

  conditions   {
    display_name      = "VM Instance - High CPU utilization"

    condition_threshold {
      filter          = "resource.type=\"gce_instance\" AND metric.type=\"compute.googleapis.com/instance/cpu/utilization\""
      threshold_value = "0.75"
      comparison      = "COMPARISON_GT"
      duration        = "0s"
      aggregations {
        alignment_period    = "300s"
        per_series_aligner  = "ALIGN_MEAN"
      }
      trigger {
        count = 1
      }
    }
  }

  user_labels  = merge({
    snstopicname  = "lcloud-s4_mon-fri_10-18"
  }, local.labels)
}

resource "google_monitoring_alert_policy" "vm_cpu_utlization_policy_urgent" {
  display_name = "${var.environment}--vm-cpu-utilization-urgent"
  combiner     = "OR"
  enabled      = true

  notification_channels = [
    module.lcloud_monitoring.monitoring_notification_channel_id
  ]

  conditions   {
    display_name      = "VM Instance - High CPU utilization"

    condition_threshold {
      filter          = "resource.type=\"gce_instance\" AND metric.type=\"compute.googleapis.com/instance/cpu/utilization\""
      threshold_value = "0.9"
      comparison      = "COMPARISON_GT"
      duration        = "0s"
      aggregations {
        alignment_period    = "300s"
        per_series_aligner  = "ALIGN_MEAN"
      }
      trigger {
        count = 1
      }
    }
  }

  user_labels  = merge({
    snstopicname  = "lcloud-s1_mon-fri_10-18"
  }, local.labels)
}
