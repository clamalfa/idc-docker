# Configure the VMware vSphere Provider
provider "vsphere" {
  user           = "administrator@pac.lab"
  password       = "Password#1"
  vsphere_server = "10.4.44.11"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

# Create a virtual machine within the folder
resource "vsphere_virtual_machine" "isi_data_insights" {
  name   = "isi-data-insights"
  datacenter = "Datacenter"
  domain = "pac.lab"
  dns_servers = ["10.254.174.10"]
  cluster = "cluster"

  vcpu   = 4
  memory = 2048

  network_interface {
    label = "VM Network"
    ipv4_address = "10.4.44.16"
    ipv4_prefix_length = "24"
    ipv4_gateway = "10.4.44.1"
  }

  disk {
    datastore = "datastore1"
    template = "UbuntuTmpl"
    type = "thin"
  }
  provisioner "remote-exec" {
    inline = [
      "echo Password#1 | sudo mkdir /idic",
      "echo Password#1 | sudo chown ubuntu:ubuntu /idic"
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      password = "Password#1"
    }
  }
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"

    connection {
      type = "ssh"
      user = "ubuntu"
      password = "Password#1"
    }
  }
  provisioner "file" {
    source = "docker-compose.yml"
    destination = "/tmp/docker-compose.yml"
    
    connection {
      type = "ssh"
      user = "ubuntu"
      password = "Password#1"
    }
}

provisioner "file" {
    source = "Dockerfile"
    destination = "/tmp/Dockerfile"

    connection {
      type = "ssh"
      user = "ubuntu"
      password = "Password#1"
    }
  }

provisioner "file" {
    source = "start-sdk.sh"
    destination = "/idic/start-sdk.sh"

    connection {
      type = "ssh"
      user = "ubuntu"
      password = "Password#1"
    }
  }
provisioner "file" {
    source = "isi_data_insights_d.cfg"
    destination = "/idic/isi_data_insights_d.cfg"

    connection {
      type = "ssh"
      user = "ubuntu"
      password = "Password#1"
    }
  }
  provisioner "remote-exec" {
    inline = [
      "tr -d '\015' </idic/isi_data_insights_d.cfg >/idic/new_idic_d.cfg",
      "mv /idic/new_idic_d.cfg /idic/isi_data_insights_d.cfg",
      "tr -d '\015' </tmp/Dockerfile >/tmp/new_Dockerfile",
      "mv /tmp/new_Dockerfile /tmp/Dockerfile",
      "tr -d '\015' </idic/start-sdk.sh >/idic/new_start-sdk.sh",
      "mv /idic/new_start-sdk.sh /idic/start-sdk.sh",
      "sudo chmod +x /idic/start-sdk.sh",
      "tr -d '\015' </tmp/script.sh >/tmp/new_script.sh",
      "mv /tmp/new_script.sh /tmp/script.sh",
      "sudo chmod +x /tmp/script.sh",
      "sudo -S /tmp/script.sh"
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      password = "Password#1"
    }
  }
}
 