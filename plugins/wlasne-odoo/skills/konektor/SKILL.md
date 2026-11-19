---
name: konektor
description: Lekcja 5 kursu „Własne Odoo Community” — podłącza Odoo kursanta jako konektor w aplikacji Claude, żeby Claude mógł czytać i zapisywać w Odoo (w zakładce Code, w czacie i na telefonie).
disable-model-invocation: true
---

Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

Kursant pracuje w aplikacji Claude na pulpicie. Nie każ mu otwierać terminala ani wpisywać `claude mcp add` czy `/mcp`.

1. Sprawdź, czy adres Odoo odpowiada: `https://ADRES/mcp` (sama odpowiedź serwera, bez logowania).
2. Powiedz kursantowi, co kliknąć w aplikacji Claude, po kolei: Ustawienia → Konektory → Dodaj niestandardowy konektor. Nazwa: `Odoo moja firma`. Adres: `https://ADRES/mcp`. Potem Połącz. Otworzy się logowanie do Odoo: loguje się sam (login i hasło admina, które odczytał w lekcji 3) i zatwierdza dostęp. Hasła nie wpisujesz ani nie oglądasz.
3. Gdy kursant napisze, że konektor jest połączony: w nowej rozmowie w tym samym folderze (konektor dochodzi do rozmów zaczętych po połączeniu) odczytaj przez konektor nazwę i walutę firmy (`res.company`).
Sprawdzenie: widać nazwę firmy i PLN. Zapisz w `moje-odoo.md`, że konektor działa. Następny krok: `/wlasne-odoo:firma`.

Ten sam konektor działa w czacie i w aplikacji na telefonie, bez dodatkowego ustawiania (na telefonie to wersja próbna).

Dla osób, które pracują w Claude Code w terminalu: `claude mcp add --scope user --transport http odoo-moja-firma https://ADRES/mcp`, potem w nowej rozmowie `/mcp` → `odoo-moja-firma` → Authenticate. Tej drogi nie proponuj sam.
