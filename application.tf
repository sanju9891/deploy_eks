resource "kubernetes_deployment" "hello_world" {
  metadata {
    name = "hello-world"
    labels = {
      app = "hello-world"
    }
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "hello-world"
      }
    }
    template {
      metadata {
        labels = {
          app = "hello-world"
        }
      }
      spec {
        container {
          image = "<your-ecr-repo>/hello-world:v1"
          name  = "hello-world"
          ports {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "hello_world_service" {
  metadata {
    name = "hello-world-service"
  }
  spec {
    selector = {
      app = "hello-world"
    }
    type = "LoadBalancer"
    ports {
      port        = 80
      target_port = 3000
    }
  }
}
