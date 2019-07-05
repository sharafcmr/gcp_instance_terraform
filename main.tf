

resource "google_compute_instance" "sharaftfsbxnode" {
  count        = "${var.node_count}"
  name         = "iaac-test-node-${count.index}"
  machine_type = "n1-standard-2"
  zone         = "asia-south1-a"

metadata = {
    ssh-keys = "sharafudheen:${file("~/.ssh/id_rsa_gcp_nix_paas_sbx.pub")}"
  }

  can_ip_forward = true
  tags = ["webserver","centos"]
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7-v20180523"
      type    = "pd-standard"
      size    = "20"
    }
  }
  scheduling {
    preemptible = true
    automatic_restart = false
  }
  network_interface {
    network = "default"
    access_config {
     /* count = "0" */
    }
  }
  scratch_disk {
  }
  metadata_startup_script = "${file("bootstrap.sh")}"
  service_account {
    scopes = ["compute-rw"]
  }
}
