
locals {
  is_windows = substr(pathexpand("~"), 0, 1) == "/" ? false : true
}

resource "null_resource" "script" {
  provisioner "local-exec" {
    command = <<EOT
    docker build -t "${var.image_name}" .
    docker tag "${var.image_name}" "gcr.io/${var.project_id}/${var.image_name}:latest"
    docker push "gcr.io/${var.project_id}/${var.image_name}:latest"
EOT

    working_dir = "Docker"
    interpreter = local.is_windows ? ["PowerShell", "-Command"] : []
  }
}
