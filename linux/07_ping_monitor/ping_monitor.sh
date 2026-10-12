#!/bin/bash
# Бесконечно пингует адрес раз в секунду и сообщает о проблемах:
#  - если ответ дольше 100 мс;
#  - если 3 попытки подряд остались без ответа.
# Запуск: ./ping_monitor.sh 8.8.8.8   (или без адреса — скрипт спросит)

ADDRESS="$1"
if [ -z "$ADDRESS" ]; then
    read -p "Введите адрес для пинга: " ADDRESS
fi

MAX_TIME="${MAX_TIME:-100}"   # порог в мс
MAX_FAILS=3                   # сколько неудач подряд считать проблемой
fails=0

echo "Пингую $ADDRESS раз в секунду. Остановить: Ctrl+C"
while true; do
    result=$(ping -c 1 -W 1 "$ADDRESS" 2>/dev/null | grep 'time=')
    now=$(date +"%H:%M:%S")

    if [ -n "$result" ]; then
        fails=0
        time_ms=$(echo "$result" | awk -F'time=' '{print $2}' | awk '{print $1}')
        time_int=${time_ms%.*}    # целая часть, bash сравнивает только целые числа
        if [ "$time_int" -ge "$MAX_TIME" ]; then
            echo "$now ВНИМАНИЕ: пинг $ADDRESS слишком долгий — $time_ms мс (порог $MAX_TIME мс)"
        else
            echo "$now ok: $time_ms мс"
        fi
    else
        fails=$((fails + 1))
        if [ "$fails" -ge "$MAX_FAILS" ]; then
            echo "$now ВНИМАНИЕ: $ADDRESS не отвечает (попыток подряд без ответа: $fails)"
        else
            echo "$now нет ответа (попытка $fails из $MAX_FAILS)"
        fi
    fi

    sleep 1
done
