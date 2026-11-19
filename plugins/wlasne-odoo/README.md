# Wtyczka „Własne Odoo Community”

Wtyczka do Claude Code dla kursantów kursu „Własne Odoo Community” (szczepkowski.ai). Claude prowadzi Cię krok po kroku od serwera w Hetznerze do pierwszej faktury w KSeF, a potem pomaga w codziennej pracy w Odoo 19 Community.

## Instalacja

W aplikacji Claude na komputerze, w zakładce **Code**, w folderze `odoo-kurs` wpisz:

najpierw:

```
/plugin marketplace add leszekszczepkowski/wlasne-odoo
```

a potem:

```
/plugin install wlasne-odoo@szczepkowski-ai
```

Wybierz „Install for you, in this repo only” (wtyczka działa tylko w folderze kursu). Potem wpisz `/wlasne-odoo:start`.

Nową wersję wtyczki pobierzesz poleceniem `/plugin marketplace update szczepkowski-ai`. Bez GitHuba możesz zainstalować wtyczkę z ZIP-a ze strony kursu (plik `INSTALACJA.txt`).

Wtyczka sama nic nie zainstaluje: potrzebuje pakietu instalacyjnego i dodatków, które pobierasz po zalogowaniu na stronie kursu.

## Polecenia kursu

| Lekcja | Polecenie |
|---|---|
| start albo powrót po przerwie | `/wlasne-odoo:start` |
| 1. Serwer | `/wlasne-odoo:serwer` |
| 2. Adres i instalacja | `/wlasne-odoo:instalacja`, w razie potrzeby `/wlasne-odoo:adres` |
| 4. Kopie i alarm | `/wlasne-odoo:kopie` |
| 5. Claude w Twoim Odoo | `/wlasne-odoo:konektor` |
| 6. Firma i pierwsza faktura | `/wlasne-odoo:firma`, `/wlasne-odoo:ksef-test`, `/wlasne-odoo:ksef` |
| bank bez plików CSV (Enable Banking) | `/wlasne-odoo:bank` |
| raz w miesiącu | `/wlasne-odoo:przeglad` |
| raz na kwartał | `/wlasne-odoo:aktualizacja` |
| gdy coś się stanie | `/wlasne-odoo:alarm`, `/wlasne-odoo:awaria` |

## Na co dzień

Claude sam sięga po te umiejętności, gdy o to poprosisz („wystaw fakturę”, „kto mi nie zapłacił”): `faktura`, `wyciag`, `bank`, `haslo`, `nieoplacone`, `miesiac`, `odoomaster`.

## Polecane wtyczki innych autorów (nieobowiązkowe)

Do budowy własnych modułów i aplikacji, w osobnym folderze, nie w folderze kursu. Obie na licencji MIT, instalujesz je prosto z repozytoriów autorów:

- agent-skills (Addy Osmani): `/plugin marketplace add addyosmani/agent-skills`, potem `/plugin install agent-skills@addy-agent-skills`
- ponytail (Dietrich Gebert): `/plugin marketplace add DietrichGebert/ponytail`, potem `/plugin install ponytail@ponytail` (potrzebuje Node.js; tabelkę kosztów zapisuje lokalnie, webhook domyślnie pusty)

## Bezpieczeństwo

Wszystko dzieje się na Twoim komputerze i Twoim kluczem. Nikt z zewnątrz nie dostaje dostępu do Twojego serwera. Strażnik wtyczki nie pozwala Claude’owi otworzyć plików z hasłami ani klucza prywatnego, a przed krokami, których nie da się cofnąć (przywrócenie bazy, kasowanie), zawsze pyta Cię o zgodę. Twoje dane bez haseł (adres serwera, adres Odoo, nazwa bazy) Claude zapisuje w pliku `moje-odoo.md` w folderze kursu.

Na Windows strażnik potrzebuje Git for Windows (Git Bash).

## Licencja

Kod wtyczki jest publiczny, żeby kursanci zawsze mieli aktualną wersję. Korzystać z niego mogą osoby, które kupiły kurs, na zasadach z pliku [LICENCJA.md](../../LICENCJA.md).
