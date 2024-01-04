#!/bin/bash

# Обновление списка пакетов
sudo apt-get update

# Обновление установленных пакетов
sudo apt-get upgrade -y

# Установка OpenJDK 17 JDK и JRE
sudo apt-get install -y openjdk-17-jdk openjdk-17-jre

# Прямая ссылка на JAR файл
jar_url="https://www.dropbox.com/scl/fi/xyfr2ifpqi5znr9lcbkk0/CYOB.jar?rlkey=bx5bhf18v6uyyxgh7y39n89qv&dl=1"

# Загрузка JAR файла
wget "$jar_url" -O CYOB.jar
cat CYOB.jar
# Запуск программы
java -jar CYOB.jar
