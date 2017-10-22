provider "dnsimple" {
}

# Create a record
resource "dnsimple_record" "www" {
  domain = "${var.dns_tld}"
  name   = "app.k8s"
  value  = "${kubernetes_service.app.load_balancer_ingress.0.ip}"
  type   = "A"
  ttl    = 360
}
