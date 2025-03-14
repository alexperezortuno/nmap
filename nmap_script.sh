#!/bin/bash

greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
option=""

function logInfo() {
  echo -e "\n$greenColour[+]$endColour $1"
}

function logError() {
  echo -e "\n$redColour[-]$endColour $1"
}

function logWarning() {
  echo -e "\n$yellowColour[!]$endColour $1"
}

function readInput() {
  read -p "$(echo -e "${blueColour}[?]${endColour} $1")" $2
}

function separator() {
  echo -e "\n$grayColour======================================================$endColour\n"
}

function getIPByDomain() {
    domain=${1:-"example.com"}
    #logger -t "nmap-scan" "resolving IP $domain"
    ip=$(dig +short "$domain" | head -n 1)
    #logger -t "nmap-scan" "IP resolved: $ip"
}

# Banner
function banner() {
  echo -e "${greenColour}
  ███╗   ██╗███╗   ███╗ █████╗ ██████╗     ███████╗ ██████╗ █████╗ ███╗   ██╗███╗   ██╗███████╗██████╗
  ████╗  ██║████╗ ████║██╔══██╗██╔══██╗    ██╔════╝██╔════╝██╔══██╗████╗  ██║████╗  ██║██╔════╝██╔══██╗
  ██╔██╗ ██║██╔████╔██║███████║██████╔╝    ███████╗██║     ███████║██╔██╗ ██║██╔██╗ ██║█████╗  ██████╔╝
  ██║╚██╗██║██║╚██╔╝██║██╔══██║██╔═══╝     ╚════██║██║     ██╔══██║██║╚██╗██║██║╚██╗██║██╔══╝  ██╔══██╗
  ██║ ╚████║██║ ╚═╝ ██║██║  ██║██║         ███████║╚██████╗██║  ██║██║ ╚████║██║ ╚████║███████╗██║  ██║
  ╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝         ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝
  $endColour"
}

if [ "$(id -u)" -ne 0 ]; then
  logInfo "You need sudo permissions to run script -> (sudo $0)"
  exit 1
fi

banner

while true; do
  echo -e "${yellowColour}"
  echo "1) Quick but noisy scan"
  echo "2) Normal scan"
  echo "3) Silent scan (It may take a little longer than usual)"
  echo "4) Service and version scan"
  echo "5) Complete scan"
  echo "6) UDP protocol scan"
  echo "7) Get IP by domain"
  echo "8) Execute scripts (https://nmap.org/nsedoc/scripts/)"
  echo "9) Execute custom command"
  echo "10) Exit"
  echo -e "${endColour}" &&
  read -p "Select an option: " option
  case ${option} in
  1)
    clear
    readInput "Enter the IP or domain to scan: " ip
    logInfo "Scanning..."
    nmap -p- --open --min-rate 5000 -T5 -sS -Pn -n -v "$ip" | grep -E "^[0-9]+\/[a-z]+\s+open\s+[a-z]+"
    separator
  ;;
  2)
    clear
    readInput "Enter the IP or domain to scan: " ip
    logInfo "Scanning..."
    nmap -p- --open "$ip" | grep -E "^[0-9]+\/[a-z]+\s+open\s+[a-z]+"
    separator
  ;;
  3)
    clear
    readInput "Enter the IP or domain to scan: " ip
    logInfo "Scanning..."
    nmap -p- -T2 -sS -Pn -f "$ip" | grep -E "^[0-9]+\/[a-z]+\s+open\s+[a-z]+"
    separator
  ;;
  4)
    clear
    readInput "Enter the IP or domain to scan: " ip
    logInfo "Scanning..."
    nmap -sV -sC "$ip"
    separator
  ;;
  5)
    clear
    readInput "Enter the IP or domain to scan: " ip
    logInfo "Scanning..."
    nmap -p- -sS -sV -sC --min-rate 5000 -n -Pn "$ip"
    separator
  ;;
  6)
    clear
    readInput "Enter the IP or domain to scan: " ip
    logInfo "Scanning..."
    nmap -sU --top-ports 200 --min-rate=5000 -n -Pn "$ip"
    separator
  ;;
  7)
    clear
    readInput "Enter the domain to get the IP: " domain
    getIPByDomain "$domain"
    logInfo "The IP of $domain is $ip"
    separator
  ;;
  8)
    clear
    readInput "Enter the IP or domain to scan: " ip
    readInput "Enter the script to execute: " script
    logInfo "Scanning..."
    nmap --script "$script" "$ip"
    separator
  ;;
  9)
    clear
    readInput "Enter the custom command to execute: " flags
    logInfo "Scanning..."
    nmap $flags
    separator
  ;;
  10)
    logInfo "Exiting..."
    exit 0
  ;;
  *)
    logError "Invalid option"
  ;;
  esac
done

exit 0