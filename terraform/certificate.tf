resource "aws_acm_certificate" "cert" {
  domain_name       = "test.gre4ka.fun"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
