---
name: faktura
description: Wystawienie faktury sprzedaży w Odoo kursanta i wysłanie jej do KSeF, z podglądem przed zatwierdzeniem i pobraniem UPO. Używaj, gdy kursant prosi „wystaw fakturę”, „zafakturuj”, „faktura dla …”.
---

Odpowiadaj po polsku od pierwszej wiadomości, także gdy wynik narzędzia jest po angielsku. Trzymaj się zasad kursu (wczytanych na starcie sesji; jeśli ich nie widzisz, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Działasz przez konektor do Odoo kursanta („Odoo moja firma”).

1. Ustal nabywcę: szukaj kontaktu po NIP, potem po nazwie. Gdy go nie ma, zaproponuj nowy kontakt (nazwa, NIP, adres) i załóż po „tak”.
2. Ustal pozycje: produkt lub opis, ilość, cena netto, stawka VAT, termin płatności (domyślny z kontaktu albo 14 dni). Gdy kursant nie podał stawki VAT, zapytaj; nie zakładaj 23%.
3. Utwórz szkic faktury i pokaż go w tabeli: nabywca, NIP, pozycje, netto, VAT, brutto, termin, rachunek do wpłaty. Nie zatwierdzaj.
4. Po „tak”: zatwierdź. Wysyłka do KSeF to osobne pytanie: sprawdź, czy `l10n_pl_edi_ksef.mode` ma wartość `prod` (prawdziwy KSeF) czy `test`, powiedz to kursantowi i czekaj na „tak”.
5. Po wysyłce poczekaj kilkanaście sekund, odśwież status i pobierz UPO (osobna akcja). Pokaż numer faktury, numer KSeF i stan.
6. Zapytaj, czy wysłać fakturę mailem do klienta. Wysyłasz tylko po „tak”.
