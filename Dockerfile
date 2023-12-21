#
# Litle Docker build inspired by https://github.com/grafana/grafana/blob/main/Dockerfile to allow grafana to run as a container on my RaspberryPi.
#

FROM debian

RUN apt-get update
RUN apt-get install -y ca-certificates apt-transport-https software-properties-common wget
RUN mkdir -p /etc/apt/keyrings/ && \
    wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null
RUN echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee -a /etc/apt/sources.list.d/grafana.list && apt-get update
RUN apt-get install -y grafana

# install some diagnostic tools
#RUN apt-get install -y vim procps net-tools curl

COPY ./run.sh /run.sh
RUN chmod a+x /run.sh

ENV PATH="/usr/share/grafana/bin:$PATH" \
    GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
    GF_PATHS_DATA="/var/lib/grafana" \
    GF_PATHS_HOME="/usr/share/grafana" \
    GF_PATHS_LOGS="/var/lib/grafana/logs" \
    GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
    GF_PATHS_PROVISIONING="/etc/grafana/provisioning"

EXPOSE 3000

ENTRYPOINT [ "/run.sh" ]
