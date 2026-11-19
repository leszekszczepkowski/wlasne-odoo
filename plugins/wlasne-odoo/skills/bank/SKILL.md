---
name: bank
description: Podłączenie banku do Odoo kursanta przez Enable Banking (wyciągi pobierane same, bez plików CSV): konto i aplikacja w Enable Banking, plik .pem, „Połącz bank”, odnowienie zgody. Używaj, gdy kursant mówi „podłącz bank”, „Enable Banking”, „żeby wyciągi szły same”, „zgoda banku wygasa”.
---

Odpowiadaj po polsku od pierwszej wiadomości, także gdy wynik narzędzia jest po angielsku. Trzymaj się zasad kursu (wczytanych na starcie sesji; jeśli ich nie widzisz, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje. Działasz przez konektor do Odoo kursanta („Odoo moja firma”); jeśli go nie ma, odeślij do `/wlasne-odoo:konektor`.

Enable Banking to licencjonowany pośrednik (AISP), który przez PSD2 łączy się z ponad 2500 bankami w Europie, w tym z PKO BP, Pekao, Santanderem, mBankiem, ING, Millennium i Aliorem. Login do banku nigdy nie trafia do Odoo ani do Ciebie: kursant loguje się na stronie swojego banku, a zgoda trwa do 180 dni (zależnie od banku).

## Krok 1. Sprawdź Odoo
1. Moduł `l10n_pl_account_statement_import_online_enablebanking` ma stan `installed` (jest w pakiecie instalacyjnym). Jeśli nie, zatrzymaj się i odeślij do `/wlasne-odoo:aktualizacja`.
2. Użytkownik, który podłącza bank, musi mieć pełne prawa księgowe: grupy `account.group_account_manager` i `account.group_account_user` („Pokaż pełne funkcje księgowe”). Pakiet nadaje je administratorowi przy instalacji. Jeśli ich brak, pokaż, co dodasz, i dodaj po „tak”. Z samymi prawami do faktur połączenie się uda, ale pierwsze pobranie skończy się błędem dostępu.
3. Adres Odoo musi działać po HTTPS (lekcja 2), bo bank wraca pod `https://ADRES_ODOO/l10n_pl_enablebanking/callback`.

## Krok 2. Konto i aplikacja w Enable Banking (kursant klika sam)
Prowadź krok po kroku, jeden krok na raz:
1. Załóż darmowe konto na https://enablebanking.com/sign-in/.
2. W „API applications” zarejestruj aplikację. „Sandbox” = banki testowe (dobre na próbę), „Production” = prawdziwe konta. Zostaw domyślną opcję klucza. W „Allowed redirect URL” wklej `https://ADRES_ODOO/l10n_pl_enablebanking/callback` (podstaw adres z `moje-odoo.md`).
3. Production wymaga też adresu polityki prywatności i regulaminu (Privacy URL, Terms URL). Zapytaj kursanta, czy ma je na stronie firmy. Jeśli nie ma, powiedz to wprost i zaproponuj na dziś Sandbox.
4. Przeglądarka pobierze plik `.pem`. To klucz prywatny aplikacji: kursant trzyma go u siebie, nie wkleja do rozmowy i nie wysyła mailem. Ty go nie otwierasz.
5. Production: przy aplikacji kliknij „Activate by linking accounts” i połącz konta w każdym banku (tryb ograniczony, tylko własne konta). Powiedz kursantowi, że według dokumentacji modułu stałe używanie w firmie wymaga umowy z Enable Banking; warunki i cenę sprawdza u nich sam.

## Krok 3. Połącz bank w Odoo (kursant klika sam)
1. Fakturowanie → Bank → „Połącz bank” (albo „Połącz bank” na kafelku banku na pulpicie).
2. Na pytanie, czy ma aplikację Enable Banking, odpowiada „Tak” i wgrywa plik `.pem`. Nazwa pliku to identyfikator aplikacji, Odoo wpisze go samo i sprawdzi klucz. Klucz wpisuje się raz, później można go zmienić w Ustawieniach → Bank i gotówka → Enable Banking.
3. Wybiera bank (Revolut albo konto za granicą: zaznacza „Banki ze wszystkich krajów”), loguje się na stronie banku i potwierdza.
4. Po powrocie Odoo zakłada dziennik banku dla każdego konta (nazwa, IBAN, waluta) i pobiera ostatnie 30 dni. Dziennik z tym samym IBAN-em zostaje użyty ponownie, a pierwsze konto trafia do pustego dziennika „Bank”, zamiast tworzyć nowy.

Sprawdzenie: przez konektor odczytaj dzienniki banku i liczbę pobranych pozycji z ostatnich 30 dni. Kursant porównuje saldo z bankiem. Treści wierszy z nazwiskami i numerami kont nie wypisujesz.

## Na co dzień
- Nowe pozycje pobiera zaplanowana akcja „Pull Online Bank Statements”, od ręki przycisk „Pobierz teraz” na kafelku banku.
- Uzgadnianie wpłat z fakturami: umiejętność `wyciag` (od kroku 3) albo Bank → Do uzgodnienia.
- Bank → Połączenia z bankami: lista zgód z datą wygaśnięcia. Siedem dni przed końcem Odoo dopisuje wiadomość. „Odnów zgodę” = ponowne logowanie w banku, „Rozłącz” kończy dostęp (dzienniki i wyciągi zostają).
- Gdy pobieranie stanęło: sprawdź datę zgody, wiadomości na połączeniu i dziennik serwera (`/wlasne-odoo:awaria`).
