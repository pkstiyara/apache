#!/bin/bash

# Script Author: Pankaj Singh
# Github: pkstiyara
# Date: 21 December 2023

# Define installation prefix and tarball directory
prefix="/APPS/Apache2458"
tarball_dir="/opt/tarball"


# Update the package list
sudo apt update

# Install development tools
sudo apt install build-essential -y

# Install wget, expat, and expat development libraries
sudo apt install wget libexpat1 libexpat1-dev -y

# Install Perl CPAN
sudo apt install perl -y


# Create tarball directory if needed
mkdir -p "$tarball_dir"

# Download dependencies
wget -P "$tarball_dir" https://dlcdn.apache.org//apr/apr-1.7.4.tar.gz
wget -P "$tarball_dir" https://dlcdn.apache.org//apr/apr-util-1.6.3.tar.gz
wget -P "$tarball_dir" https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.gz
wget -P "$tarball_dir" https://www.openssl.org/source/openssl-3.2.0.tar.gz
wget -P "$tarball_dir" https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.42/pcre2-10.42.tar.gz
wget -P "$tarball_dir" https://dlcdn.apache.org/httpd/httpd-2.4.58.tar.gz

# Extract all downloaded tarballs
cd "$tarball_dir" || exit

# Unpack and install apr
tar -xf apr-1.7.4.tar.gz
cd apr-1.7.4
./configure --prefix="$prefix/apr"
make
sudo make install
cd ..

# Unpack and install apr-util
tar -xf apr-util-1.6.3.tar.gz
cd apr-util-1.6.3
./configure --prefix="$prefix/apr-util" --with-apr="$prefix/apr"
make
sudo make install
cd ..

# Unpack and install pcre
tar -xf pcre-8.45.tar.gz
cd pcre-8.45
./configure --prefix="$prefix/pcre"
make
sudo make install
cd ..

# Unpack and install openssl
tar -xf openssl-3.2.0.tar.gz
cd openssl-3.2.0
./config -fPIC --prefix="$prefix/openssl"
make
sudo make install
cd ..

# Unpack and install pcre2
tar -xf pcre2-10.42.tar.gz
cd pcre2-10.42
./configure --prefix="$prefix/pcre2"
make
sudo make install
cd ..

# Unpack and install httpd
tar -xf httpd-2.4.58.tar.gz
cd httpd-2.4.58
./configure --prefix="$prefix" --with-apr="$prefix/apr" --with-apr-util="$prefix/apr-util" --with-pcre="$prefix/pcre2/bin/pcre2-config" --with-ssl="$prefix/openssl"
make
sudo make install
cd ..

cd ..

# Print completion message
echo "Dependencies downloaded, untarred, and compiled in /opt/tarball. Packages were installed to $prefix."