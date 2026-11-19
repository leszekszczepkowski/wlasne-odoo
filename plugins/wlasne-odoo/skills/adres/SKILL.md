---
name: adres
description: Zmiana adresu Odoo kursanta (z próbnego na adres firmy albo po literówce) w kursie „Własne Odoo Community”.
disable-model-invocation: true
---

Odpowiadaj po polsku od pierwszej wiadomości, także gdy wynik narzędzia jest po angielsku. Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

1. Sprawdź jak w kroku 1 polecenia `/wlasne-odoo:instalacja`, że nowy adres wskazuje na serwer. Bez tego nie zmieniaj niczego.
2. Zmień adres skryptem wtyczki (zmienia tylko linię DOMAIN w `.env` i pokazuje ją przed i po, bez reszty pliku): `ssh odoo 'bash -s' -- NOWY_ADRES < "${CLAUDE_PLUGIN_ROOT}/scripts/zmien-adres.sh"`. Pliku `.env` nie otwieraj sam.
3. `cd /opt/odoo-pakiet && docker compose up -d` i poczekaj, aż Caddy dostanie certyfikat.
4. W Odoo ustaw parametr systemowy `web.base.url` na `https://NOWY_ADRES` (przez konektor albo `odoo shell` tak, jak robi to install.sh).
5. Zapisz nowy adres w `moje-odoo.md`. Przypomnij: jeśli Claude był już podłączony do Odoo (lekcja 5), trzeba dodać konektor od nowa poleceniem `/wlasne-odoo:konektor`.
Sprawdzenie: `https://NOWY_ADRES/web/login` zwraca 200 z certyfikatem Let's Encrypt.
