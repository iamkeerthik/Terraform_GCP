resource "google_monitoring_dashboard" "vm_dashboard" {
  dashboard_json = <<EOF
{
  "displayName": "${var.name} VM Metrics",
  "gridLayout": {
    "columns": "3",
    "widgets": [
      {
        "title": "CPU Usage",
        "xyChart": {
          "dataSets": [{
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\" AND metric.label.instance_name=\"${var.name}-pluto\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "crossSeriesReducer": "REDUCE_MEAN",
                  "perSeriesAligner": "ALIGN_MEAN"
                }
              },
              "unitOverride": "1"
            },
            "plotType": "LINE"
          }],
          "timeshiftDuration": "0s",
          "yAxis": {
            "label": "Percentage",
            "scale": "LINEAR"
          }
        }
      },
      {
        "title": "Memory Usage",
        "xyChart": {
          "dataSets": [{
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"compute.googleapis.com/instance/memory/balloon/ram_used\" AND resource.type=\"gce_instance\" AND metric.label.instance_name=\"${var.name}-pluto\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "crossSeriesReducer": "REDUCE_MEAN",
                  "perSeriesAligner": "ALIGN_MEAN"
                }
              },
              "unitOverride": "1"
            },
            "plotType": "LINE"
          }],
          "timeshiftDuration": "0s",
          "yAxis": {
            "label": "Percentage",
            "scale": "LINEAR"
          }
        }
      },
      {
        "title": "Disk Usage",
        "xyChart": {
          "dataSets": [{
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"compute.googleapis.com/instance/disk/write_bytes_count\" AND resource.type=\"gce_instance\" AND metric.label.instance_name=\"${var.name}-pluto\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "crossSeriesReducer": "REDUCE_MEAN",
                  "perSeriesAligner": "ALIGN_MEAN"
                }
              },
              "unitOverride": "BYTE"
            },
            "plotType": "LINE"
          }],
          "timeshiftDuration": "0s",
          "yAxis": {
            "label": "Bytes",
            "scale": "LINEAR"
          }
        }
      }
    ]
  }
}
EOF
}

resource "google_monitoring_dashboard" "SQL_dashboard" {
  dashboard_json = <<EOF
{
  "displayName": "${var.name} SQL Metrics",
  "gridLayout": {
    "columns": "3",
    "widgets": [
      {
        "title": "CPU Usage",
        "xyChart": {
          "dataSets": [{
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"cloudsql.googleapis.com/database/cpu/utilization\" resource.type=\"cloudsql_database\" resource.label.database_id=\"${var.gcp_project}:${data.google_sql_database_instance.sql.id}\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "crossSeriesReducer": "REDUCE_MEAN",
                  "perSeriesAligner": "ALIGN_MEAN"
                }
              },
              "unitOverride": "1"
            },
            "plotType": "LINE"
          }],
          "timeshiftDuration": "0s",
          "yAxis": {
            "label": "Percentage",
            "scale": "LINEAR"
          }
        }
      },
      {
        "title": "Memory Utilization",
        "xyChart": {
          "dataSets": [{
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"cloudsql.googleapis.com/database/memory/utilization\" resource.type=\"cloudsql_database\" resource.label.database_id=\"${var.gcp_project}:${data.google_sql_database_instance.sql.id}\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "crossSeriesReducer": "REDUCE_MEAN",
                  "perSeriesAligner": "ALIGN_MEAN"
                }
              },
              "unitOverride": "1"
            },
            "plotType": "LINE"
          }],
          "timeshiftDuration": "0s",
          "yAxis": {
            "label": "Percentage",
            "scale": "LINEAR"
          }
        }
      },
      {
        "title": "Disk Utilization",
        "xyChart": {
          "dataSets": [{
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"cloudsql.googleapis.com/database/disk/utilization\" resource.type=\"cloudsql_database\" resource.label.database_id=\"${var.gcp_project}:${data.google_sql_database_instance.sql.id}\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "crossSeriesReducer": "REDUCE_MEAN",
                  "perSeriesAligner": "ALIGN_MEAN"
                }
              },
              "unitOverride": "1"
            },
            "plotType": "LINE"
          }],
          "timeshiftDuration": "0s",
          "yAxis": {
            "label": "Percentage",
            "scale": "LINEAR"
          }
        }
      },
       {
        "title": "No of Connections",
        "xyChart": {
          "dataSets": [{
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"cloudsql.googleapis.com/database/network/connections\" resource.type=\"cloudsql_database\" resource.label.database_id=\"${var.gcp_project}:${data.google_sql_database_instance.sql.id}\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "crossSeriesReducer": "REDUCE_MEAN",
                  "perSeriesAligner": "ALIGN_MEAN"
                }
              },
              "unitOverride": "1"
            },
            "plotType": "LINE"
          }],
          "timeshiftDuration": "0s",
          "yAxis": {
            "label": "Percentage",
            "scale": "LINEAR"
          }
        }
      }

    ]
    }
}
EOF
}

resource "google_monitoring_dashboard" "Pub_Sub_dashboard" {
  dashboard_json = <<EOF
  {
  "displayName": "${var.name} Pubsub Metrics",
  "gridLayout": {
    "columns": "3",
    "widgets": [
      {
        "title": "CPU Usage",
        "xyChart": {
        "dataSets": [
          {
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"pubsub.googleapis.com/topic/send_request_count\" resource.type=\"pubsub_topic\"",
                "aggregation": {
                  "perSeriesAligner": "ALIGN_RATE",
                  "crossSeriesReducer": "REDUCE_SUM",
                  "groupByFields": [
                    "resource.label.\"project_id\"",
                    "resource.label.\"topic_id\""
                  ]
                }
              }
            },
            "plotType": "LINE",
            "minAlignmentPeriod": "60s",
            "targetAxis": "Y1",
            "legendTemplate": ""
          }
        ],
        "chartOptions": {
          "mode": "COLOR"
        },
        "yAxis": {
          "scale": "LINEAR"
        },
        "thresholds": []
      }  
      }
    ]
  }
}
EOF
}
