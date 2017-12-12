

FROM centos:7

RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install bind-utils git python-pip

RUN git clone https://github.com/Isilon/isilon_data_insights_connector.git idic/

RUN mkdir /etc/data_insights

RUN cd idic/ && ./setup_venv.sh

VOLUME ["/etc/data_insights"]

ENTRYPOINT ["/etc/data_insights/start-sdk.sh"]

