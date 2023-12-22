# rtsp-server
Untar the docker image with following command:

>docker load --input simple-rtsp.tar

Run below commands:

>echo "protocols: [udp, tcp]" > rtsp-simple-server.yml
>docker run -d --rm -it -v $PWD/rtsp-simple-server.yml:/rtsp-simple-server.yml -p 8554:8554 aler9/rtsp-simple-server

Download video file and capture your system ip and replace in following command:

>ffmpeg -re -stream_loop -1 -i people.mp4 -c:v copy -f rtsp -rtsp_transport tcp rtsp://127.0.0.1:8554/video1
