terraform {
  required_version = "~> 1.15"

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstateaad268ea2"
    container_name       = "tfstate"
    key                  = "azure-ad-automation/terraform.tfstate"
  }

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
  }
}

provider "azuread" {}
