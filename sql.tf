resource "aws_sqs_queue" "app_queue" {
  name                       = "${local.name_prefix}-queue"
  visibility_timeout_seconds = 30      # how long a msg stays hidden after being read
  message_retention_seconds  = 345600  # keep msgs 4 days
  receive_wait_time_seconds  = 10      # long polling

  tags = local.tags
}