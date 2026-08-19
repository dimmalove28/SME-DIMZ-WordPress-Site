SME-DIMZ WordPress Site

Project Overview

This project demonstrates the deployment of a WordPress website for an SME environment using Amazon Web Services (AWS).

The WordPress application was deployed on an Amazon EC2 instance and configured with the required web server, PHP environment, database server, and WordPress application files.

The project was completed as part of my Cloud Computing practical/Capstone project.

---

Project Objectives

The main objectives of this project were to:

- Deploy a WordPress website on AWS.
- Create and configure an Amazon EC2 instance.
- Install and configure a web server.
- Install PHP and the required PHP extensions.
- Install and configure a database server.
- Download and configure WordPress.
- Connect WordPress to the database.
- Configure the EC2 security group to allow web traffic.
- Verify that the WordPress website is accessible through the internet.

---

AWS Services Used

The following AWS service was used:

- Amazon EC2 — used to host the WordPress website.

---

Architecture

The basic architecture of the project is:

                  Internet
                     |
                     |
                 HTTP :80
                     |
                     v
              +--------------+
              |  AWS EC2     |
              |              |
              | WordPress    |
              | Apache       |
              | PHP          |
              | Database     |
              +--------------+
                     |
                     v
             WordPress Website

---

Deployment Steps

Step 1 — Create the EC2 Instance

An Amazon EC2 instance was created from the AWS Management Console.

The instance was configured with:

- A suitable Amazon Linux/Ubuntu operating system
- An appropriate instance type
- A key pair for SSH access
- A security group
- Public internet access

The security group was configured to allow the required traffic.

Inbound Rules

The following ports were required:

Type| Port| Purpose
SSH| 22| Remote server administration
HTTP| 80| Accessing the WordPress website

---

Step 2 — Connect to the EC2 Instance

After creating the EC2 instance, I connected to the server through SSH.

Example command:

ssh -i "your-key.pem" ubuntu@YOUR_PUBLIC_IP

For an Amazon Linux instance, the username may be:

ec2-user

Example:

ssh -i "your-key.pem" ec2-user@YOUR_PUBLIC_IP

«Replace "your-key.pem" and "YOUR_PUBLIC_IP" with the actual key file and public IP address of the EC2 instance.»

---

Step 3 — Update the Server

The server packages were updated before installing the required software.

For Ubuntu:

sudo apt update
sudo apt upgrade -y

---

Step 4 — Install Apache Web Server

Apache was installed to serve the WordPress website.

sudo apt install apache2 -y

The Apache service was started:

sudo systemctl start apache2

Apache was enabled so that it starts automatically when the server boots:

sudo systemctl enable apache2

The status of Apache was checked using:

sudo systemctl status apache2

After Apache was successfully installed, the server's public IP address was opened in a web browser to confirm that the web server was working.

---

Step 5 — Install PHP

PHP was installed because WordPress requires PHP to run.

sudo apt install php libapache2-mod-php php-mysql -y

Additional PHP extensions required by WordPress were installed:

sudo apt install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y

The PHP version was checked with:

php -v

---

Step 6 — Install the Database Server

A database server was installed for WordPress.

sudo apt install mysql-server -y

The MySQL service was started:

sudo systemctl start mysql

MySQL was enabled to start automatically:

sudo systemctl enable mysql

The service status was checked:

sudo systemctl status mysql

---

Step 7 — Create the WordPress Database

I accessed MySQL:

sudo mysql

A database was created for WordPress:

CREATE DATABASE wordpress;

A database user was created:

CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'YOUR_PASSWORD';

The required privileges were granted:

GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';

The privileges were refreshed:

FLUSH PRIVILEGES;

I then exited MySQL:

EXIT;

«The actual database password should not be published in GitHub. A placeholder such as "YOUR_PASSWORD" should be used in project documentation.»

---

Step 8 — Download WordPress

The WordPress package was downloaded from the official WordPress website:

cd /tmp

wget https://wordpress.org/latest.tar.gz

The downloaded archive was extracted:

tar -xzf latest.tar.gz

---

Step 9 — Move WordPress to the Web Directory

The WordPress files were moved to Apache's web directory:

sudo mv wordpress /var/www/html/

The WordPress directory was then accessed with:

cd /var/www/html/wordpress

---

Step 10 — Configure WordPress

The sample WordPress configuration file was copied:

sudo cp wp-config-sample.php wp-config.php

The configuration file was edited:

sudo nano wp-config.php

The database information was configured:

define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'wordpressuser' );
define( 'DB_PASSWORD', 'YOUR_PASSWORD' );
define( 'DB_HOST', 'localhost' );

The database password used here must match the password created for the WordPress database user.

---

Step 11 — Configure File Permissions

The WordPress files were assigned to the Apache web server user:

sudo chown -R www-data:www-data /var/www/html/wordpress

Appropriate permissions were applied:

sudo find /var/www/html/wordpress/ -type d -exec chmod 755 {} \;

