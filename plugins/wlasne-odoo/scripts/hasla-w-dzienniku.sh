#!/usr/bin/env bash
# Uruchamiany NA SERWERZE: ssh odoo 'bash -s' < hasla-w-dzienniku.sh
# Wypisuje liczbę linii install.log zawierających którekolwiek hasło. Haseł nie wypisuje. Dobrze = 0.
set -u
cd /opt/odoo-pakiet || { echo "brak /opt/odoo-pakiet"; exit 1; }
[ -f install.log ] || { echo "brak install.log"; exit 1; }
wzorce=$(mktemp); trap 'rm -f "$wzorce"' EXIT; chmod 600 "$wzorce"
sed -n 's/^\(DB_PASSWORD\|ADMIN_PASSWD\)=//p' .env > "$wzorce"
cat /root/odoo-admin.txt /root/.restic-haslo 2>/dev/null >> "$wzorce"
sed -i '/^[[:space:]]*$/d' "$wzorce"
[ -s "$wzorce" ] || { echo "nie znaleziono haseł do porównania"; exit 1; }
grep -cFf "$wzorce" install.log || true
