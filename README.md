# grafana

Local grafana container for running on a RaspberryPi.

The official grafana image would not run on my Pi so I rolled this.

```bash
docker volume create grafana-storage
docker volume create grafana-config
docker run -d --restart=always --name "grafana" -p 3000:3000 -v grafana-config:/etc/grafana -v grafana-storage:/var/lib/grafana grafana:latest
```


