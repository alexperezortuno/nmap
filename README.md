# nmap


## Build docker image
```shell
docker build -t nmap-script:dev .
```

```shell
docker run --rm --name nmap-script -it nmap-script:dev
```

```shell
docker stop nmap-script && docker rm -f nmap-script
```