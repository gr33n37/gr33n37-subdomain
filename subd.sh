#!/bin/bash
clear
cat << "EOF"
                                                                      
 ██████  ██████  ██████  ██████  ███    ██ ██████  ███████ 
██       ██   ██      ██      ██ ████   ██      ██      ██ 
██   ███ ██████   █████   █████  ██ ██  ██  █████      ██  
██    ██ ██   ██      ██      ██ ██  ██ ██      ██    ██   
 ██████  ██   ██ ██████  ██████  ██   ████ ██████     ██    
		https://github.com/gr33n37 
		SUB-DOMAIN & HOST DISCOVERY TOOL                                                                                                          
EOF


if [ ! -e "/usr/bin/assetfinder" ]; then
echo -en "\n\e[1;33m\t\t\t[+] installing asssetfinder on your system \e[0m\n"
sudo apt install assetfinder -y
else
echo -en "\n\e[1;33m[+] We are going to use asssetfinder installed on your system. \e[0m\n\n"
fi

echo -en "\e[1;33m\t\t\t[+] Harvesting subdomains\e[0m\n\n"

if [ ! -d $1 ]; then
mkdir $1
fi

if [ ! -d $1/recon/ ]; then
echo -en "creating a \e[1;34m $1 / recon\e[0m directory on your location\n\n"
mkdir -p $1/recon
fi

subdomain=$1
assetfinder $subdomain | httprobe >> $1/recon/sub.txt

if [ -e $1/recon/sub.txt ]; then
echo -e "\t\t\e[1;34mHarvesting hosts for the domains generated\e[0m\n\n"
for host in $(cat $1/recon/sub.txt); do host $host; done | awk -F "has address" '{print $1 $2}' >> $1/recon/sub+ip.txt

fi
echo -en "\t\e[1;32m[+]Done[+]\e[0m check \e[1;32m$1 \e[0m/ recon for your \e[1;32mdata\e[0m"
