resource "google_pubsub_topic" "topic" {
  count = length(var.topics)

  name = var.topics[count.index]
}

resource "google_pubsub_subscription" "subscription" {
  count = length(var.subscriptions)

  name     = var.subscriptions[count.index]
  topic    = google_pubsub_topic.topic[count.index].id
  ack_deadline_seconds = 10
}