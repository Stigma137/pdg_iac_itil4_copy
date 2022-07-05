variable "environment" {
  description = "The environment that we want to deploy. Could be prod or pre-prod"
  type        = string
  default     = "prod"
}