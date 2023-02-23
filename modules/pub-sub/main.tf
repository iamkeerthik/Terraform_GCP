
# Define a list of topic/subscription pairs
locals {
  topics = {
    topic1 = "subscription1",
    topic2 = "subscription2",
    topic3 = "subscription3",
  }
}

# Create topics and subscriptions using iteration
resource "google_pubsub_topic" "topic" {
  for_each = local.topics
  name     = each.key
}

resource "google_pubsub_subscription" "subscription" {
  for_each = local.topics
  name     = each.value
  topic    = google_pubsub_topic.topic[each.key].id
}
