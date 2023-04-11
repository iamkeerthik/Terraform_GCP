# Define a monitoring policy for the Windows VM
resource "google_monitoring_notification_channel" "email" {
  display_name = "Email for Windows VM alerts"
  type         = "email"
  labels = {
    email_address = "keerthik.shenoy@42gears.com"
  }
}

resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = "My Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "High CPU Usage"
    condition_threshold {
      filter     = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\" AND metric.label.instance_name=\"${var.name}-pluto\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = "80"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  conditions {
    display_name = "High Disk Usage"
    condition_threshold {
      filter     = "metric.type=\"compute.googleapis.com/instance/disk/write_bytes_count\" AND resource.type=\"gce_instance\" AND metric.label.instance_name=\"${var.name}-pluto\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = "100000"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }
  conditions {
    display_name = "High Memory Usage"
    condition_threshold {
      filter     = "metric.type=\"compute.googleapis.com/instance/memory/balloon/ram_used\" AND resource.type=\"gce_instance\" AND metric.label.instance_name=\"${var.name}-pluto\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = "1000000000"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }
notification_channels = [ google_monitoring_notification_channel.email.id ]
  user_labels = {
    severity = "high"
  }
}