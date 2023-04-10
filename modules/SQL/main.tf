resource "google_compute_global_address" "private_ip_block" {
  name         = "private-ip-block"
  description  = "A block of private IP addresses that are accessible only from within the VPC."
  purpose      = "VPC_PEERING"
  address_type = "INTERNAL"
  ip_version   = "IPV4"
  # We don't specify a address range because Google will automatically assign one for us.
  prefix_length = 20 # ~4k IPs
  network       = data.google_compute_network.vpc_network.self_link
}


resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = data.google_compute_network.vpc_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_block.name]
}



resource "google_sql_database_instance" "mssql_instance" {
  name = "${var.name}-db-instance"
  database_version = "SQLSERVER_2019_EXPRESS"
  region = var.region
  root_password    = "42Gears@123"
  deletion_protection = false

    settings {
        tier = "db-custom-1-3840"
        disk_size        = 30   # specify disk size in GB
        disk_autoresize  = false # enable automatic disk resizing
        disk_type        = "PD_SSD"
        
        # Enable automatic backups
        backup_configuration {
            enabled = true
            binary_log_enabled = false
            backup_retention_settings {
                retention_unit = "COUNT"
                retained_backups = 7
            }
        }

        # Configure IP configuration
        ip_configuration {
            ipv4_enabled    = false
            private_network = data.google_compute_network.vpc_network.self_link
            
        }
        

        # Configure maintenance window
        maintenance_window {
            day  = 1
            hour = 3
        }
    }
    depends_on = [
      google_compute_global_address.private_ip_block, google_service_networking_connection.private_vpc_connection
    ]
}
resource "google_sql_user" "mssql_user" {
  name = "admin"
  instance = google_sql_database_instance.mssql_instance.name
  password = "42Gears@123"
  depends_on = [google_sql_database_instance.mssql_instance]
}

resource "google_sql_database" "mydatabase" {
  name           = "${var.name}-db"
  instance       = google_sql_database_instance.mssql_instance.name
  # charset        = "utf8"
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  depends_on     = [google_sql_user.mssql_user,google_sql_database_instance.mssql_instance]
}