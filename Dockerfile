#FROM timhaak/base:latest
FROM ubuntu:trusty

MAINTAINER hernad@bring.out.ba
#thank you tim@haak.co.uk

RUN sed -e 's/archive./ba.archive./' /etc/apt/sources.list -i
RUN sudo apt-get update && sudo apt-get install -y supervisor ntp curl bind9utils dnsutils psmisc wget openssh-client vim


#RUN echo "deb http://shell.ninthgate.se/packages/debian wheezy main" > /etc/apt/sources.list.d/plexmediaserver.list && \
#    curl http://shell.ninthgate.se/packages/shell-ninthgate-se-keyring.key | apt-key add - && \
#    apt-get -q update && \
#    apt-get install -qy --force-yes plexmediaserver && \
#    apt-get -y autoremove && \
#    apt-get -y clean && \
#    rm -rf /var/lib/apt/lists/* && \
#    rm -rf /tmp/*

# https://plex.tv/downloads
https://downloads.plex.tv/plex-media-server/plexmediaserver_0.9.12.19.1537-f38ac80_amd64.deb

ENV PLEX_VER=0.9.12.19.1537-f38ac80
RUN curl -LO https://downloads.plex.tv/plex-media-server/${PLEX_VER}/plexmediaserver_${PLEX_VER}_amd64.deb
RUN dpkg -i plexmediaserver_${PLEX_VER}_amd64.deb

VOLUME ["/config","/data"]

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV RUN_AS_ROOT="true" \
    CHANGE_DIR_RIGHTS="false"

EXPOSE 32400

CMD ["/start.sh"]
