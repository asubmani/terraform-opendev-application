resource "kubernetes_pod" "app" {
  metadata {
    name = "${var.namespace}-app"

    labels {
      App = "${var.namespace}-app"
    }
  }

  spec {
    container {
      image = "mwrock/np-mongo:latest"
      name  = "mongo"

      port {
        container_port = 27017
      }
    }

    container {
      image = "mwrock/national-parks:latest"
      name  = "national-parks"
      args = [
        "-bind", "database:np-mongodb.default",
        "-peer", "localhost",
      ]

      port {
        container_port = 8080
      }
    }

  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "${var.namespace}-app"
  }

  spec {
    selector {
      App = "${kubernetes_pod.app.metadata.0.labeles.App}"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
