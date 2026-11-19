---
name: wyciag
description: Wczytanie wyciągu bankowego CSV do Odoo kursanta i uzgodnienie wpłat z fakturami. Używaj, gdy kursant mówi „wczytaj wyciąg”, „rozlicz bank”, „kto zapłacił”.
---

Trzymaj się zasad kursu (wczytanych na starcie sesji; jeśli ich nie widzisz, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Działasz przez konektor do Odoo kursanta („Odoo moja firma”).

1. Zapytaj o plik CSV z banku. Mapowanie dla banku kursanta powinno już być (lekcja 6, `/wlasne-odoo:firma`, krok 4). Gdy go nie ma, zrób najpierw ten krok.
2. Powiedz kursantowi, gdzie w Odoo wczytać plik (dziennik banku → Importuj), albo wczytaj go przez konektor, jeśli moduł importu na to pozwala. Treść wierszy z nazwiskami i numerami kont czytasz tylko w Odoo, nie wypisujesz jej w całości.
3. Sprawdź saldo końcowe z bankiem.
4. Pokaż tabelę wpłat bez dopasowania: data, kwota, tytuł (skrócony), proponowana faktura i dlaczego. Uzgadniasz dopiero po „tak”, pozycja po pozycji albo całą listą, jak kursant wybierze.
5. Na końcu: ile pozycji uzgodnionych, ile zostało i co z nimi zrobić.
