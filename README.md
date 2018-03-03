# Vagrant LAMP (Linux Apache MySQL PHP)
Personal configuration for the setup of a basic LAMP server with Vagrant.

***Note:*** This configuration has been set on Microsoft Windows. 

## Requirements
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* [Git](https://git-scm.com/)

## Vagrantfile and bootstrap.sh
* Install the [software](#software-installati)
* Set the web root directory in `/html`
* Move the MySQL database directory in `/mysql`

## Installed Software
* Ubuntu 16.04 LTS
* Apache 2
* PHP 7.1
* MySQL
* phpMyAdmin
* Git
* Composer

## Installation
Clone the repository
```
$ git clone https://github.com/davidecesarano/config-vagrant-lamp.git
```

## Usage
Run the commands
```
$ cd config-vagrant-lamp
$ vagrant up
```
Now you can access the `DocumentRoot` here http://192.168.33.10

## Virtual Host
If you prefer to use a domain name than the IP address you can add a record to the host file.
```
192.168.33.10    local.dev
```

## Customize and enable more Virtual Host
Now that we have our first virtual host file established, we can create our second one by copying that file and adjusting it as needed.

Start by copying it:
```
$ sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/test.com.conf
```

Open the new file with root privileges in your editor:
```
$ sudo nano /etc/apache2/sites-available/test.com.conf
```

You now need to modify all of the pieces of information to reference your second domain:
```
<VirtualHost *:80>
    ServerName test.com
    ServerAlias www.test.com
    DocumentRoot /var/www/test
    <Directory /var/www/test>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

Now that we have created our virtual host files, we must enable them:
```
$ sudo a2ensite test.com.conf
$ sudo service apache2 restart
```

Set up local hosts file:
```
192.168.33.10    test.com
```

## Database
* Username: root
* Password: vagrant
* Host: localhost
* Port: 3306

***Note:*** To access the MySQL database with phpMyAdmin http://192.168.33.10/phpmyadmin

## How to change the .vagrant directory ##
if you keep your Vagrantfile in a Dropbox (or Google Drive) folder in order to share the folder between your desktop and laptop (for example), Vagrant will overwrite the files in this directory with the details of the VM on the most recently-used host. To avoid this, you could set ***VAGRANT_DOTFILE_PATH*** to .vagrant-laptop and .vagrant-desktop on the respective machines.

In Windows you can set ***VAGRANT_DOTFILE_PATH***:

1. **System > Advanced system settings > Environment Variables**
2. Select **New**
3. Variable name = VAGRANT_DOTFILE_PATH, Variable value = .vagrant-home
