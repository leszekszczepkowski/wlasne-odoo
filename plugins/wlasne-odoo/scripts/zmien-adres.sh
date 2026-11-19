#!/usr/bin/env bash
# Uruchamiany NA SERWERZE: ssh odoo 'bash -s' -- NOWY_ADRES < zmien-adres.sh
# Zmienia tylko linię DOMAIN= w /opt/odoo-pakiet/.env i pokazuje ją przed i po. Reszty pliku nie wypisuje.
set -eu
nowy=${1:?podaj nowy adres, np. odoo.twojafirma.pl}
case "$nowy" in *[!a-zA-Z0-9.-]*) echo "adres może mieć tylko litery, cyfry, kropki i myślniki"; exit 1;; esac
plik=/opt/odoo-pakiet/.env
echo "przed: $(grep '^DOMAIN=' "$plik")"
cp -p "$plik" "$plik.przed-zmiana-adresu"
sed -i "s|^DOMAIN=.*|DOMAIN=$nowy|" "$plik"
echo "po:    $(grep '^DOMAIN=' "$plik")"
