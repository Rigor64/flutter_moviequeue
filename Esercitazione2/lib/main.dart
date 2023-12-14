import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Building MyApp');

    // Il Widget che si passa a runApp può essere qualsiasi cosa, anche un
    // semplice widget Text
    /*final r = Random().nextDouble();
    return Text(
      "La mia random: $r!",
      textDirection: TextDirection.ltr,
    );*/

    // Se si crea un'app conforme alle linee guida del Material Design, la radice
    // della nostra app sarà un'istanza di MaterialApp, che include una serie
    // di informazioni di base e del tema, tra cui il colore primarySwatch (usato
    // poi da vari altri widget)
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      // Qui costruiamo la homepage della nostra app, un altro widget
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// MyHomePage è un widget stateful che contiene due informazioni: 1) il titolo dell'app,
// che viene "passato" in maniera statica al costruttore e rimane memorizzato nell'istanza
// del widget e quindi non può essere modificato; 2) un contatore intero, che viene
// inizializzato a 0, ma deve poter essere modificato (incrementato) al clic di un
// pulsante e quindi viene memorizzato nella classe State (vedi sotto), in modo che la UI
// di MyHomePage possa dipendere da questa variabile in fase di costruzione
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // Questa variabile viene valorizzata dal costruttore e non può essere modificata
  // in alcun modo a runtime, una volta che MyHomePage è stata costruita
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Questa variabile invece "vive" dentro una classe State e quindi può essere modificata
  // all'interno del metodo setState, che scatena anche la ricostruzione dell'interfaccia
  int _counter = 0;

  // Metdodo ausiliare che incrementa il contatore dentro setState, scatenando la
  // ricostruzione del widget
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $runtimeType");

    // Questa build viene invocata ogni volta che viene richiamata setState
    // e può far riferimento alla variabile _counter per rappresentare lo stato
    // attuale della nostra app

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
