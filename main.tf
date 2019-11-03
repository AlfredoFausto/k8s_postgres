provider "kubernetes" {
  }

resource "kubernetes_config_map" "default" {
  metadata {
    name = "postgres-data"
  }

  data = {
    "createTable.sql" = "${file("/Users/ajfausto/k8s/createTable.sql")}"
  }
}

resource "kubernetes_deployment" "postgres" {
  metadata {
    name = "postgres"
    labels = {
      app = "postgres"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "postgres"
      }
    }
    template {
      metadata {
        labels = {
          app = "postgres"
        }
      }
     spec {
        container {
          image = "postgres:latest"
          name  = "postgres"
          port = {
            container_port = 5432
          }
          env {
            name  = "POSTGRES_USER"
            value = "postgres"
          }
          env {
            name  = "POSTGRES_PASSWORD"
            value = "Aw3s0m3"
          }
          env {
            name  = "POSTGRES_DB"
            value = "WORKSHOP"
          }
          volume_mount {
           name      = "postgres-config"
           mount_path = "/docker-entrypoint-initdb.d/createTable.sql"
           sub_path   = "createTable.sql"
          }
          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
       volume {
          name = "postgres-config"
          config_map = {
           name = "postgres-data"
          }
       }
     }
    }
  } 
}
