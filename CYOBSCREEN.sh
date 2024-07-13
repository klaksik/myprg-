#!/bin/bash

# Обновлення списку пакетів
apt-get update

# Обновлення встановлених пакетів
apt-get upgrade -y

# Встановлення необхідних пакетів
apt-get install -y openjdk-17-jdk openjdk-17-jre wget screen

# Пряма посилання на JAR файл
jar_url="https://www.dropbox.com/scl/fi/xyfr2ifpqi5znr9lcbkk0/CYOB.jar?rlkey=bx5bhf18v6uyyxgh7y39n89qv&st=63m2gemo&dl=1"

# Завантаження JAR файлу
wget "$jar_url" -O $HOME/CYOB.jar

# Налаштування прав на файл
chmod 777 $HOME/CYOB.jar

# Створення скрипту для запуску програми через screen
run_script="$HOME/run_cyob.sh"

echo "#!/bin/bash
screen -dmS cyob java -jar $HOME/CYOB.jar" > $run_script

chmod +x $run_script

# Запуск програми через screen
$run_script

# Перевірка статусу screen сесії
screen -list
