#!/usr/bin/with-contenv bashio

ACCOUNT=$(bashio::config 'account')
DOMAINS=$(bashio::config 'domains')
KEYFILE=$(bashio::config 'keyfile')
CERTFILE=$(bashio::config 'certfile')
DNS_PROVIDER=$(bashio::config 'dns.provider')
DNS_ENVS=$(bashio::config 'dns.env')

for env in $DNS_ENVS; do
    export $env
done

DOMAIN_ARR=()
for domain in $DOMAINS; do
    DOMAIN_ARR+=(-d "$domain ")
done

echo "Domains: $DOMAIN_ARR"

/root/.acme.sh/acme.sh --register-account -m ${ACCOUNT}

/root/.acme.sh/acme.sh --issue --dns "$DNS_PROVIDER" -d ha.frenking.eu --debug

/root/.acme.sh/acme.sh --install-cert ha.frenking.eu
--fullchain-file "/ssl/${CERTFILE}" \
--key-file "/ssl/${KEYFILE}" \

tail -f /dev/null
