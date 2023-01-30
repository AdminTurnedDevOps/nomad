job "nginx" {
  datacenters = ["dc1"]  
  type = "service"
  constraint {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }
  group "http" {
    count = 3
 
    task "nginx" {
      driver = "docker"
 
      config {
        image = "nginx"
      }
      resources {
        cpu    = 500
        memory = 256
      }
    }
  }
}