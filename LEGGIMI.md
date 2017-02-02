# Vagrant LAMP (Linux Apache MySQL PHP)
Configurazione personale per il setup di un server LAMP con Vagrant.

## Requisiti
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* [Git](https://git-scm.com/)

## Vagrantfile e bootstrap.sh
* Installa i [software](#software-installati)
* Definisce la web root nella directory `/html`
* Sposta i database MySQL nella directory `/mysql`

## Software Installati
* Ubuntu Server 14.04 LTS
* Apache 2.4.7
* PHP 5.5.9
* MySQL 5.5.54
* phpMyAdmin 4.0.10
* Git
* Composer
* Node.js
* Bower

## Installazione
Clonare la repository
```
$ git clone https://github.com/davidecesarano/my-vagrant-lamp.git
```

## Utilizzo
Lanciare il comando
```
$ cd my-vagrant-lamp
$ vagrant up
```
Ora è possibile accedere alla `DocumentRoot` qui http://192.168.33.10

## Virtual Host
Se si preferisce utilizzare un nome di dominio rispetto a un indirizzo IP è possibile aggiungere un record al file host del sistema operativo.
```
192.168.33.10    local.dev
```

## Credenziali Database
* Username: root
* Password: vagrant
* Host: localhost
* Port: 3306

***Nota:*** Per accedere al database MySQL con phpMyAdmin http://192.168.33.10/phpmyadmin
