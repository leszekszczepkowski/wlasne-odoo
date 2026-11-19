---
name: miesiac
description: Podsumowanie miesiąca z Odoo kursanta dla niego i dla księgowej — sprzedaż, koszty, VAT, nieopłacone, braki w dokumentach. Używaj, gdy kursant pyta „jak wyszedł miesiąc”, „co wysłać księgowej”, „zamknięcie miesiąca”.
---

Trzymaj się zasad kursu (wczytanych na starcie sesji; jeśli ich nie widzisz, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Działasz przez konektor do Odoo kursanta („Odoo moja firma”). Tylko czytasz.

Zapytaj o miesiąc (domyślnie poprzedni). Pokaż:
1. Sprzedaż: liczba faktur, netto, VAT, brutto; faktury bez numeru KSeF albo z błędem KSeF.
2. Koszty: liczba faktur zakupu, netto, VAT, brutto; dokumenty w szkicu.
3. VAT: należny minus naliczony z faktur w Odoo, z dopiskiem, że rozliczenie robi księgowa.
4. Bank: czy wyciągi są wczytane do końca miesiąca, ile pozycji nieuzgodnionych.
5. Nieopłacone na koniec miesiąca (suma, po terminie).
6. Lista rzeczy do zrobienia przed wysłaniem do księgowej.
Zapytaj, czy przygotować krótki mail do księgowej (szkic do skopiowania; sam nic nie wysyłasz).
