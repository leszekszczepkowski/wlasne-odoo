---
name: alarm
description: Przyszedł alarm z serwera Odoo kursanta — diagnoza bez żadnych zmian, prosta odpowiedź, co się stało i co dalej.
disable-model-invocation: true
argument-hint: "[tytuł alarmu]"
---

Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

Tytuł alarmu: $ARGUMENTS (jeśli pusty, zapytaj o niego).

Sprawdź serwer (`ssh odoo`), niczego nie zmieniając: stan kontenerów, `/var/backups/odoo/zdrowie.txt`, ostatnie wpisy w `/var/log/odoo-hosting.log`, miejsce na dysku, czy system czeka na restart, ostatnie 50 linii logu Odoo (`docker compose logs --tail 50 odoo`).
Powiedz prosto: co się stało, czy dane są bezpieczne i co proponujesz. Zmiany dopiero po „tak”.
