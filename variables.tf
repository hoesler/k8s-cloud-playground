variable "project_name" {
  type    = string
  default = "kubernetes"
}

variable "ssh_keys" {
  type = list(string)
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version to install. Upgrades are not supported this way."
}

variable "init_phase" {
  type        = bool
  default     = false
  description = "If true, only one node ist brought up to run 'kubeadm init' on it."
}

variable "initial_master" {
  type        = string
  description = "The master which is to run 'kubadm init' during init phase."
}

variable "kubeadmconf" {
  type        = string
  default     = "default"
  description = "Use different kubeadmconf-<name>.yaml and joinconf-<name>.yaml."
}

variable "join_token" {
  type        = string
  default     = ""
  description = "The token needed for a node to join the cluster"
}

variable "cert_hash" {
  type        = string
  default     = ""
  description = "The hash of the API server's cert."
}

variable "cert_key" {
  type        = string
  default     = ""
  description = "The key to retrieve certs from the cluster."
}

variable "admin_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"] # Set it to the range YOU are in!
  description = "IP addresses to allow SSH access from."
}

variable "masters" {
  type = map(object({
    instance_type = string,
    root_volume_size = string
  }))
}

variable "workers" {
  type = map(object({
    instance_type = string,
    root_volume_size = string
  }))
}
