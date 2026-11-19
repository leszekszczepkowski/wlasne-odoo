#!/usr/bin/env bash
# Strażnik wtyczki „wlasne-odoo” (hook PreToolUse).
# Blokuje odczyt plików z hasłami i klucza prywatnego, a przy krokach nieodwracalnych
# wymusza pytanie o zgodę. Działa na samym grep/sed (macOS, Linux, Git Bash na Windows).
wejscie=$(cat)

odpowiedz() { # $1 = deny|ask, $2 = powód
  powod=$(printf '%s' "$2" | sed 's/\\/\\\\/g; s/"/\\"/g')
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"%s","permissionDecisionReason":"%s"}}\n' "$1" "$powod"
  exit 0
}

narzedzie=$(printf '%s' "$wejscie" | sed -n 's/.*"tool_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)

# 1. Pliki z hasłami: nigdy, w żadnym narzędziu.
if printf '%s' "$wejscie" | grep -Eq 'HASLO-przepisz|odoo-admin\.txt|\.restic-haslo|odoo\.conf|odoo-pakiet[/\\]+\.env|\.env\.przed|(^|[[:space:]/\\"'"'"'])\.env([^A-Za-z0-9_.]|$)'; then
  odpowiedz deny "Strażnik kursu: to plik z hasłami (.env, odoo.conf, odoo-admin.txt, .restic-haslo, HASLO-przepisz-i-usun.txt). Claude go nie otwiera. Hasło do Notatnika kursanta: skrypt wtyczki haslo.sh (polecenie /wlasne-odoo:haslo)."
fi

# 1a. Gwiazdka zamiast pełnej nazwy (np. grep . /root/odoo-*.txt): też nie.
if printf '%s' "$wejscie" | grep -Eq 'HASLO[^[:space:]]*[*?]|[*?][^[:space:]]*HASLO|/root/[^[:space:]"'"'"']*[*?]|odoo-[A-Za-z]*[*?]|\.env[*?]|\.restic[A-Za-z-]*[*?]|restic-[*?]|\.ssh[/\\]+[^[:space:]"'"'"']*[*?]'; then
  odpowiedz deny "Strażnik kursu: gwiazdka w ścieżce do /root, .env, plików odoo-*, restic albo .ssh może trafić w plik z hasłem albo klucz. Podaj pełną nazwę pliku, który nie jest plikiem z hasłem."
fi

# 2. Klucz prywatny SSH (plik bez .pub).
klucz='\.ssh[/\\]+(odoo_hetzner|kopia_poza)([^.A-Za-z0-9_]|$)'
case "$narzedzie" in
  Read|Edit|Write|MultiEdit|Grep|Glob|NotebookEdit)
    if printf '%s' "$wejscie" | grep -Eq "$klucz"; then
      odpowiedz deny "Strażnik kursu: to klucz prywatny SSH. Nie wolno go czytać ani zmieniać. Pokazujesz tylko plik .pub."
    fi ;;
  Bash|PowerShell)
    if printf '%s' "$wejscie" | grep -Eq "(cat|type|more|less|head|tail|base64|xxd|od|cp|copy|scp|rsync|curl|Get-Content|gc|clip|Set-Clipboard)[[:space:]]+[^|;&<>]*$klucz"; then
      odpowiedz deny "Strażnik kursu: ta komenda czyta albo kopiuje klucz prywatny SSH. Kursant kopiuje go sam do menedżera haseł."
    fi ;;
esac

# 2a. Klucz aplikacji Enable Banking i inne pliki .pem: nie czytamy.
pem='[A-Za-z0-9_-]\.pem([^A-Za-z0-9_.]|$)'
case "$narzedzie" in
  Read|Edit|Write|MultiEdit|Grep|NotebookEdit)
    if printf '%s' "$wejscie" | grep -Eq "$pem"; then
      odpowiedz deny "Strażnik kursu: plik .pem to klucz prywatny (np. aplikacji Enable Banking). Kursant wgrywa go sam w Odoo, Claude go nie otwiera."
    fi ;;
  Bash|PowerShell)
    if printf '%s' "$wejscie" | grep -Eq "(cat|type|more|less|head|tail|base64|xxd|od|cp|copy|scp|rsync|curl|Get-Content|gc|clip|Set-Clipboard|openssl)[[:space:]]+[^|;&<>]*$pem"; then
      odpowiedz deny "Strażnik kursu: ta komenda czyta albo kopiuje plik .pem z kluczem prywatnym. Kursant wgrywa go sam w Odoo."
    fi ;;
esac

# 3. Kroki nieodwracalne: zawsze pytanie o zgodę.
if [ "$narzedzie" = "Bash" ] || [ "$narzedzie" = "PowerShell" ]; then
  if printf '%s' "$wejscie" | grep -Eq 'przywroc\.sh|dropdb|DROP[[:space:]]+DATABASE|docker[[:space:]]+compose[[:space:]]+down[[:space:]]+-v|docker[[:space:]]+volume[[:space:]]+rm|restic[[:space:]]+(forget|prune)|rm[[:space:]]+-[a-zA-Z]*r[a-zA-Z]*f|rm[[:space:]]+-[a-zA-Z]*f[a-zA-Z]*r|git[[:space:]]+reset[[:space:]]+--hard|git[[:space:]]+clean[[:space:]]+-[a-z]*f|mkfs|wipefs|Remove-Item.*-Recurse'; then
    odpowiedz ask "Strażnik kursu: to krok, którego nie da się cofnąć (przywrócenie bazy, kasowanie, nadpisanie). Upewnij się, że wiesz, co się stanie, zanim zatwierdzisz."
  fi
fi
exit 0
