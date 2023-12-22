if [ -z "$1" ]; then
    video_file='people.mp4'
else
    video_file=$1
fi
echo "Streaming: $video_file"
docker load --input simple-rtsp.tar
echo "protocols: [udp, tcp]" > rtsp-simple-server.yml
container=$(docker run -d --rm -it -v $PWD/rtsp-simple-server.yml:/rtsp-simple-server.yml -p 8554:8554 aler9/rtsp-simple-server)
ffmpeg -re -stream_loop -1 -i $video_file -c copy -f rtsp -rtsp_transport tcp rtsp:/192.168.1.111:8554/live
docker stop $container
docker container prune --force
