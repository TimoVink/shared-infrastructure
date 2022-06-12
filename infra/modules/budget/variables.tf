variable "monthly_budget" {
  type        = number
  description = "The amount in USD we are budgeting for per month."
}

variable "notification_email" {
  type        = string
  description = "Email address to send alerts to."
}
