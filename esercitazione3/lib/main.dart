import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    //costrutto centrale, generalmente è sempre utile averlo
    return Scaffold(
      //ha una barra in alto con APP BAR e degli action button, può anche non esserci
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //testo da visualizzare
        //title: Text(widget.title),
        title: const Text("Primo progetto"),
        leading: const Icon(Icons.access_alarms_outlined),
        actions: [
          //ActionChip(label: Text("Pulsante")),

          //creo un bottone che sarà identificato da un icona e che svolge la stessa funzione del conatatore
          IconButton(
              onPressed: () {
                debugPrint("Action clicked");
                _incrementCounter();
              },
              icon: const Icon(Icons.ac_unit))
        ],
      ),
      //è la home della nostra finestra
      body: Center(
        child: Container(
          color: Color.fromARGB(255, 89, 176, 247),
          //child: Stack(
          //  fit: StackFit.loose, //comprime tutti gli elementi insieme
          //)

          child: Padding(
            // spazio rispetto a tutti gli angoli o solo alcuni
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex:
                      1, //metodo per separare in base alla divisione di frazioni della finestra
                  //questo oggetto prenderà tutto lo spazio a disposizione
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.green,
                              offset: Offset.fromDirection(120, 4))
                        ]),
                    child: Text(
                      "Ciao Mondo",
                      textAlign: TextAlign.right,
                    ),
                    //color: Colors.green, //se usiamo boxdecoratio9n non poissiamo usare color
                  ),
                ),

                Align(
                  //ha effetto solo in uno stack o se ho molto spazio
                  alignment: Alignment.bottomLeft,
                  child: Text("Pippo"),
                ),

                //se il testo è troppo lungo rispetto ad una riga, il text lo allineerà a sinistra, ma possiamo forzarlo ad allinearsi diversamente
                Text(
                  "Questo è uin testo lunghiiiiiiiiisssiiiiimoooooo ma proprio lunghissiiimissimissimo",
                  textAlign: TextAlign.justify,
                ),

                Container(
                  color: Color.fromARGB(255, 74, 222, 255),
                  child: const Text(
                    'Bottone cliccato n volte:',
                    textAlign: TextAlign.center,
                  ),
                ),

                Expanded(
                  flex: 4,
                  child: Container(
                    color: Color.fromARGB(255, 74, 198, 255),
                    child: Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //un bottone che può sportarci e si trova al di sopra degli elementi, se sono allineati sotto al bottone
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        //child: const Text("Pulsante"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//elementi disponibili per l'allineamento:
//start   end   center    spaceAround   spaceBetween    spaceEvenly
//
//flutter premisura il testo da inserire e adatta la finestra o il container in cui è stato inserito il testo
//la colonna o la riga si espande grazie a mainAxisSize
//
//allineamneto rispetto all'asse centrale, quindi al centro della riga o della colonna:
//start   end   center    stretch
//
//Lo stack è un modo per avere elementi sovrapposti
//sizedbox è un conteniner a cui possiamo passare delle dimensioni specifiche , usato per elementi che cambiano dimensione dinamicamente
//
