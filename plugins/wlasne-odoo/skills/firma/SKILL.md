---
name: firma
description: Lekcja 6, część 1 kursu „Własne Odoo Community” — dane firmy, konto pracownika, poczta wychodząca i pierwszy wyciąg z banku w Odoo kursanta.
disable-model-invocation: true
---

Odpowiadaj po polsku od pierwszej wiadomości, także gdy wynik narzędzia jest po angielsku. Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

Działasz w Odoo kursanta przez konektor do Odoo kursanta („Odoo moja firma”). Jeśli konektora nie ma, odeślij do `/wlasne-odoo:konektor`. Zrób kroki po kolei; kursant może pominąć krok, którego dziś nie potrzebuje.

## Krok 1. Dane firmy
Zapytaj o: NIP, adres, telefon, e-mail, stronę, numer rachunku i bank. Kraj Polska, waluta PLN. Pokaż w tabeli, co wpiszesz, czekaj na „tak”, wpisz i pokaż, co zapisane.
Zapytaj, czy kursant prowadzi firmę sam. Jeśli tak, ustaw parametr systemowy `sz_hosting.cztery_oczy` na `0` (prośby z aplikacji Hosting nie czekają na drugą osobę). Logo kursant wgrywa sam w Ustawieniach.

## Krok 2. Pracownik (jeśli jest)
Zapytaj o imię i nazwisko, e-mail, co ta osoba ma robić i czy ma używać Claude'a z Odoo. Zaproponuj prawa w tabeli „aplikacja / poziom / dlaczego”. Jeśli ma używać Claude'a, dodaj grupę „Konektor MCP” na najniższym potrzebnym poziomie. Nigdy praw administratora. Konto zakładasz po „tak”.

## Krok 3. Poczta wychodząca
Zapytaj o adres i dostawcę poczty. Powiedz, jaki sposób jest najprostszy w Odoo 19 Community (SMTP, przy Google z hasłem aplikacji, albo logowanie przez Google lub Microsoft) i dlaczego. Prowadź krok po kroku; hasła kursant wpisuje sam w Odoo. Ustaw adres nadawcy i domenę aliasów. Wyślij próbny mail i sprawdź stan „wysłany”.
Sprawdzenie: mail przyszedł do skrzynki kursanta.

## Krok 4. Pierwszy wyciąg z banku (CSV)
1. Kursant podaje ścieżkę do pliku CSV z banku. Rozpoznaj kodowanie (na bajtach: UTF-8 czy windows-1250), separator, wiersz nagłówka, format dat i kwot. Czytaj tylko nagłówek i strukturę; jeśli musisz zobaczyć przykład wiersza, zamaskuj nazwiska i numery kont.
2. Przygotuj mapowanie dla `account_statement_import_sheet_file`; przy windows-1250 ustaw kodowanie w mapowaniu (moduł `sz_statement_import_encoding`).
3. Wczytaj mapowanie (`szablony-bank/zaladuj-mapowanie.py` w `/opt/odoo-pakiet`, według README tego katalogu) i ustaw jako domyślne w dzienniku banku.
4. Powiedz, gdzie kliknąć, żeby wczytać plik, i co sprawdzić (saldo końcowe, polskie znaki). Odoo samo dopasuje wpłatę do faktury, gdy tytuł przelewu to sam numer faktury.
Sprawdzenie: saldo końcowe w Odoo zgadza się z bankiem. Następny krok: `/wlasne-odoo:ksef-test`.
