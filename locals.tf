/*
 * Configuration file with locals.
 */

locals {
  labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
}
