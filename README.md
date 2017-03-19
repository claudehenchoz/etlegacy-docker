# etlegacy-docker

# Run

    docker run -p 27960:27960/udp schreckgestalt/etlegacy

# Stop (All)

    docker stop $(docker ps -a -q)

# Delete

    docker image rm etlegacy -f

# Build

    docker build -t etlegacy .
