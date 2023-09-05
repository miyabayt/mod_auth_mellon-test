# mod_auth_mellon

## create metadata

```bash
mkdir -p /tmp/mellon
cd /tmp/mellon
curl -O https://raw.githubusercontent.com/latchset/mod_auth_mellon/master/mellon_create_metadata.sh > mellon_create_metadata.sh
chmod +x mellon_create_metadata.sh

# e.g.)
# ./mellon_create_metadata.sh http://localhost:18080 http://localhost:18080/mellon
# Output files:
# Private key:               http_localhost_18080.key
# Certificate:               http_localhost_18080.cert
# Metadata:                  http_localhost_18080.xml
#
# Host:                      localhost
#
# Endpoints:
# SingleLogoutService:       http://localhost:18080/mellon/logout
# AssertionConsumerService:  http://localhost:18080/mellon/postResponse
```

## download metadata from idp

```bash
# e.g.)
# save as file (https://samlkit.com/service-provider > SAML METADATA) > /tmp/mellon/idp-metadata.xml
# cp /tmp/mellon/idp-metadata.xml /path/to/saml/
```

## copy metadata files

```bash
# e.g.)
# cp /tmp/mellon/http_localhost_18080.* /path/to/saml/
```

## docker run

```bash
docker build -t my-mellon .
docker run -dit --name my-mellon-test -p 18080:80 my-mellon
```

## open browser

http://localhost:18080/
