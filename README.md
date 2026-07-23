# Zadanie 2 - Automatyzacja Azure przez PowerShell

## Opis:
Niniejsze repozytorium zawiera rozwiązanie zadania rekrutacyjnego polegającego na automatyzacji procesu wdrażania infrastruktury chmurowej w Microsoft Azure. Głównym celem skryptu jest utworzenie zasobu Azure Storage Account w sposób całkowicie bezobsługowy, wykorzystując do uwierzytelnienia mechanizm Service Principal

---

## Wykonanie:
Skrypt wykorzystuje programistyczny model uwierzytelniania typu Non-interactive login, co oznacza, że proces nie wymaga otwierania przeglądarki ani ingerencji człowieka

### Proces:
1. App Registration - W usłudze Microsoft Entra ID zarejestrowałem aplikację Service Principal, która reprezentuje nasz skrypt.
2. Client Credentials - Do uwierzytelnienia skrypt używa trzech utworzonych wartości:
   - Tenant ID: identyfikator katalogu w Azure, który wskazuje, gdzie znajduje się nasze konto.
   - Client ID: Unikalny identyfikator naszej aplikacji (Service Principal).
   - Client Secret: Hasło do naszej aplikacji.
3. Autoryzacja (RBAC - Role-Based Access Control): Sam Service Principal nie ma domyślnie żadnych uprawnień. Przypisałem mu rolę Współautor/Contributor na poziomie określonej Grupy Zasobów (tj. rg-rekrutacja-c3), co pozwala mu na tworzenie w niej nowych elementów.
4. API Call: Polecenie **Connect-AzAccount** zawarte w moim skrypcie odpytuje token endpoint Azure AD, przedstawiając powyższe parametry. W zamian otrzymuje Access Token, którym automatycznie podpisuje kolejne zapytania REST API (realizowane pod spodem przez cmdlet New-AzStorageAccount).

---

## Wymagania wstępne:
Do poprawnego uruchomienia skryptu wymagany jest zainstalowany moduł Az.

Instalacja modułu: `Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force`

---

## Parametry skryptu: 
Skrypt został zaprojektowany tak, żeby przyjmował wszystkie poufane informacje jako parametry wejściowe z poziomu konsoli.

### Opis parametrów: 
| Parametr | Typ | Opis |
| :--- | :--- | :--- |
| `TenantId` | `String` | Identyfikator dzierżawy. |
| `ClientId` | `String` | Identyfikator aplikacji (Service Principal). |
| `ClientSecret` | `SecureString` / `String` | Hasło. |
| `ResourceGroupName` | `String` | Nazwa docelowej grupy zasobów (domyślnie: `rg-rekrutacja-c3`). |
| `StorageAccountName` | `String` | Unikalna globalnie nazwa konta magazynu (domyślnie: `stsharpai25`). |
| `Location` | `String` | Region wdrożenia zasobu (domyślnie: `westeurope`). |

---

## Instrukcja uruchomienia:
Skrypt należy wywołać z poziomu terminala PowerShell, przekazując wymagane parametry uwierzytelniające.

`.\AzureStorageAccount.ps1 -TenantId "TWÓJ_TENANT_ID" -ClientId "TWÓJ_CLIENT_ID" -ClientSecret "TWÓJ_CLIENT_SECRET"`
