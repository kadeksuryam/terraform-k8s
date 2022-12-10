resource "google_container_cluster" "k8s_cluster" {
  name     = "${var.project_id}-gke"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "node_pool" {
  name       = "${google_container_cluster.k8s_cluster.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.k8s_cluster.name
  node_count = var.gke_num_nodes

  node_config {
    machine_type = var.machine_type
  }
}
