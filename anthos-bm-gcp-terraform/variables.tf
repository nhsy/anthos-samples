/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "Unique identifer of the Google Cloud Project that is to be used"
  type        = string
}

variable "credentials_file" {
  description = <<EOT
    Path to the Google Cloud Service Account key file.
    This is the key that will be used to authenticate the provider with the Cloud APIs
  EOT
  type        = string
}

variable "resources_path" {
  description = "Path to the resources folder with the template files"
  type        = string
}

variable "region" {
  description = "Google Cloud Region in which the Compute Engine VMs should be provisioned"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zone within the selected Google Cloud Region that is to be used"
  type        = string
  default     = "us-central1-a"
}

variable "username" {
  description = "The name of the user to be created on each Compute Engine VM to execute the init script"
  type        = string
  default     = "tfadmin"
}

variable "min_cpu_platform" {
  description = "Minimum CPU architecture upon which the Compute Engine VMs are to be scheduled"
  type        = string
  default     = "Intel Haswell"
}

variable "machine_type" {
  description = "Google Cloud machine type to use when provisioning the Compute Engine VMs"
  type        = map(string)
  default = {
    admin : "n1-standard-2",
    controlplane : "n1-standard-4",
    worker : "n1-standard-4",
  }
}

variable "image" {
  description = <<EOF
    The source image to use when provisioning the Compute Engine VMs.
    Use 'gcloud compute images list' to find a list of all available images
  EOF
  type        = string
  default     = "ubuntu-2004-focal-v20210429"
}

variable "image_project" {
  description = "Project name of the source image to use when provisioning the Compute Engine VMs"
  type        = string
  default     = "ubuntu-os-cloud"
}

variable "image_family" {
  description = <<EOT
    Source image to use when provisioning the Compute Engine VMs.
    The source image should be one that is in the selected image_project
  EOT
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "boot_disk_type" {
  description = "Type of the boot disk to be attached to the Compute Engine VMs"
  type        = string
  default     = "pd-ssd"
}

variable "boot_disk_size" {
  description = "Size of the primary boot disk to be attached to the Compute Engine VMs in GBs"
  type        = map(number)
  default = {
    admin : 20,
    controlplane : 200
    worker_1 : 200
    worker_2 : 50
  }
}

variable "gpu" {
  description = <<EOF
    GPU information to be attached to the provisioned GCE instances.
    See https://cloud.google.com/compute/docs/gpus for supported types
  EOF
  type        = object({ type = string, count = number })
  default     = { count = 0, type = "" }
}

variable "network" {
  description = "VPC network to which the provisioned Compute Engine VMs is to be connected to"
  type        = string
  default     = "default"
}

variable "tags" {
  description = "List of tags to be associated to the provisioned Compute Engine VMs"
  type        = list(string)
  default     = ["http-server", "https-server"]
}

variable "access_scopes" {
  description = "The IAM access scopes associated to the Compute Engine VM Service Accounts"
  type        = set(string)
  default     = ["cloud-platform"]
}

variable "anthos_service_account_name" {
  description = "Name given to the Service account that will be used by the Anthos cluster components"
  type        = string
  default     = "baremetal-gcr"
}

variable "primary_apis" {
  description = "List of primary Google Cloud APIs to be enabled for this deployment"
  type        = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "gkeconnect.googleapis.com",
    "gkehub.googleapis.com",
    "iam.googleapis.com",
    "iap.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "stackdriver.googleapis.com",
    "serviceusage.googleapis.com",
  ]
}

variable "secondary_apis" {
  description = "List of secondary Google Cloud APIs to be enabled for this deployment"
  type        = list(string)
  default = [
    "anthos.googleapis.com",
    "anthosgke.googleapis.com",
  ]
}

variable "abm_cluster_id" {
  description = "Unique id to represent the Anthos Cluster to be created"
  type        = string
  default     = "anthos-gce-cluster"
}

# [START anthos_bm_node_prefix]
###################################################################################
# The recommended instance count for High Availability (HA) is 3 for Control plane
# and 2 for Worker nodes.
###################################################################################
variable "instance_count" {
  description = "Number of instances to provision per layer (Control plane and Worker nodes) of the cluster"
  type        = map(any)
  default = {
    "controlplane" : 3
    "worker" : 2
  }
}
# [END anthos_bm_node_prefix]

variable "preemptible" {
  description = "Allow the compute instances to be preempted"
  type        = bool
  default     = false
}