# Vagrant LAMP (Linux Apache MySQL PHP)
Configurazione personale per il setup di un server LAMP con Vagrant.

* [Requisiti]()
* [Vagrant e bootstrap.sh]()
* [Software Installati]()
* [Installazione](#installazione)
* [Utilizzo](#utilizzo)
* [Virtual Host](#virtual-host)
* [Credenziali Database](#credenziali-database)
* [Cambiare la directory .vagrant]()
* [Usare npm install]()

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

## Cambiare la directory .vagrant

Se il file Vagrantfile è posizionato in una cartella di Dropbox (o Google Drive) al fine di condividerla tra più pc (ad esempio tra quello di casa e quello dell'ufficio), Vagrant sovrascriverà i file rendendo impossibile la sincronizzazione tra le due macchine. Per evitare questo, è possibile impostare la variabile di sistema ***VAGRANT_DOTFILE_PATH*** per avere directory diverse per ogni pc (ad es. .vagrant-work per il pc dell'ufficio e .vagrant-desktop per il pc di casa).

La variabile ***VAGRANT_DOTFILE_PATH*** può essere impostata in Windows seguendo questa procedura:

1. **Sistema > Impostazioni di sistema avanzata > Variabili d'ambiente...**
2. In Variabili di Sistema seleziona **Nuova..**
3. Nome variabile = VAGRANT_DOTFILE_PATH, Valore variabile = .vagrant-home

## Usare npm install
Il mancato funzionamento del comando **npm install** è dovuto alla mancanza di supporto per i link simbolici in Windows e da una configurazione di Vagrant che impedisce la creazione link simbolici nelle cartelle condivise. Per aggirare questo problema è necessario seguire questi passaggi:

* Eseguire il prompt dei comandi Windows (o Git Bash) in **modalità amministratore**.
* Lanciare i comandi
```
$ vagrant up
$ vagrant ssh
```
* Nella directory in cui vogliamo installare i packages npm eliminare, se presente, la directory **node_modules**.
* Creare una directory nel sistema con
```
$ mkdir ~/node_modules_project
```
* Creare un link simbolico dalla directory ~/node_modules_project a quella in cui si vogliono installare i packages
```
$sudo ln -s ~/node_modules_project /var/www/html/project
```
* In `/var/www/html/project` è ora possibile installare un pacchetto locale con `npm install`.
