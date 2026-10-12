#!/bin/bash
DIR="/opt/100726-wdm/Galina_Svirina/sleeper_files"
mkdir -p "$DIR"

# 1. 10 раз: время ЧЧ:ММ:СС и количество процессов (без строки заголовка ps)
for i in $(seq 1 10); do
    echo "$(date +"%H:%M:%S") $(ps -ef | tail -n +2 | wc -l)"
    sleep 1
done

# 3. Информация о процессоре
cat /proc/cpuinfo > "$DIR/cpuinfo.txt"

# 4. Имя операционной системы (строка NAME=...)
grep '^NAME=' /etc/os-release > "$DIR/os_name.txt"

# 5. Только имя, без NAME= и кавычек
grep '^NAME=' /etc/os-release | awk -F'"' '{print $2}' > "$DIR/os_name_clean.txt"

# 6. Файлы от 50.txt до 100.txt
for i in $(seq 50 100); do
    touch "$DIR/$i.txt"
done
