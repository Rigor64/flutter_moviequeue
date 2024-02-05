<a name="readme-top"></a>

## Matteo Leopizzi 326110

<!-- LOGO DEL PROGETTO -->
<br />
<div align="center">
    <img src="https://github.com/Rigor64/flutter_moviequeue/blob/0e28451d4e5b83bded45a211276d6877fe4e65dc/moviequeue/images/appIcon.png" alt="Logo" width="80" height="80">

  <h1 align="center">Moviequeue</h1>
</div>

<!-- TABELLA DEI CONTENUTI -->
<details>
  <summary>Tabella dei contenuti</summary>
  <ol>
    <li>
      <a href="#descrizione-del-progetto">Descrizione del progetto</a>
    </li>
    <li>
      <a href="#use-cases">Use cases</a>
    </li>
    <li>
      <a href="#user-experience">User experience</a>
    </li>
    <li>
      <a href="#tecnologia">Tecnologia</a>
      <ul>
        <li><a href="#dependances">Dependances</a></li>
        <li><a href="#scelte-implementative">Scelte implementative</a></li>
      </ul>
    </li>
  </ol>
</details>

<!-- DESCRIZIONE DEL PROGETTO -->
## Descrizione del progetto

Quest'applicazione offre all'utente la possibilità di visualizzare un catalogo degli ultimi film e serie tv usciti nelle sale. I dati relativi ai media vengono prelevati tramite una comunicazione remota via HTTP, tramite il servizio gratuito di TMDB, un database contenente le informazioni utili alla realizzazione di questo applicativo. Permette di aggiungere i vari media ad una lista preferiti, oltre ad avere una vista in dettaglio per ogni media, di cui ne riporta le caratteristiche principali.

<p align="right">(<a href="#readme-top">Torna su</a>)</p>

<!-- USE CASES -->
## Use cases

L'utente avrà a disposizione la possibilità di creare un nuovo account al primo avvio dell'applicazione, con il quale potrà accedere ad ogni avvio dell'applicazione.
Una volta eseguito l'accesso, all'utente vengono proposti diversi tv e serie tv del momento, con la possibilità di visualizzare i dettagli di ogni elemento e ricercare qualsiasi film, tramite l'apposita schermata. 
Gli elementi aggiunti ai preferiti hanno una pagina assestante, consultabile, con la quale è possibile tenere traccia ad esempio dei film che l'utente non ha ancora visto.

<p align="right">(<a href="#readme-top">Torna su</a>)</p>

<!-- USER EXPERIENCE -->
## User Experience

L'utente accederà all'applicativo tramite l'inserimento di username e password. Nel caso in cui si volesse creare un nuovo account, i dati relativi al precedente account verranno rimossi, ma non gli elementi aggiunti ai preferiti.

<br />
<div align="center">
    <img src="https://github.com/Rigor64/flutter_moviequeue/blob/faf48250509a00ae7a89845d4b1cf0c6bf43838d/moviequeue/images/Screenshot%202024-01-29%20112951.png" alt="Screen1" width="900" height="500">
</div>
<br />

La prima pagina che viene visualizzata sarà l'Homepage che riporta tre Carousel contenenti varie categorie di media. Ogni elemento può essere visionato tramite la selezione dei media specifico che aprirà una pagina Dettagli relativa.

<br />
<div align="center">
    <img src="https://github.com/Rigor64/flutter_moviequeue/blob/faf48250509a00ae7a89845d4b1cf0c6bf43838d/moviequeue/images/Screenshot%202024-02-05%20175942.png" alt="Screen1" width="900" height="500">
</div>
<br />

Le pagine successive hanno lo scopo di far scoprire nuovi film o serie tv tramite una serie di card che è possibile spostare per aggiungere ai preferiti. Vi è la possibilità di ricercare qualsiasi film disponibile nel catalogo e l'ultima pagina è riservata agli elementi aggiunti ai preferiti.

<br />
<div align="center">
    <img src="https://github.com/Rigor64/flutter_moviequeue/blob/faf48250509a00ae7a89845d4b1cf0c6bf43838d/moviequeue/images/Screenshot%202024-01-29%20113131.png" alt="Screen1" width="900" height="500">
</div>
<br />

In altro a destra nella Homepage ci sarà anche la possibilità di accedere alla pagina contenente le informazioni relative all'account dell'utente.

<p align="right">(<a href="#readme-top">Torna su</a>)</p>

<!-- TECNOLOGIA -->
## Tecnologia
<!-- DEPENDANCES -->
### Dependances

Per questo progetto sono stati utilizzati i seguenti pacchetti aggiuntivi:

* [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar) - Per la creazione del widget che legge la percentuale di gradimento di ogni media
* [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) - Un framework reattivo per la cache e il data-binding
* [uuid](https://pub.dev/packages/uuid) - Gestione di identifier unici
* [http](https://pub.dev/packages/http) - Crea richieste HTTP
* [path_provider](https://pub.dev/packages/path_provider) - Usato per gestire la posizione dei file di sistema
* [hive_flutter](https://pub.dev/packages/hive_flutter) - Un semplice database chiave-valore
* [curved_navigation_bar](https://pub.dev/packages/curved_navigation_bar) - Una barra di navigazione animata 
* [google_fonts](https://pub.dev/packages/google_fonts) - Per la gestione di font google che non sono stati inseriti nel pacchetto di default di flutter
* [flutter_font_icons](https://pub.dev/packages/flutter_font_icons) - Icone personalizzabili per flutter
* [carousel_slider](https://pub.dev/packages/carousel_slider) - Usato per la creazione di carousel per la visualizzazione dei media
* [appinio_swiper](https://pub.dev/packages/appinio_swiper) - Usato per la creazione delle card trascinabili
* [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) - Per la gestione dell'icona dell'applicazione sui diversi dispositivi

Inoltre per poter prelevare i dati relativi ai media da server è necessario procurarsi un API dal sito uufficiale di TMDB e inserirla in `Vars.dart`, sostituendo 'ENTER YOUR API':

```dart
static const apiKey = 'ENTER YOUR API';
var headers = {'accept': 'application/json' , 'Authorization': 'Bearer ENTER YOUR API' };
```

<p align="right">(<a href="#readme-top">Torna su</a>)</p>

<!-- SCELTE IMPLEMENTATIVE -->
### Scelte implementative

* L'applicativo è stato sviluppato per essere responsive sia per dispositivi mobili (con viusualizzazione orizzontale e verticale), sia per ambienti desktop.
* Dal database utilizzato vengono estrapolate informazioni riguardo a film e serie tv tramite query specifiche, che successivamente vengono convertite in una lista dinamica personalizzata, tramite traduzione da linguaggio json.
* La ricerca e la visualizzazione hanno dei limiti e dei dati mancanti dovuti a come il servizio TMDB gestisce i dati, ma nella maggior parte dei casi tutte le funzionalità operano in modo adeguato.
* Viene gestito lo stato di ogni elemento attraverso l'uso di pagine StateFull e CustumerStateFull, che hanno l'obiettivo di tenere sotto controllo quale elemento stiamo visualizzando e in che posizione si trova la card di riferimento di ogni elemento.
* L'account prevede una registrazione iniziale e un successivo login ogni qualvolta l'utente accederà all'applicazione. I dati dell'account non sono direttamente collegati alla lista preferiti.
* Nel file Vars.dart sono inseriti tutti i colori relativi al tema utilizzato e l'API utilizzata per la realizzazione dell'applicativo.

<p align="right">(<a href="#readme-top">Torna su</a>)</p>
