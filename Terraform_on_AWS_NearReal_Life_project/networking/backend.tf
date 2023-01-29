# Backend to link storing TF State in Consul Server
terraform {
  backend "consul" {
    address = "127.0.0.1:8500"
    scheme  = "http"
  }
}