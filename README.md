# nmap


## Build docker image
```shell
docker build -t nmap-scanner:dev .
```

```shell
docker run --rm --name nmap-scanner -it nmap-scanner:dev
```

```shell
docker stop nmap-scanner && docker rm -f nmap-scanner
```