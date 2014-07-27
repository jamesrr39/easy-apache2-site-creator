#!/bin/bash

site_name=$1
site_url=$2
site_document_root=$3

# interactive parameters
if [ "$site_name" = "" ]; then
	read -p "Enter the site name: " site_name
fi

if [ "$site_url" = "" ]; then
	read -p "Enter the site URL: " site_url
fi

if [ "$site_document_root" = "" ]; then
	read -p "Enter the site document root: " site_document_root
fi

# check the vhosts module is enabled
if [ "$(apache2ctl -M | grep -c vhost)" -eq 0 ]; then
	echo "The apache vhosts module is not enabled. Enable it with 'a2enmod vhost_alias'"
	exit
fi

vhost_template_path='../res/default'

temp_file="$(cat $vhost_template_path)"
hosts_entry="127.0.0.1 $site_url"

temp_file=$(echo "$temp_file" | sed -e s/SERVERNAME/$site_url/g)
temp_file=$(echo "$temp_file" | sed -e s#DOCUMENT_ROOT#$site_document_root#g)
temp_file=$(echo "$temp_file" | sed -e s/LOG_FILE_NAME/$site_name/g)

if [ -f /etc/apache2/sites-available/$site_name ]; then
	echo "Can't set up $site_name, it already exists."
	exit
fi
echo "$temp_file" > /etc/apache2/sites-available/$site_name.conf
echo "$hosts_entry" >> /etc/hosts

a2ensite $site_name
service apache2 reload
echo "$site_name is all set up at $site_url serving pages from $site_document_root!" 


