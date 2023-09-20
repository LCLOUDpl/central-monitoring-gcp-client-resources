variable "endpoint" {
  description = "Central Monitoring endpoint for receiving events from Google Cloud Platform."
  type        = string
  default     = "https://central-monitoring-api.linxsys-testing.lcloud.pl/v1/gcp-monitoring/*****"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "staging"
}
