
variable "jetbrains_image" {
    type    = string
    default = "registry.jetbrains.team/p/prj/containers/projector-idea-c"
}

variable "machine_type" {
    type    = string
    default = "e2-standard-2"
}

variable "network_tags" {
    type    = list(string)
    default = ["dev-box"]
}

variable "subnetwork" {
    type = string
}

variable "source_image" {
    type    = string
    default = "projects/cos-cloud/global/images/family/cos-stable"
}

variable "disk_size_gb" {
    description = "Size of the boot disk"
    type        = number
    default     = 20
}
