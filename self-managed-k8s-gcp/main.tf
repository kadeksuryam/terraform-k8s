resource "google_compute_instance" "k8s_node_controller" {
  count = 3
  name = "controller-${count.index}"
  machine_type = "t2d-standard-1"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size = 200
    }
  }
  can_ip_forward = true
  service_account {
    scopes = ["compute-rw", "storage-ro", "service-management", 
    "service-control", "logging-write", "monitoring"]
  }
  
  network_interface {
    network_ip = "10.240.0.1${count.index}"
    subnetwork = google_compute_subnetwork.k8s_subnet.id
  }
}

resource "google_compute_instance" "k8s_node_worker" {
  count = 3
  name = "worker-${count.index}"
  machine_type = "t2d-standard-1"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size = 200
    }
  }
  can_ip_forward = true
  service_account {
    scopes = ["compute-rw", "storage-ro", "service-management", 
    "service-control", "logging-write", "monitoring"]
  }
  
  network_interface {
    network_ip = "10.240.0.2${count.index}"
    subnetwork = google_compute_subnetwork.k8s_subnet.id
  }
}