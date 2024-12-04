/*
 * https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic
 * https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription
 * https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic_iam#google_pubsub_topic_iam_binding
 * https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel
 */

resource "google_project_service" "this" {
  for_each = toset(local.api_list)

  project            = data.google_project.project.project_id
  service            = each.value
  disable_on_destroy = false
}

# Notifications Channel
resource "google_pubsub_topic" "lcloud_support" {
  name  = "lcloud-support"

  labels = local.labels
}

resource "google_pubsub_subscription" "lcloud_support" {
  name  = "central-monitoring"
  topic = google_pubsub_topic.lcloud_support.name

  message_retention_duration    = "604800s"
  retain_acked_messages         = false
  enable_message_ordering       = false
  enable_exactly_once_delivery  = false

  push_config {
    push_endpoint     = var.endpoint
    no_wrapper {
      write_metadata  = true
    }
  }

  labels = local.labels
}

resource "google_pubsub_topic_iam_binding" "lcloud_support" {
  topic   = google_pubsub_topic.lcloud_support.name

  role    = "roles/pubsub.publisher"
  members = [
    "serviceAccount:service-${data.google_project.project.number}@gcp-sa-monitoring-notification.iam.gserviceaccount.com",
  ]

  depends_on = [
    google_pubsub_subscription.lcloud_support
  ]
}

resource "google_monitoring_notification_channel" "lcloud_support" {
  display_name = "LCloud Support"
  description  = "Pub/Sub channel for LCloud alert notifications"

  enabled       = true
  force_delete  = false
  type          = "pubsub"
  labels = {
    topic = google_pubsub_topic.lcloud_support.id
  }
}
