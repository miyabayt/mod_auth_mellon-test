FROM httpd:2.4

RUN apt-get update && \
    apt-get install -y libapache2-mod-auth-mellon && \
    apt-get clean

RUN mkdir /usr/local/apache2/conf/include/ && \
    echo 'Include conf/include/*.conf ' >> /usr/local/apache2/conf/httpd.conf && \
    mkdir -p /etc/apache2/saml

COPY ./conf/*.conf /usr/local/apache2/conf/include/
COPY ./saml /etc/apache2/saml
