resource "google_secret_manager_secret" "mlflow_artifact_url" {
  secret_id = "mlflow_artifact_url"

  labels = {
    label = "mlflow_artifact_url"
  }

  replication {
    user_managed {
      replicas {
        location = var.location
      }
    }
  }
}

resource "google_secret_manager_secret_version" "mlflow_artifact_url" {
  secret      = google_secret_manager_secret.mlflow_artifact_url.id
  secret_data = google_storage_bucket.bucket.url
}

resource "google_secret_manager_secret" "mlflow_database_url" {
  secret_id = "mlflow_database_url"

  labels = {
    label = "mlflow_database_url"
  }

  replication {
    user_managed {
      replicas {
        location = var.location
      }
    }
  }
}

resource "google_secret_manager_secret_version" "mlflow_database_url" {
  secret      = google_secret_manager_secret.mlflow_database_url.id
  secret_data = "postgresql+psycopg2://${var.db_user}:${var.db_password}@/${var.db_name}?host=/cloudsql/${var.project_id}:${var.location}:${var.db_instance}"
}


resource "google_secret_manager_secret" "mlflow_tracking_username" {
  secret_id = "mlflow_tracking_username"

  labels = {
    label = "mlflow_tracking_username"
  }

  replication {
    user_managed {
      replicas {
        location = var.location
      }
    }
  }
}

resource "google_secret_manager_secret_version" "mlflow_tracking_username" {
  secret      = google_secret_manager_secret.mlflow_tracking_username.id
  secret_data = var.mlflow_tracking_username
}

resource "google_secret_manager_secret" "mlflow_tracking_password" {
  secret_id = "mlflow_tracking_password"

  labels = {
    label = "mlflow_tracking_password"
  }

  replication {
    user_managed {
      replicas {
        location = var.location
      }
    }
  }
}

resource "google_secret_manager_secret_version" "mlflow_tracking_password" {
  secret      = google_secret_manager_secret.mlflow_tracking_password.id
  secret_data = var.mlflow_tracking_password
}