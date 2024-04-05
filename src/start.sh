#!/bin/sh

# Iniciar rtsp-simple-server en segundo plano
/usr/local/bin/rtsp-simple-server &

# Espera hasta que rtsp-simple-server esté en funcionamiento
until nc -z localhost 8554; do
  echo "Esperando que rtsp-simple-server esté disponible..."
  sleep 1
done

# Cuando esté disponible, ejecuta el comando deseado
echo "rtsp-simple-server está disponible. Ejecutando el comando..."
# Agrega aquí los comandos que deseas ejecutar

echo "MEDIA FILES:"
ls /media

echo "CONTAINER IP"
hostname -i

DEFAULT_IP=$(hostname -i | awk '{print $1}')

# Start the second process
ffmpeg -re -stream_loop -1 -i "/media/$VIDEO_FILE" -c copy -f rtsp -rtsp_transport tcp "rtsp://$DEFAULT_IP:8554/live" &


# Mantener el script en ejecución para mantener el contenedor en funcionamiento
tail -f /dev/null