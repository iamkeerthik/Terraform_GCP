# Define the service account
resource "google_service_account" "compute_service_account" {
  account_id   = "${var.name}-compute"
  display_name = "${var.name}-compute-service-account"
}

# Define the IAM policy for the service account
resource "google_project_iam_binding" "compute_iam_binding" {
  project = var.gcp_project
  for_each = toset([
    "roles/iam.serviceAccountUser",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
  ])
  role    = each.key
  members = [
    "serviceAccount:${google_service_account.compute_service_account.email}"
  ]
}


# Define the service account
resource "google_service_account" "k8s_service_account" {
  account_id   = "${var.name}-k8s"
  display_name = "${var.name}-k8s-service-account"
}

# Define the IAM policy for the service account
resource "google_project_iam_binding" "k8s_iam_binding" {
  project = var.gcp_project
  for_each = toset([
    "roles/iam.serviceAccountUser",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
  ])
  role    = each.key
  members = [
    "serviceAccount:${google_service_account.k8s_service_account.email}"
  ]
}
