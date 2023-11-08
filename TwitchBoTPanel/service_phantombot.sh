#!/bin/bash

# Contenu du fichier phantombot.service
cat <<EOL > /etc/systemd/system/phantombot.service
[Unit]
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
WantedBy=multi-user.target
EOL

# Enregistrez le fichier service
systemctl daemon-reload

# Activez le service pour qu'il démarre au démarrage
systemctl enable phantombot
