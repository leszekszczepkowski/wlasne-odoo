---
name: serwer
description: Lekcja 1 kursu „Własne Odoo Community” — klucz SSH do serwera w Hetznerze i pierwsze połączenie ze skrótem „ssh odoo”.
disable-model-invocation: true
---

Odpowiadaj po polsku od pierwszej wiadomości, także gdy wynik narzędzia jest po angielsku. Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

## Krok 1. Klucz do serwera
1. Sprawdź, czy istnieje `~/.ssh/odoo_hetzner`. Jeśli tak, nie nadpisuj go, tylko użyj.
2. Jeśli nie, utwórz klucz: `ssh-keygen -t ed25519 -C "odoo-hetzner" -f ~/.ssh/odoo_hetzner -N ""` (bez hasła do klucza, chyba że kursant powie inaczej). Na Windows w PowerShellu `-N '""'`.
3. Pokaż wyłącznie zawartość `~/.ssh/odoo_hetzner.pub`, w jednej linii, do skopiowania do Hetznera (Security → SSH Keys przy tworzeniu serwera).
4. Podaj pełną ścieżkę do klucza prywatnego, żeby kursant sam skopiował go do menedżera haseł. Pliku bez `.pub` nigdy nie pokazuj ani nie kopiuj.
Sprawdzenie: jedna linia zaczynająca się od `ssh-ed25519`.

Potem poczekaj, aż kursant utworzy serwer według lekcji 1 i poda adres IP (zapisz go w `moje-odoo.md`).

## Krok 2. Pierwsze połączenie
1. Połącz się: `ssh -i ~/.ssh/odoo_hetzner -o StrictHostKeyChecking=accept-new root@ADRES_IP hostname`.
2. Wykonaj na serwerze: `hostname`, `lsb_release -d`, `free -h`, `df -h /`.
3. Dopisz do `~/.ssh/config` wpis `Host odoo` (HostName ADRES_IP, User root, IdentityFile ~/.ssh/odoo_hetzner). Nie kasuj innych wpisów. Sprawdź, że `ssh odoo hostname` działa.
4. Pokaż tabelę: nazwa serwera, system, pamięć, wolne miejsce.
Sprawdzenie: `ssh odoo hostname` zwraca nazwę, a system to Ubuntu 24.04. Następny krok: `/wlasne-odoo:instalacja`.
