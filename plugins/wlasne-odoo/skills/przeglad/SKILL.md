---
name: przeglad
description: Comiesięczny przegląd serwera Odoo kursanta (kopie, próba odtworzenia, dysk, certyfikat, restart, alarmy) bez żadnych zmian.
disable-model-invocation: true
---

Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

Na serwerze (`ssh odoo`) niczego nie zmieniaj. Pokaż jedną tabelę: wiek ostatniej kopii nocnej, wiek ostatniej kopii poza serwerem, wynik ostatniej próby odtworzenia (`/var/log/odoo-hosting.log`; gdy wpis nie ma daty, podaj datę zmiany pliku i napisz to wprost), wolne miejsce na dysku, data ważności certyfikatu, czy system czeka na restart (`/var/run/reboot-required`), alarmy z ostatniego miesiąca, czy alarm na telefon jest ustawiony (`ssh odoo 'bash -s' < "${CLAUDE_PLUGIN_ROOT}/scripts/alarm-ustawiony.sh"` ma wypisać `TAK`; inaczej tego nie sprawdzaj). Bez tematu ntfy alarmy nigdzie nie idą: wtedy odeślij do `/wlasne-odoo:kopie`, krok z alarmem.
Na końcu jedno zdanie: „wszystko w porządku” albo co kursant ma zrobić. Dopisz datę przeglądu do `moje-odoo.md`.
