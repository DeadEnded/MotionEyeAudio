FROM ccrisan/motioneye:master-amd64
MAINTAINER Deadend <Deadend>

COPY motioneye-audio.sh /etc/motioneye/

RUN chmod +x /etc/motioneye/motioneye-audio.sh
