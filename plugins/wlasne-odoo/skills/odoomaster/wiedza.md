# Wiedza odoomastera: Odoo 19 Community z pakietu kursu

Stan: 15.11.2026. Sprawdzone w kodzie Odoo 19.0 i na serwerach testowych szczepkowski.ai. Gdy coś tu przeczy temu, co widzisz w Odoo kursanta, wierz Odoo i powiedz to kursantowi.

## 1. Co jest w pakiecie kursu

Instalacja zakłada bazę z modułami: polska lokalizacja i KSeF (`l10n_pl`, `l10n_pl_edi`), Faktury i księgowość (`account`), Sprzedaż (`sale_management`), Zakupy (`purchase`), Projekty i czas pracy (`project`, `hr_timesheet`), Kontakty. Z OCA: wygląd na telefonie (`web_responsive`), raporty księgowe (`account_financial_report`), uzgadnianie banku (`account_reconcile_oca`), import wyciągów z pliku (`account_statement_import_sheet_file`), środki trwałe (`account_asset_management`), raporty zarządcze (`mis_builder`), kursy NBP (`currency_rate_update_nbp`), dokumenty (`dms`), podpis dokumentów (`sign_oca`), kokpity (`spreadsheet_dashboard_oca`), zgłoszenia (`helpdesk_mgmt`), umowy cykliczne (`contract`), harmonogram projektów (`project_timeline`). Do tego moduły szczepkowski.ai: konektor dla Claude'a (`sz_mcp`), dodatki hostingu (`sz_hosting`), kodowanie polskich wyciągów (`sz_statement_import_encoding`), koszty z KSeF z rejestrem i rozbieżnościami (`sz_ksef` z `sz_core` i `sz_zatwierdzenia_ce`), bank przez Enable Banking (`l10n_pl_account_statement_import_online_enablebanking` z OCA `account_statement_import_online`, polecenie `/wlasne-odoo:bank`) i moduły z ZIP-a „Dodatki”. Zawsze sprawdź listę zainstalowanych modułów w bazie kursanta, zanim powiesz, że czegoś nie ma.

## 2. Community a Enterprise — mapa zamienników

| Kursant pyta o… | W Enterprise | U niego (Community) |
|---|---|---|
| uzgadnianie banku | Księgowość (accountant) | `account_reconcile_oca` |
| raporty: bilans, RZiS, księga główna | account_reports | `account_financial_report`, `mis_builder` |
| podpis elektroniczny dokumentów | Sign | `sign_oca` |
| automatyczne pobieranie wyciągów z banku | synchronizacja banku | import pliku CSV/MT940; połączenie z bankiem online to płatny dodatek szczepkowski.ai |
| Dokumenty | Documents | `dms` |
| Studio (własne pola klikane) | Studio | pola przez tryb deweloperski albo moduł; ostrożnie |
| aktualizacja do nowej wersji Odoo | usługa migracji Odoo | OpenUpgrade (OCA); to praca na dzień wdrożeniowy, nie na wieczór |
| marketing automation, social, umawianie spotkań | są | brak; mass mailing, ankiety, wydarzenia, CRM, strona, sklep i e-learning są w Community |

Czego nie ma w żadnej edycji: ewidencji przychodów ryczałtu z JPK. Ryczałtowiec prowadzi ją u księgowej albo osobnym narzędziem.

Gmail w Community: połączenie skrzynki Google przez przycisk działa bez konfiguracji tylko w Enterprise. W Community najprościej SMTP z hasłem aplikacji Google; logowanie przez Google wymaga własnej aplikacji w Google Cloud (ok. 15 minut).

## 3. KSeF w Odoo 19 (`l10n_pl_edi`)

