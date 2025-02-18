resource "proxmox_vm_qemu" "k8s_master" {
  name        = "kubemaster"
  clone       = "ubuntu-24.04.1-server"
  target_node = "PVE-CHAD"

  cpu     = "kvm64"
  sockets = 1
  cores   = 4
  memory  = 8192

  os_type = "cloud-init"
  qemu_os = "l26"
  agent   = 1
  scsihw  = "virtio-scsi-pci"
  onboot  = true
  tags = "k8s,coco"
  ciuser         = "debian"
  cipassword     = "debian"
  ipconfig0      = "ip=192.168.100.50/24,gw=192.168.100.1"
  sshkeys        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDkebhEnRhrN6/NvW9LiY+5cLpe9H0Hr+DE7DYMOlrNUb0TCfN43lMFAIVQ05/z9jNlNkqJf8zx5MvVlusr0YrATbjiYADzV7RGp0uKu57M4Bvvjc06LHKAPwWfJhUZmaCKeVtzclm9FjTqTRN062gKzuzVN4BG8y6S23PCfVSiRrwddmthGr0EO1XK9jZ0GBBET+GhK03GyJdnf1o38dVJWF6suZTekW4AI4Y3SFGRN0LoU1xSr7W+74/955Tc/jxbDi0riXvda3OZkTq6R9kDFgFAO5DKgkbENsKEYdGZflburoeEyyIsvAYMD/7FMvg/jGN9jX7mNPD9rQkCnGDJVzmjD0bprXriUvuSHJqjt3aJ7Ue/mbgQ6uL7HsY0nFii9iERs4m+Je09qGHk97HOiKK/Wdg1nO5P5cstNFIRb6GAIH4RhxWqKlFK42x8ObjSXSO9xuvX9b8U3nh61Fx6aMJS8aOdfGDDF9iZ7VRLIYDRlCzqirPFUYTe7PB+678= corentin@as-arch"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage    = "local"
          size       = "50G"
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = "vxCHAD"
    mtu = 1350
  }

  lifecycle {
    ignore_changes = [
      clone,
      pool,
      ciuser,
      disks[0].scsi[0].scsi0[0].disk[0].storage,
    ]
  }
}

resource "proxmox_vm_qemu" "k8s_slaves" {
  count = 3

  name        = "kubeslave${count.index}"
  clone       = "ubuntu-24.04.1-server"
  target_node = "PVE-CHAD"

  cpu     = "kvm64"
  sockets = 1
  cores   = 4
  memory  = 8192

  tags = "k8s,coco"
  os_type = "cloud-init"
  qemu_os = "l26"
  agent   = 1
  scsihw  = "virtio-scsi-pci"
  onboot  = true

  ciuser         = "debian"
  cipassword     = "debian"
  ipconfig0      = "ip=192.168.100.${51 + count.index}/24,gw=192.168.100.1"
  sshkeys        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDkebhEnRhrN6/NvW9LiY+5cLpe9H0Hr+DE7DYMOlrNUb0TCfN43lMFAIVQ05/z9jNlNkqJf8zx5MvVlusr0YrATbjiYADzV7RGp0uKu57M4Bvvjc06LHKAPwWfJhUZmaCKeVtzclm9FjTqTRN062gKzuzVN4BG8y6S23PCfVSiRrwddmthGr0EO1XK9jZ0GBBET+GhK03GyJdnf1o38dVJWF6suZTekW4AI4Y3SFGRN0LoU1xSr7W+74/955Tc/jxbDi0riXvda3OZkTq6R9kDFgFAO5DKgkbENsKEYdGZflburoeEyyIsvAYMD/7FMvg/jGN9jX7mNPD9rQkCnGDJVzmjD0bprXriUvuSHJqjt3aJ7Ue/mbgQ6uL7HsY0nFii9iERs4m+Je09qGHk97HOiKK/Wdg1nO5P5cstNFIRb6GAIH4RhxWqKlFK42x8ObjSXSO9xuvX9b8U3nh61Fx6aMJS8aOdfGDDF9iZ7VRLIYDRlCzqirPFUYTe7PB+678= corentin@as-arch"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage    = "local"
          size       = "50G"
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = "vxCHAD"
    mtu = 1350
  }

  lifecycle {
    ignore_changes = [
      clone,
      pool,
      ciuser,
      disks[0].scsi[0].scsi0[0].disk[0].storage,
    ]
  }
}