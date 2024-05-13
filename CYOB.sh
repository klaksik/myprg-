#!/bin/bash


# Обновление списка пакетов
apt-get update

# Обновление установленных пакетов
apt-get upgrade -y



apt install screen
# Путь к программе и JAR файлу
program_name="CYOB"
program_exec="java -jar $HOME/CYOB.jar"
desktop_file="$HOME/.config/autostart/$program_name.desktop"


# Получаем список всех активных сеансов
SESSIONS=$(screen -ls | grep -oP "\d+\.$program_name")

# Перебираем каждый сеанс и завершаем его
while read -r session; do
  screen -S "$session" -X quit
done <<< "$SESSIONS"





curl -sSL https://get.docker.com/ | CHANNEL=stable bash
systemctl enable --now docker


# Установка OpenJDK 17 JDK и JRE
apt-get install -y openjdk-17-jdk openjdk-17-jre

# Прямая ссылка на JAR файл
jar_url="https://www.dropbox.com/scl/fi/q08ax3zvpar0jotpp0bce/CYOB-1.0-SNAPSHOT-jar-with-dependencies.jar?rlkey=g1emseiy5t557yr3582lihotb&st=0f16heug&dl=1"

# Загрузка JAR файла
wget "$jar_url" -O $HOME/CYOB.jar


chmod 777 $HOME/CYOB.jar


# Запуск программы в новом screen
screen -dmS $program_name bash -c "$program_exec"
