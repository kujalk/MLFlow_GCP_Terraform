output "mlflow_url" {
  value = google_cloud_run_service.mlflow.status[0].url
}


resource "local_file" "client-cert" {
  content  = google_sql_ssl_cert.client_cert.cert
  filename = "client-cert.pem"
}

resource "local_file" "server-ca-cert" {
  content  = google_sql_ssl_cert.client_cert.server_ca_cert
  filename = "server-ca.pem"
}

resource "local_file" "private_key" {
  content  = google_sql_ssl_cert.client_cert.private_key
  filename = "client-key.pem"
}