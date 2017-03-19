# etlegacy-docker

# Build

    docker build -t etlegacy_img .

# Run

    docker run -p 27960:27960/udp etlegacy_img

# Stop (All)

    docker stop $(docker ps -a -q)

# Delete

    docker image rm etlegacy_img -f
