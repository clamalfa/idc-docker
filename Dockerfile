

FROM centos:7

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install bind-utils git python-pip && \
    mkdir /etc/data_insights

RUN git clone https://github.com/Isilon/isilon_data_insights_connector.git /idic

WORKDIR /idic

RUN ./setup_venv.sh && \
    touch isi_data_insights_d.log

COPY ./start-sdk.sh ./

COPY ./dashboards/* /var/lib/grafana/dashboards

ENTRYPOINT ["./start-sdk.sh"]
