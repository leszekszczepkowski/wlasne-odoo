#!/usr/bin/env bash
# Wtyczka „wlasne-odoo”: czy alarm na telefon (ntfy) jest ustawiony. Uruchamiane na serwerze:
#   ssh odoo 'bash -s' < scripts/alarm-ustawiony.sh
# Wypisuje tylko TAK albo NIE. Treści pliku z hasłami nie pokazuje.
if grep -Eq '^NTFY_TOPIC=.+' /opt/odoo-pakiet/.env 2>/dev/null; then echo TAK; else echo NIE; fi
