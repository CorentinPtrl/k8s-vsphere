terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://195.201.9.14:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = "bouboule82"
  pm_parallel = 1
  pm_timeout      =  1200
}