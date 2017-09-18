# Vagrant LAMP (Linux Apache MySQL PHP)
Configurazione personale per il setup di un server LAMP con Vagrant.

* [Requisiti](#requisiti)
* [Vagrant e bootstrap.sh](#vagrantfile-e-bootstrapsh)
* [Software Installati](#software-installati)
* [Installazione](#installazione)
* [Utilizzo](#utilizzo)
* [Virtual Host](#virtual-host)
* [Configurare e abilitare più Virtual Host](#configurare-e-abilitare-più-virtual-host)
* [Credenziali Database](#credenziali-database)
* [Cambiare la directory .vagrant](#cambiare-la-directory-vagrant)

***Nota:*** Questa configurazione è stata provata su sistemi operativi Microsoft Windows.

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

## Installazione
Clonare la repository
```
$ git clone https://github.com/davidecesarano/config-vagrant-lamp.git
```

## Utilizzo
Lanciare i comandi
```
$ cd config-vagrant-lamp
$ vagrant up
```
Ora è possibile accedere alla `DocumentRoot` qui http://192.168.33.10

## Virtual Host
Se si preferisce utilizzare un nome di dominio rispetto a un indirizzo IP è possibile aggiungere un record al file host del sistema operativo.
```
192.168.33.10    local.dev
```

## Configurare e abilitare più Virtual Host
E' possibile creare altri domini virtuali partendo da quello di default.
```
$ sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/test.com.conf
```

Modificare il file:
```
$ sudo nano /etc/apache2/sites-available/test.com.conf
```

Aggiungere le informazioni relative al nuovo dominio:
```
<VirtualHost *:80>
    ServerName test.com
    ServerAlias www.test.com
    DocumentRoot /var/www/html/test
    <Directory /var/www/html/test>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
    </Directory>
</VirtualHost>
```

Abilitare il nuovo dominio:
```
$ sudo a2ensite test.com.conf
$ sudo service apache2 restart
```

Aggiungere un nuovo record al file host del sistema operativo:
```
192.168.33.10    test.com
```

## Credenziali Database
* Username: root
* Password: vagrant
* Host: localhost
* Port: 3306

***Nota:*** Per accedere al database MySQL con phpMyAdmin http://192.168.33.10/phpmyadmin

## Cambiare la directory .vagrant

Se il file Vagrantfile è posizionato in una cartella di Dropbox (o Google Drive) al fine di condividerla tra più pc (ad esempio tra quello di casa e quello dell'ufficio), Vagrant sovrascriverà i file rendendo impossibile la sincronizzazione tra le due macchine. Per evitare questo, è possibile impostare la variabile di sistema ***VAGRANT_DOTFILE_PATH*** per avere directory diverse per ogni pc (ad es. .vagrant-work per il pc dell'ufficio e .vagrant-desktop per il pc di casa).

La variabile ***VAGRANT_DOTFILE_PATH*** può essere impostata in Windows seguendo questa procedura:

1. **Sistema > Impostazioni di sistema avanzata > Variabili d'ambiente...**
2. In Variabili di Sistema seleziona **Nuova..**
3. Nome variabile = VAGRANT_DOTFILE_PATH, Valore variabile = .vagrant-home