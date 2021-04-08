# docker run cmd to start up devbox with a docker connection to the host's docker daemon.
docker run -d -v "/var/run/docker.sock:/var/run/docker.sock" devbox

