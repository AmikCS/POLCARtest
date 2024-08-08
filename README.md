# POLCARtest
### Struktura Bazy Danych 
![datamodel](https://github.com/user-attachments/assets/04951b2c-d884-43a5-9fd3-77282f58f732)
### Tabele
![obraz](https://github.com/user-attachments/assets/1af6e0b4-8792-4eb1-97b2-4d34a74a1c7f)

Tabela Tenants - Przechowywanie informacji o różnym podmiocie (tenanty), które korzystaja z systemu 
Każy podmiot w tabeli posiada unikalny Tenant, który jest kluczem głównym, umożliwi przypisanie do odpowiedniego podmiotu. 
To pozowli systemowi na dalsza rozbudowe i dzięki temu może obsługiwać wiele podmiotów zgodnie z architekturą "multi-tenancy"

![obraz](https://github.com/user-attachments/assets/30a5f868-3111-4f5f-9673-2f442d940d10)

Tabela Users - Przechowywanie informacji o użytkownikach, przypisanie do podmiotów 
Klucz obcy przypisuje użytkowników do podmiotów. Rola użytkownika jest ustalona na podstawie wartości "Manager", uprości to zarządzanie i rozróżnienie użytkowników, którzy pełnią różne role - u nas tylko Pracownik i Manager. 
Zastosowanie domyślnej wartości "Pracownik" dla roli, ułtawi dodawanie użytkowników bez konieczności określania kto kim jest

![obraz](https://github.com/user-attachments/assets/4def1dd3-4f65-4734-9524-5e5534911b24)

Tabela Tasks - Przechowuje zadania, które moga być przypisane do użytkownika
Zadania są powiązane stricte z użytkownikami oraz podmiotami za pomocą kluczy obcych (TenantID oraz CreatedByUserID). Struktura pozwoli na zarządzanie zadaniami, dzięki wykorzystaniu priorytetu, statusu czy utworzenia
Dzięki temu uzyskamy minimalizacje powielania danych z dobrze zdefinowaną relacja. Dzięki temu łatwo możemy rozbudować system

![obraz](https://github.com/user-attachments/assets/2330f7ac-5189-45b3-bfa5-2a3cb9c3c083)

Tabela TaskHistory - Przechowuje historię zmian dla każdego zadania.
Kluczowy czynnik do śledzenia zmian zadań w czasie. Dzięki temu będzie możliwe odtworzenie stanu zadania w dowolnym momencie. TaskID ma powiązanie z oryginalnym zadaniem, a ChangedByUserID wskaże użytkownika 
Zastosowanie domyślnej wartości ChangeDate pozwoli na automatycznie zapisanie czasu zmiany.

![obraz](https://github.com/user-attachments/assets/23f54f1e-7128-4c3f-993d-24aae5bbf13b)

Tabela TaskStats - Przechowuje statystyki zadań dla każdego użytkownika.
Statystyki są kluczowe do monitorowania postępu prac, struktura umożliwi szybki dostęp do liczb zadań ukończonych, w toku czy nierozpoczętych. Ułatwi zarządzanie zespołem
Domyślne statystyki mają wartość "0" co zapobiegnie błędom w inicjacji danych 

![obraz](https://github.com/user-attachments/assets/54cd6fa7-b827-47ed-abfd-12e4bbcdedbf)

Tabela Notifications - Przechowuje powiadomienia dla użytkowników
Struktura umożliwia przechowywanie oraz zarządzanie powiadomieniami, które mogą być generowane automatycznie.

![obraz](https://github.com/user-attachments/assets/4c66a0f4-897d-468c-8dda-415e1563187b)

Tabela ArchivedTasks - Przechowuje zadania, które zostały zakończone i zarchiwizowane 
Tabela stworzona w celu przenoszenia starszych zadań (6 miesięcy) co poprawi wydajność bazy danych, poprzez zmniejszenie glównej tabeli z zadaniami.

### Procedury 

### Indeksy 

### Widoki

### Pomysły na przyszłość 

