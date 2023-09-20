/*
 * Configuration file with outputs.
 */

output "monitoring_notification_channel_id" {
  description = "ID of the monitoring notification channel"
  value       = google_monitoring_notification_channel.lcloud_support.id
}

output "monitoring_notification_channel_name" {
  description = "Name of the monitoring notification channel"
  value       = google_monitoring_notification_channel.lcloud_support.name
}

output "monitoring_subscription_id" {
  description = "ID of the monitoring subscription system"
  value       = google_pubsub_subscription.lcloud_support.id
}

output "monitoring_subscription_name" {
  description = "Name of the monitoring subscription system"
  value       = google_pubsub_subscription.lcloud_support.name
}

output "monitoring_topic_id" {
  description = "ID of the monitoring Pub/Sub topic"
  value       = google_pubsub_topic.lcloud_support.id
}

output "monitoring_topic_name" {
  description = "Name of the monitoring Pub/Sub topic"
  value       = google_pubsub_topic.lcloud_support.name
}
