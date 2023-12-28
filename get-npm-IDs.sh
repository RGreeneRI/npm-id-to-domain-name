#!/bin/bash

# This script will help you associate the NPM-ID number with
# its respective domain name on an instance on nginx proxy manager

# Specify the location of the letsencrypt/renewal directory
DIRECTORY="/opt/docker_volumes/nginx_proxy_manager/letsencrypt/renewal"

# Use find to locate all .conf files in the renewal directory
CONF_FILES=$(find "$DIRECTORY" -type f -name "*.conf")

# Iterate through each .conf file and locate the line that contains the domain name,
# then print the domain name alongside the npm id number from the conf file name.
for FILE in $CONF_FILES; do
    NPMID=$(basename "$FILE" .conf)
    DOMAIN=$(awk '/\/data\/letsencrypt-acme-challenge/ && !/webroot_path/ {print $1}' "$FILE")
    printf "%-30s%-15s\n" "$DOMAIN" "$NPMID"
done
