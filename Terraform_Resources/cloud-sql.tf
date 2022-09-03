resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.main.name
}

resource "google_sql_database_instance" "main" {
  name                = var.db_instance
  database_version    = "POSTGRES_14"
  region              = var.location
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name     = var.db_user
  instance = google_sql_database_instance.main.name
  password = var.db_password
}

resource "google_sql_ssl_cert" "client_cert" {
  common_name = var.db_user
  instance    = google_sql_database_instance.main.name
}