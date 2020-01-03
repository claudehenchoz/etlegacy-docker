FROM alpine:latest

LABEL maintainer="claude.henchoz@gmail.com"

RUN apk update && \
    apk upgrade && \
    apk add --no-cache p7zip curl && \
    rm -rf /var/cache/apk/*

# Get ET Legacy and Assets
RUN curl https://www.etlegacy.com/download/file/121 | tar xvz; mv etlegacy-v2.76-x86_64 etlegacy && \
    curl -o temp.exe http://trackbase.eu/files//et/full/WolfET_2_60b_custom.exe; 7z e temp.exe -oetlegacy/etmain etmain/pak*.pk3; rm temp.exe

# Allow downloads and set pass
RUN echo "set sv_allowDownload \"1\"" >> etlegacy/etmain/etl_server.cfg && \
    echo "set rconpassword \"etlegacy\"" >> etlegacy/etmain/etl_server.cfg

EXPOSE 27960/udp
USER root
WORKDIR /etlegacy
ENTRYPOINT ./etlded_bot.sh
