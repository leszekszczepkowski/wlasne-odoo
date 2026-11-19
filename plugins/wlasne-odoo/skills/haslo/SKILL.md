---
name: haslo
description: Hasło administratora Odoo albo hasło do kopii (restic) z serwera kursanta otwarte w Notatniku na jego komputerze, bez pokazywania go Claude'owi i bez terminala; także wgranie hasła do kopii na nowy serwer. Używaj, gdy kursant mówi „pokaż hasło administratora”, „hasło do kopii”, „gdzie jest hasło do Odoo”, w lekcji 3 i 4 oraz przy odtworzeniu na nowym serwerze.
---

Odpowiadaj po polsku od pierwszej wiadomości, także gdy wynik narzędzia jest po angielsku. Trzymaj się zasad kursu (wczytanych na starcie sesji; jeśli ich nie widzisz, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`).

Kursant pracuje tylko w aplikacji Claude. Nie każ mu otwierać PowerShella ani Terminala. Hasło idzie z serwera prosto do pliku `HASLO-przepisz-i-usun.txt` w folderze kursu i otwiera się w Notatniku (na Macu w TextEdit). Ty go nie widzisz: skrypt nic nie wypisuje, a strażnik nie pozwala otworzyć tego pliku.

## Pokaż hasło
1. Ustal które: administratora Odoo (`admin`) czy do kopii (`kopia`).
2. Uruchom `bash "${CLAUDE_PLUGIN_ROOT}/scripts/haslo.sh" pokaz admin` (albo `kopia`) w folderze kursu.
3. Powiedz kursantowi: przepisz hasło do menedżera haseł (lekcja 0), hasło do kopii także na kartkę, zamknij Notatnik bez zapisywania zmian i napisz „gotowe”.
4. Po „gotowe”: `bash "${CLAUDE_PLUGIN_ROOT}/scripts/haslo.sh" usun`.
Gdy skrypt zgłosi błąd połączenia, sprawdź `ssh odoo hostname` i wróć do `/wlasne-odoo:serwer`.

## Wgraj hasło do kopii na nowy serwer (odtworzenie)
1. `bash "${CLAUDE_PLUGIN_ROOT}/scripts/haslo.sh" przygotuj`: otwiera się pusty plik.
2. Kursant wkleja hasło do kopii z menedżera haseł, zapisuje (Ctrl+S, na Macu Cmd+S), zamyka i pisze „gotowe”.
3. `bash "${CLAUDE_PLUGIN_ROOT}/scripts/haslo.sh" wyslij`: hasło trafia do `/root/.restic-haslo` (chmod 600), plik na komputerze znika.
4. Sprawdź, że hasło pasuje: `restic snapshots` na serwerze (z ustawieniami z `hosting/hosting.env`) pokazuje listę kopii.
