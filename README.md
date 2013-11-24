#Easy apache2 site creator#

##Introduction##
A script for developing new sites quickly and easily.  
Written on ubuntu 12.04 LTS, with apache sites-available folder under /etc/apache2/sites-available/ and hosts file at /etc/hosts

##Installation##
Download this project, then create a symlink to src/easy-apache2-site-creator.sh (in $PATH if it should be available system-wide), or just use the script from the folder itself.

##Usage##

		sh src/easy-apache2-site-creator.sh [site_name] [site_url] [document_root]

- site_name: what the site will be known as to apache2, what the logs files will be called.
- site_url: the url the site will be available at
- document_root: where the web pages are located on disk
