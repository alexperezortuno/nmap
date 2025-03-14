FROM alpine:latest

RUN apk add --no-cache nmap bash bind-tools nmap-scripts

COPY . /scripts

RUN chmod +x /scripts/nmap_script.sh

ENTRYPOINT ["/scripts/nmap_script.sh"]