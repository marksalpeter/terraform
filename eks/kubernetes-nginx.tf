resource "kubernetes_pod" "nginx" {
  metadata {
    name = "eks-nginx-example"
    labels = {
      App = "nginx"
    }
  }

  spec {
    container {
      image = "nginx:1.7.8"
      name  = "example"

      port {
        container_port = 80
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "eks-nginx-example"
  }
  spec {
    selector = {
      App = kubernetes_pod.nginx.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

output "nginx_service" {
  value = kubernetes_service.nginx
}

output "nginx_ip" {
  value = kubernetes_service.nginx.load_balancer_ingress[0].ip
}

output "nginx_hostname" {
  value = kubernetes_service.nginx.load_balancer_ingress[0].hostname
}