sudo find /var/www/html/wordpress/ -type f -exec chmod 644 {} \;

---

Step 12 — Configure Apache

Apache was configured to serve the WordPress installation.

The Apache configuration was edited:

sudo nano /etc/apache2/sites-available/wordpress.conf

The WordPress virtual host configuration was added:

<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/wordpress

    <Directory /var/www/html/wordpress>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/wordpress_error.log
    CustomLog ${APACHE_LOG_DIR}/wordpress_access.log combined
</VirtualHost>

The WordPress Apache configuration was enabled:

sudo a2ensite wordpress.conf

Apache's rewrite module was enabled:

sudo a2enmod rewrite

The default Apache site was disabled:

sudo a2dissite 000-default.conf

Apache was restarted:

sudo systemctl restart apache2

---

Step 13 — Configure the WordPress Installation

After configuring the server, I opened the EC2 public IP address in a web browser.

The WordPress installation page appeared.

The following information was entered:

- Website title
- WordPress administrator username
- Administrator password
- Administrator email address

The WordPress installation was completed through the browser.

---

Step 14 — Verify the Website

## DNS

The site is accessible via a working domain name (not just the raw IP) using nip.io, which maps the EC2 instance's public IP directly to a domain: 13.62.224.144.nip.io

The website was tested using the EC2 public IP address.

Example:

http://YOUR_PUBLIC_IP/

The WordPress homepage was successfully displayed.

The WordPress administrator dashboard was also tested by visiting:

http://YOUR_PUBLIC_IP/wp-admin

---

Step 15 — Verify Apache

Apache was checked to make sure it was running:

sudo systemctl status apache2

Expected result:

active (running)

---

Step 16 — Verify MySQL

The database service was checked:

sudo systemctl status mysql

Expected result:

active (running)

---

Step 17 — Verify PHP

The installed PHP version was checked:

php -v

This confirmed that PHP was installed and available on the server.

---

Step 18 — Test WordPress

The following were verified:

- WordPress homepage loads successfully.
- WordPress administrator dashboard is accessible.
- Apache is running.
- PHP is installed.
- MySQL is running.
- EC2 security group allows HTTP traffic.
- The website can be accessed through the EC2 public IP address.

---

Troubleshooting Commands

The following commands can be useful when troubleshooting the deployment.

Check Apache status

sudo systemctl status apache2

Restart Apache

sudo systemctl restart apache2

Check Apache error logs

sudo tail -f /var/log/apache2/error.log

Check Apache access logs

sudo tail -f /var/log/apache2/access.log

Check MySQL status

sudo systemctl status mysql

Check PHP version

php -v

Check WordPress files

ls -la /var/www/html/wordpress

---

Security Considerations

For security:

- SSH access should be restricted to trusted IP addresses where possible.
- Database credentials should never be committed to GitHub.
- The "wp-config.php" file contains sensitive information and should not expose real passwords.
- Strong WordPress administrator credentials should be used.
- Unnecessary ports should not be opened in the EC2 security group.
- Server and WordPress software should be kept updated.

---

Project Outcome

The SME-DIMZ WordPress website was successfully deployed on an AWS EC2 instance.

The completed environment consists of:

AWS EC2
   |
   +-- Apache Web Server
   |
   +-- PHP
   |
   +-- MySQL Database
   |
   +-- WordPress
   |
   +-- SME-DIMZ Website

The website is accessible through the public IP address assigned to the EC2 instance.

---

Lessons Learned

Through this project, I gained practical experience in:

- AWS EC2 deployment
- Linux server administration
- SSH
- Apache web server configuration
- PHP installation
- MySQL database configuration
- WordPress deployment
- Linux file permissions
- AWS Security Groups
- Troubleshooting web server issues
- Hosting a website on AWS

---

Technologies Used

- Amazon Web Services (AWS)
- Amazon EC2
- Linux
- Apache
- PHP
- MySQL
- WordPress
- SSH
- GitHub

---
---

## Problem Context

Small and medium-sized businesses in Nigeria often run their websites and applications on local, on-premise servers. These setups are fragile — they're vulnerable to power outages, hardware failure, and don't scale well as the business grows. This project migrates a simple SME application to AWS to address that problem, giving it better uptime and reliability.

---

## Infrastructure as Code

I used Terraform to define the AWS infrastructure for this project instead of relying only on manual setup through the console. The configuration is in main.tf, variables.tf, and outputs.tf. This makes the deployment reproducible — anyone with the right AWS credentials could run this and get the same setup.

## Architecture Diagram

architecture-diagram.md has a diagram showing how the pieces fit together — user, CloudFront, EC2, and the Apache/PHP/MySQL/WordPress stack running inside it.

## Cost Estimation

cost-estimation.md breaks down the estimated monthly AWS cost for this setup, and explains why I chose a t3.micro instance and kept everything on one server to keep costs low for an SME.

---
Author

SME-DIMZ WordPress Site

Cloud Computing Project
