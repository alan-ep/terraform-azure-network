variable "env" {
  type        = string
  description = "Resource environment"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Resource location"
  default     = "eastus2"
}

variable "prefix" {
  type        = string
  description = "Resource name prefix"
  default     = "epchubspoke"
}
