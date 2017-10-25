data "terraform_remote_state" "core" {
  backend = "azure"

  config {
    storage_account_name = "nictfremotestate"
    container_name       = "opendev"
    key                  = "core.terraform.tfstate"
  }
}

terraform {
  backend "atlas" {
    name = "nicj/terraform-opendev-application"
  }
}

provider "kubernetes" {
  host                   = "https://${data.terraform_remote_state.core.k8s_master_dns}"
  client_certificate     = "${data.terraform_remote_state.core.k8s_client_cert}"
  client_key             = "${data.terraform_remote_state.core.k8s_client_key}"
  cluster_ca_certificate = "${data.terraform_remote_state.core.k8s_cluster_ca_cert}"
}
