############################################################
# Dockerfile to run Wolfenstein: Enemy Territory Containers
# Based on Ubuntu Image
############################################################

# Set the base image to use to Ubuntu
FROM ubuntu

# Set the file maintainer (your name - the file's author)
MAINTAINER Claude Henchoz

# Update the default application repository sources list
RUN apt-get update

# Install prereqs
RUN apt-get install -y --no-install-recommends p7zip-full tmux wget

# Install Wolfenstein: Enemy Territory Legacy
RUN wget --no-check-certificate -O etlegacy-v2.75-x86_64.sh https://www.etlegacy.com/download/file/86
RUN mkdir etlegacy
RUN bash ./etlegacy-v2.75-x86_64.sh --skip-license --prefix=etlegacy
RUN rm ./etlegacy-v2.75-x86_64.sh
RUN wget http://trackbase.eu/files//et/full/WolfET_2_60b_custom.exe
RUN 7z e WolfET_2_60b_custom.exe -oetlegacy/etmain etmain/pak*.pk3

RUN echo "set sv_allowDownload \"1\"" >> etlegacy/etmain/etl_server.cfg

RUN rm ./WolfET_2_60b_custom.exe
RUN rm -rf /var/lib/apt/lists/*


# Port to expose (default: 11211)
EXPOSE 27960
EXPOSE 27960/udp

# Default Memcached run command arguments
#CMD ["+set", "cl_allowDownload", "1", "+set", "g_protect", "1", "+set", "omnibot_enable", "1", "+set", "omnibot_path", "./legacy/omni-bot", "+exec", "etl_server.cfg"]

# Set the user to run etlegacy as daemon
USER root

# Set the entrypoint to etlegacy script
WORKDIR /etlegacy
#ENTRYPOINT ./etlded
ENTRYPOINT ./etlded_bot.sh
