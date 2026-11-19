---
name: nieoplacone
description: Lista nieopłaconych faktur sprzedaży w Odoo kursanta z dniami po terminie i szkicem przypomnienia dla klienta. Używaj, gdy kursant pyta „kto mi nie zapłacił”, „zaległości”, „przypomnij klientom”.
---

Trzymaj się zasad kursu (wczytanych na starcie sesji; jeśli ich nie widzisz, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Działasz przez konektor do Odoo kursanta („Odoo moja firma”). Niczego nie zmieniasz i nic nie wysyłasz bez „tak”.

1. Pobierz zatwierdzone faktury sprzedaży nieopłacone lub częściowo opłacone. Tabela: klient, numer, data, termin, dni po terminie, do zapłaty. Na końcu suma i suma po terminie.
2. Zaproponuj kolejność: najpierw najdłużej po terminie i największe kwoty.
3. Na prośbę kursanta napisz krótki, uprzejmy szkic przypomnienia po polsku (numer faktury, kwota, termin, rachunek), bez gróźb. Wysyłasz z Odoo tylko po „tak” dla konkretnego klienta.
