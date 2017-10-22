resource "kubernetes_pod" "app" {
  metadata {
    name = "opendev-app"

    labels {
      App = "opendev-app"
    }
  }

  spec {
    container {
      image = "quay.io/nicholasjackson/quake-client:latest"
      name  = "quakeclient"

      port {
        container_port = 80
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "opendev-app"
  }

  spec {
    selector {
      App = "${kubernetes_pod.app.metadata.0.labels.App}"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
