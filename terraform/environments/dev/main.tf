
resource "random_id" "suffix" {
  byte_length = 4
}

# Setup VPC
module "cohere-vpc" {
  source    = "../../modules/network/vpc"
  vpc_name  = "${var.network}-${var.env_name}-${random_id.suffix.hex}"
}

# Setup Subnets
module "cohere-vpc-subnets" {
  source          = "../../modules/network/subnet"
  vpc_id          =  module.cohere-vpc.vpc_id
  region          = var.main_region
  subnetwork_name = "${var.network}-${var.env_name}-private"
}

# VPC routing
module "cohere-vpc-routing-router" {
  source    = "../../modules/network/routing/router"
  vpc_id    =  module.cohere-vpc.vpc_id
}

module "cohere-vpc-routing-firewall" {
  source    = "../../modules/network/routing/firewall"
  vpc_id    =  module.cohere-vpc.vpc_id
}

module "cohere-vpc-routing-nat" {
  source      = "../../modules/network/routing/nat"
  nat_name    = "nat"
  vpc_id      =  module.cohere-vpc.vpc_id
  region      = var.main_region
  subnet_id   = module.cohere-vpc-subnets.subnet_id
  router_name = module.cohere-vpc-routing-router.router_name
}

# setup base cluster
module "cohere-gke" {
  source                  = "../../modules/compute/gke"

  cluster_name            = var.gke_name
  region                  = var.main_region
  network_selflink        = module.cohere-vpc.vpc_self_link
  subnetwork_selflink     = module.cohere-vpc-subnets.subnet_self_link
  master_ipv4_cidr_block  = "172.16.0.0/28"
  max_nodes               = var.gke_node_count
  min_nodes               = 1
  default_node_count      = 1
}

# attach node pools
module "cohere-gke-pool-master" {
  depends_on    = [module.cohere-gke]

  source        = "../../modules/compute/nodepool"
  name          = "${module.cohere-gke.name}-np1"
  cluster_id  = module.cohere-gke.id
  region        = module.cohere-gke.location
  max_nodes     = var.gke_node_count
  min_nodes     = 1
  node_locations = ["${var.main_region}-a"]
}

module "gke_auth" {
  depends_on    = [module.cohere-gke-pool-master]

  source        = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version       = "24.1.0"
  project_id    = var.project_id
  location      = module.cohere-gke.location
  cluster_name  = module.cohere-gke.name
}

resource "local_file" "kubeconfig" {
  depends_on = [ module.gke_auth ]
  content  = module.gke_auth.kubeconfig_raw
  filename = "kubeconfig-${var.env_name}"
}

data "google_client_config" "default" {}

provider "helm" {
  kubernetes {
    host                   = "https://${module.cohere-gke.endpoint}"
    cluster_ca_certificate = base64decode(module.cohere-gke.cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}
provider "kubectl" {
  host                   = "https://${module.cohere-gke.endpoint}"
  cluster_ca_certificate = base64decode(module.cohere-gke.cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

# Static IP
resource "google_compute_address" "ingress_ip_address" {
  name = "nginx-controller"
}

# setup ingress
module "nginx-controller" {
  source  = "terraform-iaac/nginx-controller/helm"

  # Optional
  ip_address = google_compute_address.ingress_ip_address.address
}

output "gke_endpoint" {
  value = "${element(split(",", module.cohere-gke.endpoint), 0)}"
}
