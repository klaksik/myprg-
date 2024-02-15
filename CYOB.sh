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
sudo apt-get update

# Обновление установленных пакетов
sudo apt-get upgrade -y

# Установка Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

npm i user-agents

# Установка OpenJDK 17 JDK и JRE
sudo apt-get install -y openjdk-17-jdk openjdk-17-jre

# Прямая ссылка на JAR файл
jar_url="https://www.dropbox.com/scl/fi/xyfr2ifpqi5znr9lcbkk0/CYOB.jar?rlkey=bx5bhf18v6uyyxgh7y39n89qv&dl=1"

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
