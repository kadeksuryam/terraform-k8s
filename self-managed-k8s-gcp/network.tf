resource "google_compute_network" "k8s_vpc" {
  name = "k8s-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "k8s_subnet" {
  name = "k8s-subnet"
  ip_cidr_range = "10.240.0.0/24"
  network = google_compute_network.k8s_vpc.id
}

resource "google_compute_firewall" "k8s_sg_allow_internal" {
  name = "k8s-sg-allow-internal"
  network = google_compute_network.k8s_vpc.id

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.240.0.0/24", "10.200.0.0/16"]
}

resource "google_compute_firewall" "k8s_sg_allow_external" {
  name = "k8s-sg-allow-external"
  network = google_compute_network.k8s_vpc.id

  allow {
    protocol = "tcp"
    ports = ["22", "6433"]
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "k8s_api_server_address" {
  name = "k8s-api-server-address"
}
