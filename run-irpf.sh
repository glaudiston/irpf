docker build -t dirpf:2020 . \
	--build-arg USERNAME=$USERNAME \
	--build-arg USERUID=$(id -u) \
	--build-arg USERGID=$(id -g) \
	--build-arg HOME=$HOME
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
# docker rm -vf dirpf2020
docker run \
	--name dirpf2020 \
	-ti \
	-v $XSOCK:$XSOCK \
	-v /usr/share/fonts:/usr/share/fonts \
	-v $XAUTH:$XAUTH \
	-v $PWD/data:$HOME/irpf-data \
	-e XAUTHORITY=$XAUTH dirpf:2020
