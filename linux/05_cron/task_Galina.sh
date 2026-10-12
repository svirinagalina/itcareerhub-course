#!/bin/bash
DIR="/opt/100726-wdm/Galina_Svirina/files"
mkdir -p "$DIR"
DATE=$(date +"%d.%m.%y")
for i in $(seq 1 10); do touch "$DIR/${i}_$DATE"; done
