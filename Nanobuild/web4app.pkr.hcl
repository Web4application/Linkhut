packer {
  required_version = ">= 1.9.0"
}

locals {
  image_folder = "/Users/${var.vm_username}/web4-runner"
}

variable "vm_username" { type = string; sensitive = true }
variable "vm_password" { type = string; sensitive = true }
variable "source_vm_ip" { type = string }
variable "build_id" { type = string }
variable "artifact_storage" { type = string; default = "ipfs" }

# SSH builder (LinkHut-hosted macOS node)
source "null" "macos_web4" {
  ssh_host     = var.source_vm_ip
  ssh_username = var.vm_username
  ssh_password = var.vm_password
}

build {
  sources = ["source.null.macos_web4"]

  # bootstrap folder
  provisioner "shell" {
    inline = ["mkdir -p ${local.image_folder}"]
  }

  # upload assets
  provisioner "file" {
    source      = "${path.root}/assets/"
    destination = "${local.image_folder}/assets/"
  }

  # upload modules
  provisioner "file" {
    source      = "${path.root}/modules/"
    destination = "${local.image_folder}/modules/"
  }

  # execute tool installation modules
  provisioner "shell" {
    inline = [
      "chmod +x ${local.image_folder}/modules/tools/*.sh",
      "bash ${local.image_folder}/modules/tools/install-xcode.sh",
      "bash ${local.image_folder}/modules/tools/install-homebrew.sh",
      "bash ${local.image_folder}/modules/tools/install-node.sh",
      "bash ${local.image_folder}/modules/tools/install-python.sh",
      "bash ${local.image_folder}/modules/tools/install-rust.sh",
      "bash ${local.image_folder}/modules/tools/install-dotnet.sh"
    ]
  }

  # execute configuration modules
  provisioner "shell" {
    inline = [
      "chmod +x ${local.image_folder}/modules/configure/*.sh",
      "bash ${local.image_folder}/modules/configure/configure-tccdb.sh",
      "bash ${local.image_folder}/modules/configure/configure-shell.sh",
      "bash ${local.image_folder}/modules/configure/configure-auto-updates.sh"
    ]
  }

  # run tests and generate reports
  provisioner "shell" {
    inline = [
      "chmod +x ${local.image_folder}/modules/tests/*.sh",
      "bash ${local.image_folder}/modules/tests/run-tests.sh",
      "bash ${local.image_folder}/modules/tests/generate-report.sh"
    ]
  }

  # upload artifacts (Web4)
  provisioner "shell" {
    environment_vars = [
      "ARTIFACT_STORAGE=${var.artifact_storage}",
      "BUILD_ID=${var.build_id}"
    ]
    inline = [
      "echo 'Uploading artifacts...'",
      "if [ \"$ARTIFACT_STORAGE\" = \"ipfs\" ]; then",
      "  ipfs add -r ${local.image_folder}/modules/tests/output | tee ${local.image_folder}/artifact_hash.txt",
      "fi"
    ]
  }

  # cleanup
  provisioner "shell" {
    inline = ["rm -rf ${local.image_folder}/cache"]
  }
}
