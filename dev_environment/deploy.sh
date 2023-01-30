```
sudo apt update -y
```

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

```
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

```
sudo apt-get update && sudo apt-get install nomad
```

```
curl -L -o cni-plugins.tgz https://github.com/containernetworking/plugins/releases/download/v1.0.1/cni-plugins-linux-amd64-v1.0.1.tgz
```

```
sudo mkdir -p /opt/cni/bin
```

```
sudo tar -C /opt/cni/bin -xzf cni-plugins.tgz
```

```
sudo nomad agent -dev -bind 0.0.0.0 -log-level INFO
```

Save the following as nginx.nomad

```
job "nginx" {
  datacenters = ["dc1"]  
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
```
```
nomad run nginx.hcl
```