# Usa la imagen base alpine
FROM alpine
WORKDIR /
ENV VIDEO_FILE='/media/people.mp4'
VOLUME [ "/media" ]

# Instala ffmpeg
RUN apk add --no-cache ffmpeg netcat-openbsd

# Copia los archivos desde la carpeta src al contenedor
COPY src/start.sh /usr/local/bin/start_server.sh
COPY src/rtsp-simple-server /usr/local/bin/rtsp-simple-server
RUN echo "protocols: [udp, tcp]" > /rtsp-simple-server.yml

# Copia el archivo de configuración supervisord
#COPY src/supervisord.conf /etc/supervisord.conf

# Establece permisos de ejecución para el script
RUN chmod +x /usr/local/bin/start_server.sh
RUN chmod +x /usr/local/bin/rtsp-simple-server

# Define el comando que se ejecutará al iniciar el contenedor
#CMD ["supervisord", "-c", "/etc/supervisord.conf"]
CMD ["sh", "-c", "/usr/local/bin/start_server.sh"]


EXPOSE 8554
