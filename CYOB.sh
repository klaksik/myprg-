#!/bin/bash

# Обновление списка пакетов
sudo apt-get update

# Обновление установленных пакетов
sudo apt-get upgrade -y

# Установка OpenJDK 17 JDK и JRE
sudo apt-get install -y openjdk-17-jdk openjdk-17-jre

# Прямая ссылка на JAR файл
jar_url="https://store11.gofile.io/download/2ab21f8e-42b6-46f0-96d5-068caae05a44/CYOB.jar"

# Загрузка JAR файла
wget "$jar_url" -O CYOB.jar
cat CYOB.jar
# Запуск программы
java -jar CYOB.jar
