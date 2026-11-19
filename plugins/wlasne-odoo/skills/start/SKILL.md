---
name: start
description: Początek kursu „Własne Odoo Community” albo powrót po przerwie. Sprawdza, co już zrobione, i mówi, jaki krok następny.
disable-model-invocation: true
---

Odpowiadaj po polsku od pierwszej wiadomości, także gdy wynik narzędzia jest po angielsku. Trzymaj się zasad kursu „Własne Odoo Community” (wtyczka wczytuje je na starcie sesji; jeśli nie widzisz ich w rozmowie, przeczytaj `${CLAUDE_PLUGIN_ROOT}/ZASADY.md`). Przeczytaj `moje-odoo.md` w bieżącym folderze, jeśli istnieje; pytaj tylko o dane, których tam brakuje.

1. Jeśli `moje-odoo.md` nie istnieje, utwórz go z pustymi polami (Serwer IP, Adres Odoo, Baza, Firma, Storage Box użytkownik, Storage Box adres) i sekcją „Postęp”. Przywitaj kursanta jednym zdaniem i zapytaj, czy ma już konto w Hetznerze (lekcja 1 w kursie).
2. Jeśli istnieje, pokaż krótko, co już zrobione (sekcja „Postęp”), i podaj następny krok według tej kolejności:
   | Lekcja | Polecenie | Co robi |
   |---|---|---|
   | 1 | `/wlasne-odoo:serwer` | klucz SSH i pierwsze połączenie |
   | 2 | `/wlasne-odoo:instalacja` | sprawdzenie adresu, instalacja, kontrola |
   | 2 | `/wlasne-odoo:adres` | tylko gdy trzeba zmienić adres Odoo |
   | 3 | (bez polecenia) | logowanie, zmiana hasła i drugi zamek robisz sam według lekcji 3 |
   | 4 | `/wlasne-odoo:kopie` | alarm na telefon, kopia poza serwerem, próba odtworzenia |
   | 5 | `/wlasne-odoo:konektor` | Claude w twoim Odoo |
   | 6 | `/wlasne-odoo:firma` | dane firmy, pracownik, poczta, bank |
   | 6 | `/wlasne-odoo:ksef-test` | czysta kopia, testowy KSeF, pierwsza faktura, powrót do kopii |
   | 6 | `/wlasne-odoo:ksef` | prawdziwy KSeF |
3. Przypomnij jednym zdaniem: raz w miesiącu `/wlasne-odoo:przeglad`, raz na kwartał `/wlasne-odoo:aktualizacja`, a gdy coś się stanie `/wlasne-odoo:alarm` albo `/wlasne-odoo:awaria`.
