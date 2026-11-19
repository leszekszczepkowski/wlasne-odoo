---
name: aktualizacja
description: Bezpieczna aktualizacja Odoo kursanta do najnowszej wersji pakietu z kursu (raz na kwartał), z kopią i automatycznym powrotem przy błędzie.
disable-model-invocation: true
---

Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

1. Najpierw powiedz, co się zmieni: `git fetch` w `/opt/odoo-pakiet` i lista zmian (`git log --oneline HEAD..origin`).
2. Po „tak” w tmux: `cd /opt/odoo-pakiet && ./hosting/aktualizuj.sh 2>&1 | tee aktualizacja.log`.
3. Mów krótko, który krok trwa. Skrypt robi kopię, próbuje aktualizacji na kopii bazy i dopiero potem aktualizuje Odoo kursanta; przy błędzie sam wraca.
4. Na końcu pokaż wynik z `wdrozenia.log` (katalog ze zmiennej STAN w `hosting/wspolne.sh`, zwykle `/var/lib/odoo-hosting`) i zrób kontrolę jak w kroku 3 `/wlasne-odoo:instalacja`.
5. Przypomnij, żeby zaktualizować też wtyczkę: w Claude Code `/plugin`, zakładka Installed, `wlasne-odoo`, Update now.
Sprawdzenie: Odoo działa na nowej wersji, kontrole „dobrze”.
