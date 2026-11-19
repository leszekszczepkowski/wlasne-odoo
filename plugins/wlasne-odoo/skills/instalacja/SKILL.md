---
name: instalacja
description: Lekcja 2 kursu „Własne Odoo Community” — sprawdza adres w DNS, instaluje Odoo z pakietu kursu na serwerze i robi kontrolę po instalacji.
disable-model-invocation: true
---

Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

Potrzebne dane: adres Odoo (np. odoo.twojafirma.pl), nazwa bazy (małe litery, bez spacji), pełna nazwa firmy, ścieżki do dwóch ZIP-ów ze strony kursu: pakietu instalacyjnego i dodatków (zwykle w Pobranych).

Nazwa firmy idzie w apostrofach, więc nie może zawierać prostego apostrofu `'` (typograficzny ’ jest w porządku). Jeśli zawiera, zatrzymaj się i zapytaj kursanta, czy zamienić go na ’.

## Krok 1. Czy adres już działa
Sprawdź `nslookup ADRES 1.1.1.1` i `nslookup ADRES 8.8.8.8`. Gdy wynik nie jest adresem IP serwera, powiedz dokładnie, jaki rekord ustawić u dostawcy domeny (typ A, nazwa, wartość), i sprawdzaj co 2 minuty, najdłużej 30 minut. Bez zgodnego adresu nie instaluj.

## Krok 2. Instalacja
1. Na serwerze: `apt-get update && apt-get install -y git tmux unzip` (na świeżym serwerze lista pakietów jest pusta, bez `update` instalacja się nie uda).
2. Jeśli `/opt/odoo-pakiet` już jest na serwerze, zatrzymaj się i zapytaj. Skopiuj ZIP pakietu instalacyjnego na serwer do `/tmp` (`scp`), rozpakuj `unzip -o PLIK.zip -d /tmp/pakiet` i przenieś folder z plikiem `install.sh` do `/opt/odoo-pakiet` (bez folderu nadrzędnego z ZIP-a). Sprawdź, że jest `/opt/odoo-pakiet/install.sh`.
3. Skopiuj ZIP z dodatkami na serwer do `/tmp` (`scp`), rozpakuj `unzip -o PLIK.zip -d /tmp/dodatki`. Znajdź katalogi `sz_*` z `__manifest__.py` i skopiuj je do `/opt/odoo-pakiet/addons-wlasne/` (bez katalogu nadrzędnego z ZIP-a). Pokaż listę modułów.
4. Uruchom w tmux w sesji „instalacja” to polecenie:
   `cd /opt/odoo-pakiet && DOMAIN=ADRES DB_NAME=BAZA FIRMA='NAZWA' bash install.sh 2>&1 | tee install.log; echo "KOD_WYJSCIA=${PIPESTATUS[0]}" | tee -a install.log`
   Nie wklejaj go w cudzysłowach do jednej linii `ssh` (PowerShell na Windows tnie cudzysłowy i na serwer dochodzi kawałek). Zapisz je w pliku `start.sh` na komputerze kursanta, skopiuj `scp start.sh odoo:/root/start.sh` i uruchom `ssh odoo tmux new-session -d -s instalacja bash /root/start.sh`. Sprawdź `ssh odoo tmux ls`, że sesja „instalacja” istnieje.
5. Co minutę mów krótko, na którym jest etapie (linie `== N/7`, potem `== N/5` to dodatki hostingu w etapie 7). Nie czytaj całego dziennika.
6. Koniec to linia `KOD_WYJSCIA` w `install.log`. Podaj kod i czas. Gdy kod nie jest 0: ostatnie 30 linii, przyczyna, nic nie poprawiaj i nie uruchamiaj drugi raz bez zgody.

## Krok 3. Kontrola po instalacji
Tabela „co / wynik / dobrze czy źle”:
1. `https://ADRES/web/login` zwraca 200.
2. Certyfikat: wystawca Let's Encrypt, data ważności.
3. `https://ADRES/web/database/manager` zwraca 404.
4. Login admin/admin odrzucony: POST na `https://ADRES/web/session/authenticate` z `{"jsonrpc":"2.0","params":{"db":"BAZA","login":"admin","password":"admin"}}` ma zwrócić błąd, nie uid. Jeśli uid — natychmiast powiedz.
5. `docker compose ps` w `/opt/odoo-pakiet`: działają db, odoo, caddy.
6. Z komputera kursanta: porty 8069, 8072, 5432, 2019 zamknięte.
7. `ssh -o PubkeyAuthentication=no -o BatchMode=yes root@ADRES_IP true` zwraca „Permission denied (publickey)” (gdy w nawiasie jest „password” — źle).
8. Każdy moduł z `modules.txt` ma stan installed (`docker compose exec -T db psql -U odoo -d BAZA -tAc` na `ir_module_module`). Z `modules-dodatki.txt` sprawdzaj tylko te moduły, których folder jest w `addons-wlasne/`; reszty kursant nie wgrał i to nie jest błąd.
9. `https://ADRES/mcp` odpowiada 401 albo 405, nie 404.
10. `/var/backups/odoo/zdrowie.txt` zawiera `OK` (linia zaczyna się od daty, potem `OK`), w crontab są backup.sh i zdrowie.sh.
11. Żadne hasło nie trafiło do dziennika: `ssh odoo 'bash -s' < "${CLAUDE_PLUGIN_ROOT}/scripts/hasla-w-dzienniku.sh"` ma wypisać `0`. Nie sprawdzaj tego inaczej.

W dzienniku instalacji pojawi się „Sprawdź w DRUGIM oknie…” (wypisuje to `zabezpiecz-serwer.sh` po przełączeniu logowania na sam klucz). Tak ma być, to nie błąd: skrypt prosi o sprawdzenie, że po zmianie da się zalogować na nowo. Zrób to sam: nowe połączenie `ssh odoo 'echo OK'` ma zwrócić `OK`. Powiedz kursantowi, co to za komunikat i że próba się udała. Gdy się nie uda, nie restartuj serwera i nic nie zmieniaj; powiedz kursantowi, że wejście awaryjne to konsola w panelu dostawcy serwera, i zatrzymaj się.

Sprawdzenie: wszystkie wiersze „dobrze”. Powiedz kursantowi, że teraz lekcja 3 (logowanie i zabezpieczenia robi sam), a potem `/wlasne-odoo:kopie`.
