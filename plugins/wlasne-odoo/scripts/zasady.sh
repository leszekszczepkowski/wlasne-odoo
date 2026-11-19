#!/usr/bin/env bash
# Wtyczka „wlasne-odoo”: na starcie sesji podaje Claude'owi zasady kursu (hook SessionStart).
# Tekst ze standardowego wyjścia trafia do rozmowy, więc Claude nie musi czytać pliku spoza folderu kursanta.
katalog=$(cd "$(dirname "$0")/.." && pwd)
printf 'Odpowiadaj kursantowi zawsze po polsku, od pierwszej wiadomości.\n\nZasady kursu „Własne Odoo Community” (wtyczka wlasne-odoo). Obowiązują przy każdym poleceniu /wlasne-odoo:… i przy pomocnikach.\n\n'
cat "$katalog/ZASADY.md"
