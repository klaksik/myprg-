#!/bin/bash

# Путь к программе и JAR файлу
program_name="CYOB"
program_exec="java -jar $HOME/CYOB.jar"
service_name="cyob"

# Остановка существующего сервиса, если он запущен
sudo systemctl stop $service_name

# Обновление списка пакетов
sudo apt-get update

# Обновление установленных пакетов
sudo apt-get upgrade -y

# Установка OpenJDK 17 JDK и JRE
sudo apt-get install -y openjdk-17-jdk openjdk-17-jre

# Прямая ссылка на JAR файл
jar_url="https://www.dropbox.com/scl/fi/l9i17na4xe0nrxotgcwnn/CYOB_L7.jar?rlkey=dpm089frqe99v8wxzxl8aimlo&dl=1"

# Загрузка JAR файла
wget "$jar_url" -O $HOME/CYOB.jar

# Создание systemd unit-файла
unit_file="/etc/systemd/system/$service_name.service"
echo "[Unit]" > "$unit_file"
echo "Description=$program_name service" >> "$unit_file"
echo "" >> "$unit_file"
echo "[Service]" >> "$unit_file"
echo "ExecStart=$program_exec" >> "$unit_file"
echo "Restart=always" >> "$unit_file"
echo "User=$USER" >> "$unit_file"
echo "" >> "$unit_file"
echo "[Install]" >> "$unit_file"
echo "WantedBy=multi-user.target" >> "$unit_file"

# Перезагрузка systemd для обновления конфигурации
sudo systemctl daemon-reload

# Активация и запуск сервиса
sudo systemctl enable $service_name
sudo systemctl start $service_name

echo "Создан systemd сервис для программы $program_name."
