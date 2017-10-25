resource "kubernetes_pod" "app" {
  metadata {
    name = "${var.namespace}-app"

    labels {
      App = "${var.namespace}-app"
    }
  }

  spec {
    container {
      image = "hashicorp/http-echo:latest"
      name  = "http-echo"

     args = [
      "-listen", ":8080",
      "-text", "OpenDev Rocks",
     ]

      port {
        container_port = 8080
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "${var.namespace}-app-test"
  }

  spec {
    selector {
      App = "${kubernetes_pod.app.metadata.0.labels.App}"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
