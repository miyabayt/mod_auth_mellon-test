FROM httpd:2.4 as build

ARG MELLON_VERSION=0.18.1

RUN apt-get update && \
    apt-get install -y build-essential apache2-dev liblasso3 pkg-config liblasso3-dev libcurl4-openssl-dev curl libxmlsec1 libxmlsec1-dev ca-certificates

RUN mkdir /tmp/mod_auth_mellon && \
    curl -L https://github.com/latchset/mod_auth_mellon/archive/v${MELLON_VERSION}.tar.gz | tar -xvz -C /tmp/mod_auth_mellon --strip 1 && \
    cd /tmp/mod_auth_mellon && \
    autoreconf && \
    ./configure --with-apxs2=/usr/local/apache2/bin/apxs && \
    make && \
    make install


FROM httpd:2.4

RUN apt-get update && \
    apt-get install -y openssl liblasso3 libxmlsec1

COPY --from=build /usr/local/apache2/modules/mod_auth_mellon.so /usr/local/apache2/modules/mod_auth_mellon.so

RUN mkdir /usr/local/apache2/conf/include/ && \
    echo 'Include conf/include/*.conf ' >> /usr/local/apache2/conf/httpd.conf && \
    mkdir -p /etc/apache2/saml

COPY ./conf/*.conf /usr/local/apache2/conf/include/
COPY ./saml /etc/apache2/saml
