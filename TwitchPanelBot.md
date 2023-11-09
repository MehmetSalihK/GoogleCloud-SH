<!DOCTYPE html>
<html lang="fr">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>

  <h1>Guide d'installation PhantomBot pour Ubuntu 16.04</h1>

  <h2>Prérequis</h2>

  <p>Assurez-vous que votre système est à jour en exécutant les commandes suivantes :</p>

  <pre><code>sudo apt update &amp;&amp; sudo apt upgrade</code></pre>

  <h2>Création de l'utilisateur PhantomBot</h2>

  <p>Créez un utilisateur dédié à PhantomBot pour renforcer la sécurité :</p>

  <pre><code>sudo adduser --disabled-password --gecos "" botuser</code></pre>

  <h2>Installation de PhantomBot</h2>

  <p>Basculez vers le nouvel utilisateur créé et téléchargez la dernière version de PhantomBot :</p>

  <pre><code>sudo su - botuser
cd /home/botuser
wget https://github.com/PhantomBot/PhantomBot/releases/download/vX.X.X/PhantomBot-X.X.X.zip
unzip PhantomBot-X.X.X.zip
mv PhantomBot-X.X.X phantombot
cd phantombot
chmod u+x ./launch.sh ./launch-service.sh ./java-runtime-linux/bin/java
./launch.sh</code></pre>

  <p>Suivez les instructions à l'écran pour la configuration initiale.</p>

  <h2>Configuration d'une unité systemd</h2>

  <p>Créez un fichier de service systemd pour PhantomBot :</p>

  <pre><code>sudo nano /etc/systemd/system/phantombot.service</code></pre>

  <p>Collez le contenu suivant dans le fichier :</p>

  <pre><code>[Unit]
Description=PhantomBot
After=network.target remote-fs.target nss-lookup.target

[Service]
User=botuser
Group=botuser
Restart=on-failure
RestartSec=30
ExecStart=/home/botuser/phantombot/launch-service.sh
KillSignal=SIGTERM
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target</code></pre>

  <p>Enregistrez et quittez l'éditeur.</p>

  <p>Installez le service et activez son démarrage au démarrage du système :</p>

  <pre><code>sudo systemctl daemon-reload
sudo systemctl enable phantombot</code></pre>

  <p>Accordez à l'utilisateur botuser les droits pour gérer le service :</p>

  <pre><code>sudo visudo</code></pre>

  <p>Ajoutez la ligne suivante à la fin du fichier :</p>

  <pre><code>botuser ALL=NOPASSWD: /bin/systemctl start phantombot, /bin/systemctl stop phantombot, /bin/systemctl restart phantombot, /bin/systemctl status phantombot</code></pre>

  <h2>Test du service</h2>

  <p>Testez les commandes du service :</p>

  <pre><code>sudo su - botuser
sudo systemctl start phantombot
sudo systemctl stop phantombot
sudo systemctl restart phantombot
sudo systemctl status phantombot</code></pre>

  <p>Le panneau de contrôle de PhantomBot devrait être accessible à <code>VOTRE-IP-SERVEUR:25000/panel</code>. Assurez-vous que le port 25000 est ouvert sur votre serveur.</p>

  <h2>Sauvegarde automatisée (optionnelle)</h2>

  <p>Créez une sauvegarde quotidienne pour PhantomBot :</p>

  <pre><code>sudo su - botuser
cd /home/botuser
mkdir -p backup/phantombot
crontab -e</code></pre>

  <p>Ajoutez la ligne suivante pour planifier des sauvegardes quotidiennes :</p>

  <pre><code>1 4 * * * umask 0007;/bin/tar --exclude=/home/botuser/phantombot/lib --exclude=/home/botuser/phantombot/web -cjf /home/botuser/backup/phantombot/$(/bin/date +%Y-%m-%d-%H_%M_%S_%3N).tar.bz2 /home/botuser/phantombot/ &gt;&gt;/home/botuser/backup/backup_phantombot.log 2&gt;&amp;1</code></pre>

  <p>Vérifiez la crontab pour vérifier la tâche planifiée :</p>

  <pre><code>crontab -l</code></pre>

  <p><em>Fin du README.md</em></p>

</body>

</html>
