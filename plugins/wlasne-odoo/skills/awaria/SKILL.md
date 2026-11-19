---
name: awaria
description: Plan awaryjny kursu „Własne Odoo Community” — nowy komputer bez kopii klucza, zgubiony telefon z kodami do Odoo albo odtworzenie Odoo ze Storage Boxa na nowym serwerze.
disable-model-invocation: true
argument-hint: "[komputer | telefon | serwer]"
---

Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

Co się stało: $ARGUMENTS. Jeśli puste, zapytaj: komputer (straciłem klucz), telefon (straciłem kody do Odoo) czy serwer (serwer przepadł). Najpierw zawsze sprawdź, czy prostsze wyjście nie wystarcza: kopia klucza w menedżerze haseł, klucz do kodów w menedżerze haseł, kopie serwera w Hetznerze (Backups).

## Komputer: nowy komputer bez kopii klucza
1. Zrób nowy klucz jak w kroku 1 polecenia `/wlasne-odoo:serwer` i pokaż część publiczną.
2. Poprowadź w konsoli Hetznera: nowy klucz w Security → SSH Keys, przy serwerze system ratunkowy (Rescue) z tym kluczem, restart (Power cycle).
3. Połącz się z systemem ratunkowym (`ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@ADRES_IP`), znajdź dysk systemu (`lsblk`), zamontuj, dopisz nowy klucz publiczny na końcu `/root/.ssh/authorized_keys` na tym dysku, odmontuj, restart.
4. Gdy serwer wstanie: skrót `odoo` jak w `/wlasne-odoo:serwer`, sprawdź, że strona logowania zwraca 200.
5. Zapytaj, czy usunąć stary klucz z `authorized_keys` (gdy komputer ukradziono: tak).
Sprawdzenie: `ssh odoo hostname` działa, Odoo odpowiada.

## Telefon: zgubione kody do Odoo
1. Przeczytaj w kodzie `auth_totp`, jak wyłączyć drugi zamek dla jednego użytkownika, i powiedz, co zrobisz.
2. Po „tak” zrób to w `odoo shell` (tak jak install.sh uruchamia odoo shell), tylko dla loginu kursanta.
3. Przypomnij: zaraz po zalogowaniu włączyć kod z telefonu jeszcze raz i zapisać klucz do kodów w menedżerze haseł.
Sprawdzenie: kursant loguje się samym hasłem.

## Serwer: odtworzenie ze Storage Boxa na nowym serwerze
Warunek: nowy serwer z czystą instalacją z kursu (`/wlasne-odoo:serwer` i `/wlasne-odoo:instalacja`), ten sam adres i nazwa bazy.
1. Połącz nowy serwer ze Storage Boxem jak w `/wlasne-odoo:kopie`, krok 2, punkty 1–4. Nowy serwer ma nowy klucz, więc w `.ssh/authorized_keys` Storage Boxa podmieniasz linię starego serwera na nową (kluczem kursanta, jak w kroku 2; linię klucza kursanta zostaw). Hasło do kopii (restic) wgrywasz jak w `/wlasne-odoo:haslo`, część „Wgraj hasło do kopii na nowy serwer”. Nie przyjmuj hasła w rozmowie.
2. `restic snapshots`, wybierz ostatnią parę: baza i pliki.
3. Przeczytaj `hosting/test-odtworzenia.sh`, jak wyciąga z restic plik bazy i plików, i wyciągnij je tak samo do `/root/odtworzenie/`.
4. Pokaż daty i rozmiary, czekaj na „tak”. Potem `./przywroc.sh PLIK.dump PLIK.tgz --podmien`.
5. Sprawdź logowanie, liczbę faktur i kontaktów, kontrolę jak w kroku 3 `/wlasne-odoo:instalacja`.
6. `hosting/kopia-poza.sh` i `bash hosting/instaluj-hosting.sh`, żeby kopie szły dalej.
Sprawdzenie: kursant loguje się do odtworzonego Odoo, pierwsza kopia z nowego serwera jest w Storage Boxie.
