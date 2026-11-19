---
name: ksef-test
description: Lekcja 6, część 2 kursu „Własne Odoo Community” — czysta kopia bazy, KSeF w trybie testowym, pierwsza faktura z UPO i powrót do czystej kopii.
disable-model-invocation: true
---

Odpowiadaj po polsku od pierwszej wiadomości, także gdy wynik narzędzia jest po angielsku. Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

Kolejność jest ważna: dane firmy, poczta i bank (polecenie `/wlasne-odoo:firma`) muszą być zrobione przed krokiem 1, bo powrót do kopii przywraca stan z kroku 1.

## Krok 1. Kopia „czysta” przed testami
Na serwerze w `/opt/odoo-pakiet`: `./backup.sh`. W `/var/backups/odoo` znajdź najnowszy plik bazy (`.dump`) i plików (`_filestore … .tgz`). Skopiuj do `/root/kopie-czyste/` jako `BAZA_RRRR-MM-DD_GGMM_czysta-przed-testami.dump` i `BAZA_filestore_RRRR-MM-DD_GGMM_czysta-przed-testami.tgz`. Oryginałów nie ruszaj. Porównaj sumy sha256, pokaż nazwy i rozmiary.
Sprawdzenie: dwa pliki „czysta-przed-testami”, sumy zgodne.

## Krok 2. KSeF w trybie testowym
1. Parametr systemowy `l10n_pl_edi_ksef.mode`: jeśli go nie ma albo ma inną wartość niż `test`, ustaw `test`. Bez tego parametru Odoo łączy się z produkcyjnym KSeF.
2. Odczytaj ponownie i pokaż wartość.
3. Przeczytaj w kodzie `l10n_pl_edi` na serwerze, jak ta wersja łączy firmę z testowym KSeF (certyfikat, kontekst NIP), i poprowadź kursanta z nazwami menu po polsku. Certyfikat wgrywa sam. Testowy KSeF przyjmuje samopodpisany certyfikat pieczęci firmy (RSA 2048, w podmiocie `organizationIdentifier = VATPL-NIP`): możesz go wygenerować na serwerze w `/root/ksef-test/` (klucz zostaje na serwerze, nie pokazuj go), a kursant wgrywa go w Ustawieniach. Do prawdziwego KSeF potrzebny jest certyfikat z Aplikacji Podatnika (`/wlasne-odoo:ksef`). 🟡 sprawdzone w teście 16.11.2026.
Sprawdzenie: parametr `test`, firma połączona z testowym KSeF.

## Krok 3. Pierwsza faktura
Faktura dla „Testowa sp. z o.o.”, NIP 1111111111, usługa „Konsultacja”, 1 godzina, 100 zł netto, VAT 23%. Pokaż przed zatwierdzeniem. Po „tak”: zatwierdź i wyślij do KSeF. Po kilkunastu sekundach odśwież status i pobierz UPO (to osobna akcja).
Sprawdzenie: faktura ma numer KSeF i UPO.

## Krok 4. Powrót do kopii „czysta”
To nadpisuje bazę. Pokaż nazwy, daty i zgodność sum sha256 kopii z `/root/kopie-czyste/` i czekaj na „tak”. Przeczytaj najpierw `przywroc.sh`: czy przyjmuje pliki spoza `/var/backups/odoo` i czy pyta o potwierdzenie; powiedz, jak to obsłużysz. Potem `./przywroc.sh PLIK.dump PLIK.tgz --podmien` (skrypt sam robi kopię stanu przed podmianą).
Sprawdzenie: logowanie 200, faktur 0, dane firmy, mapowanie banku i serwer poczty na miejscu. Po powrocie Odoo jest znów bez parametru trybu, czyli ustawione na produkcję: nie łącz się z KSeF, dopóki kursant nie zrobi `/wlasne-odoo:ksef`.
