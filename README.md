# GoogleCloud-SH

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Setup Guide</title>
</head>
<body>

<h1>Project Setup Guide</h1>

<p>This guide provides instructions on setting up and running various commands in the terminal.</p>

<h2>Running Terminal Commands</h2>

<h3>Install Ubuntu Desktop</h3>

<pre>
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install ubuntu-desktop
</pre>

<h3>Configure SSH and Create a User</h3>

<pre>
sudo -s
passwd
# Set password for root user
nano /etc/ssh/sshd_config
# Update PasswordAuthentication to yes
adduser linunbu
# Set password and provide required information
usermod -a -G sudo,admin linunbu
reboot
</pre>

<h3>Edit sudoers File</h3>

<pre>
sudo visudo
</pre>

Add the following line:

<pre>
linunbu ALL=(ALL:ALL) ALL
linunbu ALL=NOPASSWD: /bin/systemctl start phantombot, /bin/systemctl stop phantombot, /bin/systemctl restart phantombot, /bin/systemctl status phantombot
</pre>

<h2>Downloading Dependencies via Terminal</h2>

<pre>
sudo nano ./setup.sh
</pre>

```bash
#!/bin/bash

# Add commands to install required dependencies
