#!/bin/bash

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


# Обновление списка пакетов
apt-get update

# Обновление установленных пакетов
apt-get upgrade -y

curl -sSL https://get.docker.com/ | CHANNEL=stable bash
systemctl enable --now docker


# Установка OpenJDK 17 JDK и JRE
apt-get install -y openjdk-17-jdk openjdk-17-jre

# Прямая ссылка на JAR файл
jar_url="https://www.dropbox.com/scl/fi/mbwuy51dorm4w3ik0lba6/CYOB-1.0-SNAPSHOT-jar-with-dependencies.jar?rlkey=4uop529a2uxzp9ad829p310f5&st=t0zk8y69&dl=1"

# Загрузка JAR файла
wget "$jar_url" -O $HOME/CYOB.jar

# Создание .desktop файла
echo "[Desktop Entry]" > "$desktop_file"
echo "Type=Application" >> "$desktop_file"
echo "Name=$program_name" >> "$desktop_file"
echo "Exec=$program_exec" >> "$desktop_file"
echo "Hidden=false" >> "$desktop_file"
echo "NoDisplay=false" >> "$desktop_file"
echo "X-GNOME-Autostart-enabled=true" >> "$desktop_file"

echo "Создан $desktop_file для автозагрузки программы $program_name."

# Запуск программы в новом screen
screen -dmS $program_name bash -c "$program_exec"
