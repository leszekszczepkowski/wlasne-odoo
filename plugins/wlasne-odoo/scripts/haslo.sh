#!/usr/bin/env bash
# Hasła z serwera do Notatnika kursanta i z powrotem, bez pokazywania ich Claude'owi.
# Skrypt nigdy nie wypisuje hasła. Plik roboczy leży w bieżącym folderze kursu, strażnik nie pozwala go czytać.
#   haslo.sh pokaz admin    hasło administratora Odoo  -> Notatnik
#   haslo.sh pokaz kopia    hasło do kopii (restic)    -> Notatnik
#   haslo.sh przygotuj      pusty plik w Notatniku, kursant wkleja hasło do kopii i zapisuje (odtworzenie na nowym serwerze)
#   haslo.sh wyslij         wysyła wklejone hasło do /root/.restic-haslo na serwerze (chmod 600) i kasuje plik
#   haslo.sh usun           kasuje plik roboczy
set -u
PLIK="HASLO-przepisz-i-usun.txt"

otworz() {
  case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*) notepad.exe "$PLIK" >/dev/null 2>&1 & ;;
    Darwin) open -e "$PLIK" ;;
    *) (xdg-open "$PLIK" >/dev/null 2>&1 &) ;;
  esac
}

case "${1:-}" in
  pokaz)
    case "${2:-}" in
      admin) zrodlo=/root/odoo-admin.txt ;;
      kopia) zrodlo=/root/.restic-haslo ;;
      *) echo "użycie: haslo.sh pokaz admin|kopia"; exit 2 ;;
    esac
    umask 077
    if ssh -o BatchMode=yes odoo "cat $zrodlo" > "$PLIK" 2>/dev/null && [ -s "$PLIK" ]; then
      otworz
      echo "Hasło jest w pliku $PLIK w folderze kursu i otwiera się w Notatniku. Przepisz je do menedżera haseł, zamknij Notatnik i napisz „gotowe”."
    else
      rm -f "$PLIK"
      echo "Nie udało się odczytać hasła z serwera (połączenie ssh odoo albo brak pliku na serwerze)."
      exit 1
    fi ;;
  przygotuj)
    umask 077
    : > "$PLIK"
    otworz
    echo "Otworzył się pusty plik $PLIK. Wklej do niego hasło do kopii z menedżera haseł, zapisz (Ctrl+S), zamknij i napisz „gotowe”." ;;
  wyslij)
    if [ ! -s "$PLIK" ]; then echo "Plik $PLIK jest pusty albo go nie ma."; exit 1; fi
    tr -d '\r\n' < "$PLIK" | ssh -o BatchMode=yes odoo 'umask 077; cat > /root/.restic-haslo; chmod 600 /root/.restic-haslo; test -s /root/.restic-haslo' \
      && { rm -f "$PLIK"; echo "Hasło do kopii zapisane na serwerze (chmod 600). Plik z komputera skasowany."; } \
      || { echo "Nie udało się zapisać hasła na serwerze. Plik został na komputerze."; exit 1; } ;;
  usun)
    rm -f "$PLIK"; echo "Plik $PLIK skasowany." ;;
  *) echo "użycie: haslo.sh pokaz admin|kopia | przygotuj | wyslij | usun"; exit 2 ;;
esac
