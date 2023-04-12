data "google_compute_instance" "pluto" {
  name = "${var.name}-pluto"
  zone = var.instance_zone
}

data "google_sql_database_instance" "sql"{
  name ="${var.name}-db-instance"
}
