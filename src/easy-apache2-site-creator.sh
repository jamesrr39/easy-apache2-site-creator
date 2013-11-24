#!/bin/bash

site_name=$1
site_url=$2
site_document_root=$3
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
echo "$temp_file" > /etc/apache2/sites-available/$site_name
echo "$hosts_entry" >> /etc/hosts

a2ensite $site_name
service apache2 reload
echo "$site_name is all set up at $site_url serving pages from $site_document_root!" 


