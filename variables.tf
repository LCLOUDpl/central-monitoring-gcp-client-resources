/*
 * Configuration file with variables.
 */

variable "endpoint" {
  description = "Central Monitoring endpoint for receiving events from Google Cloud Platform."
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment name."
  type        = string
}
