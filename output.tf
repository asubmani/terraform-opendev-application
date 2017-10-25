output "app_dns" {
  value = "${dnsimple_record.www.hostname}"
}
