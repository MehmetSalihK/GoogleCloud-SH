<!DOCTYPE html>
<html lang="fr">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>

  <h1>Guide d'installation PhantomBot pour Ubuntu 16.04</h1>

  <h2>1. Préparer votre système</h2>

  <p>La première étape consiste à s'assurer que votre système est à jour. Avant d'installer quoi que ce soit, vérifiez si c'est le cas :</p>

  <pre><code>sudo apt update &amp;&amp; sudo apt upgrade</code></pre>

  <h2>2. Installation de PhantomBot</h2>

  <p>Nous sommes maintenant prêts à installer PhantomBot dans notre répertoire linunbu. Commencez par basculer vers votre utilisateur linunbu :</p>

  <pre><code>cd /home/linunbu
wget https://github.com/PhantomBot/PhantomBot/releases/download/v3.10.3.0/PhantomBot-3.10.3.0-full.zip
unzip PhantomBot-3.10.3.0-full.zip
mv PhantomBot-3.10.3.0 phantombot
cd phantombot
chmod u+x ./launch.sh ./launch-service.sh ./java-runtime-linux/bin/java
./launch.sh</code></pre>

  <p>Maintenant, PhantomBot devrait démarrer et vous guider à travers la configuration initiale. Après la configuration du bot, vous pouvez appuyer sur Ctrl + C pour l'arrêter et suivre les étapes suivantes pour le configurer en tant que service en arrière-plan.</p>

  <h2>3. Configuration d'une unité systemd</h2>

  <p>Créez un nouveau fichier appelé phantombot.service. J'utilise nano, mais vous pouvez également utiliser vi pour écrire des fichiers.</p>

  <pre><code>sudo nano /etc/systemd/system/phantombot.service</code></pre>

  <p>Collez ceci dans le fichier :</p>

  <pre><code>[Unit]
Description=PhantomBot
After=network.target remote-fs.target nss-lookup.target

[Service]
User=linunbu
Group=linunbu
Restart=on-failure
RestartSec=30
ExecStart=/home/linunbu/phantombot/launch-service.sh
KillSignal=SIGTERM
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target</code></pre>

  <p>Ensuite, installez le fichier créé pour qu'il s'exécute au démarrage en tant que service :</p>

  <pre><code>sudo systemctl daemon-reload
sudo systemctl enable phantombot</code></pre>

  <p>Enfin, nous devons rendre les commandes pour démarrer|arrêter|redémarrer|vérifier l'état de PhantomBot fonctionnelles. Ouvrez le fichier sudoers pour accorder à votre utilisateur linunbu les droits pour exécuter ces commandes.</p>

  <pre><code>sudo visudo</code></pre>

  <p>Ajoutez ceci à la fin du fichier :</p>

  <pre><code>linunbu ALL=NOPASSWD: /bin/systemctl start phantombot, /bin/systemctl stop phantombot, /bin/systemctl restart phantombot, /bin/systemctl status phantombot</code></pre>

  <p>Maintenant, l'utilisateur linunbu devrait avoir les droits pour exécuter les commandes spécifiques pour démarrer|arrêter|redémarrer|vérifier l'état de PhantomBot. Essayons !</p>

  <p>Ensuite, en tant que linunbu, essayez :</p>

  <pre><code>sudo systemctl start phantombot
sudo systemctl stop phantombot
sudo systemctl restart phantombot
sudo systemctl status phantombot</code></pre>

  <p>Si vous avez configuré tout correctement, cela démarrera|arrêtera|redémarrera|affichera l'état de PhantomBot.</p>

  <p>Après le démarrage de PhantomBot, vous pouvez trouver votre panneau de contrôle à l'adresse IP DE VOTRE SERVEUR:25000/panel. Assurez-vous d'ouvrir le port 25000 sur votre serveur.</p>

  <h2>Optionnel - Sauvegarde toutes les 24 heures</h2>

  <pre><code>cd /home/linunbu
mkdir -p backup/phantombot
crontab -e</code></pre>

  <p>Ajoutez cette ligne pour planifier des sauvegardes quotidiennes :</p>

  <pre><code>1 4 * * * umask 0007;/bin/tar --exclude=/home/linunbu/phantombot/lib --exclude=/home/linunbu/phantombot/web -cjf /home/linunbu/backup/phantombot/$(/bin/date +%Y-%m-%d-%H_%M_%S_%3N).tar.bz2 /home/linunbu/phantombot/ >>/home/linunbu/backup/backup_phantombot.log 2>&amp;1</code></pre>

  <p>Utilisez ceci pour vérifier votre crontab par la suite :</p>

  <pre><code>crontab -l</code></pre>

  <p><em>Fin du TwitchPanelBot.md</em></p>

</body>

</html>
