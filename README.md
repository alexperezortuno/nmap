# nmap Scanner

---

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

### Example custom command

`--script=vuln -p 8080 <IP>`

`-sV --script=banner -p 8080 <IP>`