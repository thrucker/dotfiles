#!/bin/bash

CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8081/api/health)

if [ "$CODE" -lt "400" -a "$CODE" -ne "000" ]; then
  COLOR="color=#00FF00"
  HREF="href=http://localhost:8081/home"
else
  COLOR="color=#FF0000"
  HREF=""
fi

echo "RPLAN| $COLOR $HREF"
