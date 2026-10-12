#!/bin/bash
# Показывает права на файлы в папке группы
# и добавляет право на исполнение .sh-файлам, у которых его нет
DIR="/opt/100726-wdm"

echo "=== Права на файлы в $DIR ==="
find "$DIR" -type f -exec ls -l {} \;

echo
echo "=== Проверка .sh файлов ==="
find "$DIR" -type f -name "*.sh" | while read -r file; do
    if [ -x "$file" ]; then
        echo "уже исполняемый: $file"
    else
        chmod +x "$file"
        echo "добавлено право на исполнение: $file"
    fi
done
