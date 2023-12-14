#!/bin/bash

#Script Author : Pankaj Singh 
#Github: pkstiyara
# Date : 14 Dec 2023

# Define installation prefix and tarball directory
prefix="/APPS/Apache2458"
tarball_dir="/opt/tarball"

# Install priority dependencies
sudo yum groupinstall "development tools" -y
sudo yum install wget expat expat-devel -y
sudo yum install perl-CPAN -y

# Create tarball directory if needed
mkdir -p "$tarball_dir"

# List of remaining dependencies and their URLs (adjust as needed)
dependencies=(
  "https://dlcdn.apache.org//apr/apr-1.7.4.tar.gz"
  "https://dlcdn.apache.org//apr/apr-util-1.6.3.tar.gz"
  "https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.gz"
  "https://www.openssl.org/source/openssl-3.2.0.tar.gz"
  "https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.42/pcre2-10.42.tar.gz"
  "https://dlcdn.apache.org/httpd/httpd-2.4.58.tar.gz"
)

# Download remaining dependencies to tarball directory
for url in "${dependencies[@]}"; do
  if [[ ! -f "$tarball_dir/${url%.*}" ]]; then
    wget "$url" -P "$tarball_dir"
  fi
done

# Extract all downloaded tarballs
for tarball in "$tarball_dir"/*.tar.gz; do
  tar -xf "$tarball" -C "$tarball_dir"
done

# Compile and install packages
cd "$tarball_dir"
for package in apr apr-util pcre openssl pcre2 httpd; do
  # Extract package directory if needed
  if [[ ! -d "$package" ]]; then
    tar -xf "$package".tar.gz
  fi

  cd "$package"

  case "$package" in
    apr)
      ./configure --prefix="$prefix"
      make
      make install
      ;;
    apr-util)
      ./configure --prefix="$prefix" --with-apr="$prefix/apr"
      make
      make install
      ;;
    pcre)
      ./configure --prefix="$prefix"
      make
      make install
      ;;
    openssl)
      ./config -fPIC --prefix="$prefix"
      make
      make install
      ;;
    pcre2)
      ./configure --prefix="$prefix"
      make
      make install
      ;;
    httpd)
      ./configure --prefix="$prefix" --with-apr="$prefix/apr" --with-apr-util="$prefix/apr-util" --with-pcre="$prefix/bin/pcre2-config" --with-ssl="$prefix/openssl"
      make
      make install
      ;;
  esac

  cd ..
done

cd ..

echo "Dependencies downloaded, untarred, and compiled in /opt/tarball. Packages were installed to $prefix."

