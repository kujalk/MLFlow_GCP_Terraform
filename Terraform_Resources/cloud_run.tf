
resource "google_cloud_run_service" "mlflow" {
  name     = var.cloud_run_name
  location = var.location
  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "5"
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.main.connection_name
        "run.googleapis.com/client-name"        = "terraform"
      }
    }
    spec {
      service_account_name = var.keyemail
      containers {
        image = "gcr.io/${var.project_id}/${var.image_name}"

        env {
          name  = "GCP_PROJECT"
          value = var.project_id
        }
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }

}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.mlflow.location
  project  = google_cloud_run_service.mlflow.project
  service  = google_cloud_run_service.mlflow.name

  policy_data = data.google_iam_policy.noauth.policy_data
}