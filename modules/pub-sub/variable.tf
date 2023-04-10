variable "topics" {
  type        = list(string)
  description = "A list of Pub/Sub topic names to create"
}

variable "subscriptions" {
  type        = list(string)
  description = "A list of Pub/Sub subscription names to create"
}