# Workflow

### Założenia 
- /v/ wszystkie definicje typów danych (ContentTypeDefinition) będą "definiowane" w headles CMSie. Znane definicje typow danych takich jak pages, templates, sections templates, media, menus(**???**) będą utworzone przez zespół developerski i nie będą edytowalne przez użytkowników systemu CMS (status read-only ??) 
- /v/ każda definicja typu danych będzie trwale powiązana z definicją workflow. Nie będzie możliwe utworzenie definicji typu danych bez połączenia go z definicją workflow. 
- użytkownik będzie mógł zmienić przypisanie definicji workflow do definicji typu danych co będzie skutkowało następującym zachowaniem systemu:
    - wszystkie instancje worfklow utworzone na podstawie pierwotnie przypisanej definicji workflow nie ulegną zmianie czyli ich przepływ będzie działał według pierwotnej definicji
    - wszystkie instancje workflow utworzone po zmianie przypisania definicji workflow zostaną utworzone w oparciu o nową definicję
- /v/ nie będzie możliwości edycji definicji workflow w przypadku kiedy dla tej definicji będzie istniała chociaż jedna instancja. 
- /v/ nie będzie możliwości usunięcia definicji workflow jeśli definicja będzie związana choćby z jedną definicją typu danych lub będzie istniała chociaż jedna instancja workflow dla usuwanej definicji
- definicje workflow nie będą wersjonowane (w pierwszej wersji)
- będzie możliwość utworzenia definicji workflow na podstawie innej definicji (kopia)
- /v/ nie będzie funkcjonalności aktywowania wersji workflow od danej daty godziny (w pierwszej wersji)
- /v/ w pierwszej wersji workflow definiowany będzie za pomocą pliku yaml. Nie będzie wizualnego edytora (na razie).
- definicja typu danych nie będzie przechowywała informacji na temat definicji workflow. Definicje workflow będą przypinane do obiektów, dzięki temu dowolną definicję obiektu będzie można przypiąć do dowolnej definicji workflowu. 
- obiekty workflow dla każdego obiektu będą działały całkowicie osobno i bez wpływu na statusy workflow z zagnieżdżonych obiektów.  Przykład: użytkownik zbuduje stronę na której dodany zostanie obiekt kurs. Strona będzie w statusie opublikowana podczas gdy dodany do strony obiekt kurs będzie w statusie draft. Taki stan nie zablokuje publikacji strony. System pozwoli na pokazanie strony natomiast nie opublikowany kurs nie będzie widoczny.
- workflow będzie mógł przebiegać jedynie liniowo. Nie zakładamy równoległych ścieżek (maszyna stanów)
- w pierwszej wersji funkcjonalność workflow nie będzie obsługiwała sprawdzania możliwości dostępu do obiektu (odczyt, zapis, usunięcie). System będzie sprawdzał jedynie czy użytkownik posiada uprawnienie do przejścia do kolejnego stanu. 
- opublikowany obiekt pozostaje w stanie opublikowanym do momentu ustawienia w status "unpublish". Przejście obiektu w każdy inny stan powoduje stworzenie jego kopii która będzie podlegała edycji. Natomiast wersja opublikowana zostanie w stanie jakim była. Przykłady:
    - obiekt jest w statusie początkowym "draft" nigdy nie znajdował się w statusie published - żadna wersja obiektu nie będzie widoczna.
    - obiekt jest w statusie draft ale wcześniej znajdował się w statusie "published" - system wyświetli ostatnią opublikowaną wersję obiektu. 
    - obiekt znajdował się w statusie "published" ale został przestawiony na "unpublished" - żadna wersja obiektu nie będzie widoczna. 
- cofnięcie się do wcześniejszej wersji obiektu nie dotyczy stanu workflow. Przykład: obiekt znajdował się w statusie "published" stan obiektu został zmieniony na "draft" (opublikowana wersja dalej jest publiczna). Użytkownik zmienia wartość jednego parametru zapisuje, a następnie cofa do poprzedniego stanu. Cofnięcie powoduje przywrócenie pierwotnej wartości ale nie zmienia stanu workflow obiektu. 

### Funkcjonalności
**1. Ekran workflows**
Na tym ekranie użytkownik będzie mógł zobaczyć listę wszytkich definicji workflow. Edycja workflow będzie odbywała się poprzez wklejenie Yamla w input typu text area. Ekran workflows będzie dostępny tylko i wyłącznie dla super adminów (czyli w domyśle dla nas). Nie powinien być widoczny dla użytkowników ze strony klienta. 

**2. Zmiana przypisania do definicji obiektów**
Użytkownik będzie mógł zobaczyć listę definicji obiektów do których przypisany jest system workflow. 

**3. Dodanie nowej definicji obiektu**
Po zakończeniu definiowania obiektu w headless cms użytkownikowi pokazany zostanie ekran na którym będzie mógł wybrać workflow do którego obiekt ma być przypisany. Na liście będzie również pozycja "utwórz nowy"

