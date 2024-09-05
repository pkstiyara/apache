#!/bin/bash

# Script Author: Pankaj Singh
# Github: pkstiyara
# Date: 14 December 2023

# Define variables
prefix="/data/apache2462"
tarball_dir="/data/tarball"
apr_version="1.7.4"
apr_util_version="1.6.3"
pcre_version="8.45"
openssl_version="3.2.0"
pcre2_version="10.42"
httpd_version="2.4.62"

apr_url="https://dlcdn.apache.org//apr/apr-$apr_version.tar.gz"
apr_util_url="https://dlcdn.apache.org//apr/apr-util-$apr_util_version.tar.gz"
pcre_url="https://sourceforge.net/projects/pcre/files/pcre/$pcre_version/pcre-$pcre_version.tar.gz"
openssl_url="https://www.openssl.org/source/openssl-$openssl_version.tar.gz"
pcre2_url="https://github.com/PCRE2Project/pcre2/releases/download/pcre2-$pcre2_version/pcre2-$pcre2_version.tar.gz"
httpd_url="https://dlcdn.apache.org/httpd/httpd-$httpd_version.tar.gz"
log_file="/var/log/installation.log"

# Install priority dependencies and log the output
sudo yum groupinstall "development tools" -y >> "$log_file" 2>&1
sudo yum install wget expat expat-devel perl-CPAN -y >> "$log_file" 2>&1

# Create tarball directory if needed
mkdir -p "$tarball_dir" >> "$log_file" 2>&1

# Download dependencies
wget -P "$tarball_dir" "$apr_url" >> "$log_file" 2>&1
wget -P "$tarball_dir" "$apr_util_url" >> "$log_file" 2>&1
wget -P "$tarball_dir" "$pcre_url" >> "$log_file" 2>&1
wget -P "$tarball_dir" "$openssl_url" >> "$log_file" 2>&1
wget -P "$tarball_dir" "$pcre2_url" >> "$log_file" 2>&1
wget -P "$tarball_dir" "$httpd_url" >> "$log_file" 2>&1

cd "$tarball_dir"

# Function to extract, configure, make, and install a package
install_package() {
    tar -xf "$1.tar.gz" >> "$log_file" 2>&1
    cd "$1" || exit
    ./configure --prefix="$prefix/$2" ${@:3} >> "$log_file" 2>&1
    make >> "$log_file" 2>&1
    make install >> "$log_file" 2>&1
    cd ..
}

# Install each package
install_package "apr-$apr_version" "apr"
install_package "apr-util-$apr_util_version" "apr-util" "--with-apr=$prefix/apr"
install_package "pcre-$pcre_version" "pcre"
install_package "openssl-$openssl_version" "openssl" "-fPIC"
install_package "pcre2-$pcre2_version" "pcre2"
install_package "httpd-$httpd_version" "" "--with-apr=$prefix/apr" "--with-apr-util=$prefix/apr-util" "--with-pcre=$prefix/pcre2/bin/pcre2-config" "--with-ssl=$prefix/openssl"

# Log completion message
echo "Dependencies downloaded, untarred, and compiled in /opt/tarball. Packages were installed to $prefix." >> "$log_file" 2>&1
