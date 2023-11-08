chmod +x backup_phantombot.sh
chmod +x phantombot_service.sh
sudo ./backup_phantombot.sh
sudo ./phantombot_service.sh
wget https://github.com/PhantomBot/PhantomBot/releases/download/v3.10.2.1/PhantomBot-3.10.2.1-lin.zip
unzip PhantomBot-3.10.2.1-lin.zip
mv PhantomBot-3.10.2.1 phantombot
rm -rf PhantomBot-3.10.2.1-lin.zip
cd phantombot
chmod u+x ./launch.sh ./launch-service.sh ./java-runtime-linux/bin/java
cd phantombot/
sudo ./launch.sh

sudo systemctl daemon-reload
sudo systemctl enable phantombot
sudo systemctl start phantombot