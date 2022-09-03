resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.admin"
  members = [
    "serviceAccount:${var.keyemail}",
  ]
}

resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location      = "US"
  storage_class = "STANDARD"
  force_destroy = true
}