**4. Filtrowanie obiektów w określonym stanie**
Do ekranów umożliwiających edycję obiektów
- pages
- layouts
- section templates
- menus
- headles CMS objects
Dodana zostanie kolumna z wartością stanu w jakim dany obiekt się znajduje. Na stronach tych dodana zostanie również funkcjonalność filtrowania obiektów po statusie.

**5. Edycja strony**
Do ekranu edycji strony dodana zostanie funkcjonalność umożliwiająca przejście do kolejnego stanu workflow. System powinien wyświetlić stany możliwe do przejścia dla zalogowanego użytkownika lub zablokować przycisk jeśli użytkownik nie posiada uprawnienia do przejścia na żaden stan. Przejście do kolejnego stanu będzie możliwe również z ekranu listy stron. 

**6. Edycja/tworzenie obiektów w headless CMS**
j.w

**7. Edycja/tworzenie obiektów layouts**
j.w

**8. Edycja/tworzenie obiektów section templates**
j.w

**9. Edycja/tworzenie obiektów menu**
j.w

**10. Edycja/tworzenie obiektów media**
j.w

**11. Notyfikacje**
[TODO]



**11. Wyświetlenie mapy Workflow**
Ekran wyświetlający... poniżej przykład z Jiry. 
![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_6f9b0bc480255cba8428c652d88382d4.png)


 

### 1. Objects
A workflow can be attached to any Content Type defined in the platform, e.g.:
- Pages
- Layouts
- Section templates
- Menus
- Content (Objects from headless CMS)
- Media

- Personalisation segments
- Users
- Context (role,localisation, ip address etc) - this object data will be taken into account during object validation (worfklow).

Workflows are described in the system by defining the set of states and transitions that are allowed within a particular workflow, furthermore the roles allowed to make a specific transition can be defined.

![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_2d1393486ab1d1c2b993c4f912b23f1e.png)

Each instance (object) of a particular Content Type can have an instance of a workflow attached. The workflow is transparent to the particular data object, i.e. the object itself doesn't carry any workflow-related data. That information is stored completely in the workflow instance.


!!! note "Sposób definicji workflow:"
    ```
    # @todo move to workflow bundle
    framework:
        workflows:
          default:
            type: 'state_machine'
            marking_store:
              service: >App\HeadlessCMSWorkflowBundle\MarkingStore\ContentObjectMarkingStore
              # Serwis mówiący w jaki sposób (w jakim polu) zapisywać informację >o stanie
            supports:
              - App\HeadlessCMSBundle\Entity\ContentObject
            initial_marking: draft
            places:
              - draft
              - review
              - published
            transitions:
              to_review:
                from: draft
                to: review
                to_published:
                # Guard na podstawie informacji z wykorzystaniem >ExpressionLanguage pozwala na 
                # ograniczanie przejść ze względu na rolę, lub jakiekolwiek >wyrażenie 
                # zob. https://symfony.com/doc/current/workflow.html#blocking->transitions
                # guard: "is_granted('ROLE_REVIEWER')"
                # guard: "is_authenticated()"
                from: review
                to: published
              to_draft:
                from: [review, published]
                to: draft
    ```


### 2. Use cases

1. Create new page
2. Edit/update existing page
3. Publish page
4. Review (accept) created layout
5. Edit/update existing layout
6. Review (accept) section tempates
7. Edit/update section templates
8. Review (accept) menu
9. Edit/update menu
10. Review (accept) personalisation segment
11. Edit/update personalisation segment
12. Review (accept) media
13. Edit/update media
14. Review (accept) content
15. Edit/update content
16. Update existing content
17. Automated tasks (spelling check, plagiarism checks, seo checks, wcag checks,  etc)
18. Workflow steps definition
19. Workflow roles and responsibilities mapping 
20. Notifications configuration
21. Visual presentation of the workflow

### 3. Functionalities 

- System Notifications 
- Email notifications
- Translations
- Comments
- Statuses
- Approval actions
- List pages by status
- User rights and mapping
- Workflow configuration:
    - "applicable to" option (which objects should be included)
    - activation date-time
    - roles involved
    - visual presentation

### 4. Related features
- personalisation
- data sources/sets
- versioning 
 

### 5. Questions
- how to handle data loaded automatically from external sources ?
- how to implement parallel work by two different roles ?
- Can authors create new pages or just edit existing ones?
- Who is authorized to create subfolders (subdirectories)?
- Can authors delete pages? What about other digital assets?
- Can editors approve content across the entire site or just the sections they’re responsible for? What about content they own that spreads across multiple sections of the site?
- How do we manage multiple approvers (editors)? Are requests for approval delegated to other approvers if an assigned editor is out of the office?
- How do we manage workflow when multiple authors are working on the same page?
- Are content managers involved in the workflow process? 
- Are they informed about publishing updates? Are they responsible for documenting changes?
