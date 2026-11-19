---
name: ksef
description: Lekcja 6 kursu „Własne Odoo Community” — przełączenie Odoo kursanta na prawdziwy (produkcyjny) KSeF po powrocie do czystej kopii.
disable-model-invocation: true
---

Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

1. Potwierdź, że baza wróciła do kopii „czysta-przed-testami” (krok 4 w `/wlasne-odoo:ksef-test`): w bazie nie ma żadnej faktury, a na firmie puste są pola `l10n_pl_edi_certificate`, `l10n_pl_edi_access_token`, `l10n_pl_edi_refresh_token`, `l10n_pl_edi_session_id`. Jeśli coś się nie zgadza, przerwij.
2. Pokaż obecną wartość `l10n_pl_edi_ksef.mode` i czekaj na „tak”.
3. Ustaw `prod`, odczytaj ponownie i porównaj dokładnie z `prod`. Każda inna wartość oznacza test.
4. Prowadź kursanta przez wgranie certyfikatu KSeF albo podpisu kwalifikowanego w Odoo; wgrywa sam. Certyfikat KSeF kursant wnioskuje w Aplikacji Podatnika KSeF (Certyfikaty → Wnioskuj o certyfikat), logując się profilem zaufanym albo podpisem kwalifikowanym.
Sprawdzenie: parametr dokładnie `prod`, certyfikat wgrany. Pierwszą prawdziwą fakturę wystaw z `/wlasne-odoo:faktura`.
