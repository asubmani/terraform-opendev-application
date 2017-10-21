data "terraform_remote_state" "core" {
  backend = "azure"
  config {
    storage_account_name = "nictfremotestate"
    container_name       = "opendev"
    key                  = "core.terraform.tfstate"
  }
}

provider "kubernetes" {
  host       = "https://${data.terraform_remote_state.core.k8s_master_dns}"
}
