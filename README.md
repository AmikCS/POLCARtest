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
Procedura AddTask - dodaje nowe zadanie do systemu, w celu uproszczenia procesu tworzenia zadań, zapewni spójność danych i minimalizacje błędu

Procedura ArchiveOldTasks - Przenosi ukończone zadania starsze niż 6 miesięcy do tabeli ArchivedTasks, automatyzacja procesu archiwizacji zadań, poprawi wydajność bazy danych

Procedura DeleteTask - Zapewni spójne usunięcie wszystkich danych związanych z zadaniem

Procedura UpdateTask - Aktualizuje szczegóły zadania oraz opisze historie zmian

Procedura GetStats - Generuje statystki dotyczące zadań dla użytkowników, powstała dla wygodne uzyskania ifnormacji o liczbie zadań przypisanych. 

Procedura GenerateTaskNotifications - Generuje powiadomienia dla użytkowników o zadanich, które mają blisko termin zakończenia 

### Indeksy 
Indeks IDX_Tenants_TenantID - Poprawia wydajność zapytań, które filtrują dane na podstawie TenantID
Indeks IDX_Users_UserID_TenantID - Indeks na kolumnie UserID oraz TenantID w Users, przyspiesza zapytania, które łącza użytkowników z zadaniami
Indeks IDX_Tasks_TaskID_TenantID - Indeks na kolumnie TaskID i TenantID w Task, szybki dostęp do zadań dla konkrentego podmiotu
Indeks IDX_Tasks_CreatedByUserID - Indeks na kolumnie CreatedByUserI w Tasks - przyspiesza zapytania, które filtruja zadania na podstawie użytkownika
Indeks IDX_TaskHistory_TaskID - Indeks na kolumnie TaskID w tabeli TaskHistory - szybki dostęp do zmian dla konkretnych zadań 
### Widoki
Widok UserTaskCounts - Przechowuje informacje o liczbie zadań przypisanych do każdego użytkownika - uproszczenie w raportowaniu i szybki dostep do statystyk 
Widok ArchivedTasks - Przechowuje informacje o zadaniach, które są zarchiwizowane, oddzielenie zakończonych zadań od bieżących, łatwiejsze raportowanie i przegląd danych archiwalnych
Widok UserTaskStats - 

### Pomysły na przyszłość 
### Pomysły zabezpieczeń:
Dodanie zabezpieczenia w postaci osobnych uprawnień dla użytkowników - roli. Wdrozenie systemu RBAC
Wszystkie zmiany w kluczowych tabelach zarejestrowane w systemie (CRUD)

### Pomysły rozwojowe:
Utworzenie więcej widoków agregujących
Stworzenie etykiet do zadań i przez to stworzenie kategorii - Łatwiejsze grupowanie zadania według tematyki, projektów itp
Dodanie komentarzy przy zadanich - zwiększy współprace zespołową, bieżące aktualizowanie informacji
Załączniki do zadań - możliwość dodania załącnzików do zadań. Lepsze zarządzanie dokumentacją
Przypomnienia wysyłane na maila - wykorzystanie notifications, gdzie będzie powiadomienie przychodzić na maila z terminem. 
Integracja z kalendarzem - automatycznie pozowli dodać termin zadania do kalendarza użytkownika 
Dashboard - interaktywny dashboard, który wyświetli najważniejsze statystyki


