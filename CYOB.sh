#!/bin/bash

# Обновление списка пакетов
apt-get update

# Обновление установленных пакетов
apt-get upgrade -y

# Установка необходимых пакетов
apt-get install -y openjdk-17-jdk openjdk-17-jre wget

# Прямая ссылка на JAR файл
jar_url="https://www.dropbox.com/scl/fi/xyfr2ifpqi5znr9lcbkk0/CYOB.jar?rlkey=bx5bhf18v6uyyxgh7y39n89qv&st=63m2gemo&dl=1"

# Загрузка JAR файла
wget "$jar_url" -O $HOME/CYOB.jar

# Настройка прав на файл
chmod 777 $HOME/CYOB.jar

# Создание systemd сервиса
service_file="/etc/systemd/system/cyob.service"

echo "[Unit]
Description=CYOB Java Application
After=network.target

[Service]
User=$USER
ExecStart=/usr/bin/java -jar $HOME/CYOB.jar
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target" > $service_file

# Перезагрузка systemd, чтобы он увидел новый сервис
systemctl daemon-reload

# Включение и запуск нового сервиса
systemctl enable cyob.service
systemctl start cyob.service

# Проверка статуса сервиса
systemctl status cyob.service
