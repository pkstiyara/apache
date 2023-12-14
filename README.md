# apache

Apache Web Server Installation Script
This Bash script automates the installation process of Apache HTTP Server along with its dependencies on Red Hat Enterprise Linux (RHEL). The script downloads, compiles, and installs the required packages, making it easier to set up Apache on your system.

Prerequisites
Ensure that your system meets the following requirements before running the script:

Red Hat Enterprise Linux (RHEL)
Access to the internet for downloading dependencies
sudo privileges or the ability to run commands as a superuser
Usage
Open a terminal on your RHEL system.

Download the script to a local file, for example, install_apache.sh.

bash
Copy code
wget https://raw.githubusercontent.com/your-username/your-repo/main/install_apache.sh
Make the script executable.

bash
Copy code
chmod +x install_apache.sh
Run the script.

bash
Copy code
./install_apache.sh
Script Explanation
The script performs the following tasks:

Define Installation Paths:

prefix: Specifies the installation prefix for Apache.
tarball_dir: Sets the directory for storing downloaded tarballs.
Install Priority Dependencies:

Installs development tools, wget, expat, expat-devel, and perl-CPAN using yum.
Download Dependencies:

Downloads the necessary tarballs for Apache, APR, APR-util, PCRE, OpenSSL, and PCRE2.
Extract Tarballs:

Extracts the downloaded tarballs in the specified tarball directory.
Compile and Install Packages:

Iterates through each package, configures, compiles, and installs them.
The packages include APR, APR-util, PCRE, OpenSSL, PCRE2, and Apache HTTP Server.
Conclusion:

Prints a message indicating that the dependencies have been downloaded, untarred, and compiled. The installed packages are located in the specified installation prefix.
Notes
This script assumes a clean system and may require additional adjustments for specific environments or configurations.
Verify that you have the necessary privileges to install packages and write to the specified installation directory.
