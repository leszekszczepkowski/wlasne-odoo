---
name: kopie
description: Lekcja 4 kursu „Własne Odoo Community” — alarm na telefon przez ntfy, kopia poza serwerem w Storage Boxie (tylko dopisywanie) i próba odtworzenia.
disable-model-invocation: true
---

Odpowiadaj po polsku od pierwszej wiadomości, także gdy wynik narzędzia jest po angielsku. Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

Dodatki hostingu zainstalowała już instalacja. Nie uruchamiaj `instaluj-hosting.sh` przed krokiem 2.7.

## Krok 1. Alarm na telefon
1. Wylosuj nazwę kanału (`openssl rand -hex 12` na serwerze) i wpisz ją jako `NTFY_TOPIC` w `/opt/odoo-pakiet/hosting/hosting.env`.
2. Powiedz, co wpisać w aplikacji ntfy na telefonie, żeby zasubskrybować kanał. Nazwa kanału działa jak hasło: pokaż ją ten jeden raz, nie zapisuj w `moje-odoo.md`.
3. Gdy kursant powie „gotowe”: `hosting/alarm.sh "Test alarmu" "jeśli to widzisz, alarm działa" zwykly`.
4. Przy powtórce użyj innego tytułu (ten sam tytuł jest wyciszany na 6 godzin).
Sprawdzenie: kursant potwierdza, że alarm przyszedł.

## Krok 2. Kopia poza serwerem (Storage Box)
Potrzebne: użytkownik i adres Storage Boxa z jego karty w konsoli Hetznera (zapisz w `moje-odoo.md`). Storage Box musi być założony z kluczem `odoo-hetzner` wybranym przy tworzeniu (lekcja 4, krok 1): tym kluczem z komputera kursanta wgrywasz linię dla serwera, bez hasła Storage Boxa i bez terminala. Klucza nie da się dodać w konsoli po utworzeniu. Jeśli Storage Box powstał bez klucza, a jest jeszcze pusty, poproś kursanta, żeby go usunął i założył od nowa z kluczem.
1. Odczytaj z `hosting/instaluj-hosting.sh`, jak budowana jest linia do `.ssh/authorized_keys` Storage Boxa (z ograniczeniem do dopisywania), i zbuduj ją dla klucza `/root/.ssh/kopia_poza.pub`. Pokaż ją (to klucz publiczny).
2. Z komputera kursanta, kluczem `~/.ssh/odoo_hetzner` (port 23, `-o BatchMode=yes -o StrictHostKeyChecking=accept-new`): pobierz przez `sftp -b` obecny `.ssh/authorized_keys` Storage Boxa do pliku `storagebox_authorized_keys` w bieżącym folderze, dopisz na końcu linię z punktu 1 i wgraj plik z powrotem jako `.ssh/authorized_keys` (najpierw `-mkdir .ssh`). Linii klucza kursanta nie usuwaj: to jego dostęp administratora do Storage Boxa, potrzebny przy odtworzeniu. Gdy logowanie kluczem się nie uda, Storage Box powstał bez klucza (patrz wyżej). Hasła Storage Boxa nie przyjmuj i nie każ go wpisywać.
3. Na serwerze: `ssh-keyscan -p 23 ADRES_BOXA >> /root/.ssh/known_hosts`. Pokaż odcisk.
4. W `hosting/hosting.env` ustaw `RESTIC_REPOSITORY=rclone:` i `RESTIC_RCLONE_PROGRAM="ssh -p 23 -i /root/.ssh/kopia_poza -o BatchMode=yes UZYTKOWNIK@ADRES_BOXA"`.
5. `hosting/kopia-poza.sh` i pokaż wynik.
6. Sprawdź na atrapie, że serwer nie może kasować: `restic backup --tag test-kasowania /etc/hostname`, potem `restic forget` na identyfikatorze tej atrapy. Ma przyjść odmowa (403). Jeśli kasowanie się uda, natychmiast powiedz: linia w Storage Boxie jest zła.
7. `bash hosting/instaluj-hosting.sh` (włącza stałe zadania kopii) i `crontab -l`: linie z kopia-poza i ZRODLO=poza czynne, bez `#`.
8. Hasło do kopii: zrób to, co opisuje `/wlasne-odoo:haslo` (pokaż hasło `kopia`). Kursant przepisuje je do menedżera haseł i na kartkę.
Sprawdzenie: kopia w Storage Boxie, odmowa kasowania atrapy, zadania czynne.

## Krok 3. Próba odtworzenia
1. `hosting/kopia-poza.sh` (świeża kopia).
2. Policz w bazie: zainstalowane moduły, firmy, `ir_attachment`, pliki w filestore (`find … -type f | wc -l`).
3. `ZRODLO=poza hosting/test-odtworzenia.sh`.
4. Tabela: liczby w bazie i w odtworzonej kopii obok siebie, czas odtworzenia.
5. Baza tymczasowa skasowana, strona logowania zwraca 200.
Sprawdzenie: liczby się zgadzają. Następny krok: `/wlasne-odoo:konektor`.
