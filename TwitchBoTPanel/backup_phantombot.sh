#!/bin/bash

# Créez un répertoire de sauvegarde si nécessaire
mkdir -p /home/linunbu/backup/phantombot

# Utilisez crontab pour planifier la sauvegarde
(crontab -l ; echo "1 4 * * * umask 0007;/bin/tar --exclude=/home/linunbu/phantombot/lib --exclude=/home/linunbu/phantombot/web -cjf /home/linunbu/backup/phantombot/\$(/bin/date +\%Y-\%m-\%d-\%H_\%M_\%S_\%3N).tar.bz2 /home/linunbu/phantombot/ >>/home/linunbu/backup/backup_phantombot.log 2>&1") | crontab -