- Tryb: parametr systemowy `l10n_pl_edi_ksef.mode`. **Brak parametru = produkcja.** Każda wartość inna niż `prod` = test.
- Na firmie: certyfikat i tokeny (`l10n_pl_edi_certificate`, `l10n_pl_edi_access_token`, `l10n_pl_edi_refresh_token`, `l10n_pl_edi_session_id`).
- Na fakturze: stan (`l10n_pl_edi_status`: wysłana, przyjęta, odrzucona…), numer KSeF (`l10n_pl_edi_number`), plik XML FA(3) i UPO. UPO pobiera się osobną akcją po odświeżeniu stanu.
- Rodzaj faktury liczy się z pozycji: zaliczkowa (pozycje zaliczkowe), rozliczeniowa, korekta (korekta z powiązaniem do faktury pierwotnej), zwykła.
- **Faktury wysłanej albo przyjętej nie da się cofnąć do szkicu.** Błąd poprawia się korektą.
- Zakupy: Odoo co kilka godzin pobiera faktury kosztowe z KSeF jako szkice do sprawdzenia. Własnej sprzedaży wystawionej poza Odoo KSeF nie pobierze.
- Numerację i wysyłkę do KSeF robi tylko jeden program. Jeśli faktury wystawia Odoo, księgowa ich nie wystawia drugi raz; jej program pobierze je z KSeF sam.
- Certyfikat do produkcji: Aplikacja Podatnika KSeF → Certyfikaty → Wnioskuj o certyfikat (logowanie profilem zaufanym albo podpisem kwalifikowanym).

## 4. Bank

- Wyciąg wczytuje się z pliku (CSV według mapowania ustawionego w lekcji 6). Pliki banków spółdzielczych bywają w kodowaniu windows-1250 — od tego jest `sz_statement_import_encoding`.
- Wpłatę z fakturą łączy uzgadnianie (`account_reconcile_oca`). Odoo samo proponuje fakturę, gdy tytuł przelewu to numer faktury, a kwota się zgadza.
- Reguły uzgadniania automatycznego: zawsze z ograniczeniem kwoty i tekstu. Reguła bez limitu potrafi rozliczyć coś zupełnie innego.
- Dopasowanie wpłaty do faktury: właściwy kierunek (wpływ do sprzedaży, wydatek do kosztu), data przelewu nie wcześniejsza niż data faktury (wyjątek: udokumentowana zaliczka), przy równych kwotach rozstrzyga tytuł przelewu. Przeksięgowania wewnętrzne (np. na rachunek VAT przy podzielonej płatności) to nie zapłaty klientów.

## 5. Zasada masowych zmian (gdy zmieniasz więcej niż kilka rekordów)

1. Policz przed: ile rekordów wejdzie do zmiany.
2. Próba na jednym i sprawdzenie wyniku odczytem, nie brakiem błędu.
3. Zapisz listę identyfikatorów, żeby dało się cofnąć.
4. Zapytanie kontrolne po zmianie, sprawdzające to, czego dopasowanie nie sprawdzało (np. daty i tytuły przelewów).
5. Pokaż kursantowi wynik: ile weszło, ile zmienionych, ile odrzuconych.
Operacja bez kroku 4 jest niedokończona, nawet jeśli nie było błędu.

## 6. Odoo i księgowa (najczęstszy układ)

- Odoo: faktury, KSeF, bank, projekty, magazyn, czas pracy. Księgi, deklaracje i JPK: księgowa w swoim programie.
- Faktury sprzedaży i kosztowe z KSeF księgowa pobiera sama. Z Odoo wysyłasz jej co miesiąc: dokumenty spoza KSeF (zagraniczne, paragony), wyciągi, zestawienie miesiąca (`/wlasne-odoo:miesiac`).
- Księgowa może mieć dostęp do Odoo przez portal albo jako zwykły użytkownik z prawami tylko do odczytu księgowości — w Community bez opłat za konto.
- Stany na start (salda, nierozliczone faktury) wprowadza się na dzień rozpoczęcia pracy w Odoo, w uzgodnieniu z księgową. Wstecz się nie księguje.

## 7. Uprawnienia i konektor Claude'a

- Konektor `sz_mcp` działa na prawach zalogowanego użytkownika: Claude widzi i robi to, co to konto. Pracownik używający Claude'a potrzebuje grupy „Konektor MCP”.
- Dziennik wywołań i odebranie dostępu: Ustawienia → Techniczne → Konektor MCP (menu Techniczne po włączeniu trybu deweloperskiego).
- Widok, który „wywraca się” jednemu użytkownikowi, zwykle odwołuje się do pola, do którego ten użytkownik nie ma praw. To sprawa dla dnia wdrożeniowego, nie do łatania w bazie produkcyjnej.

## 8. Kiedy odesłać do szczepkowski.ai

Własny moduł, przeniesienie danych z innego programu, migracja na nową wersję Odoo, połączenie z bankiem online, nietypowe rozliczenia (deweloperka, MPP przy robotach budowlanych, zaliczki z wieloma etapami). Powiedz kursantowi wprost, że to praca na konsultację albo dzień wdrożeniowy, i nie próbuj tego robić na jego bazie w rozmowie.
