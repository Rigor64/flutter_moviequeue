//flutter permette la creazione di applicazioni NATIVE per le principali piattaforme
//l'applicazione gira direttamente sul processore dell'elaboratore

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  //fa partire l'applicazione
  //runApp(const MyApp());
  runApp(MaterialApp(
      //parte principale in cui inserire tutti i widget
      title: "My first app",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Material(
          child: Column(children: [
        Text("Ciao Mondo"), //primo testo
        RigacolorataCasuale(),
        RigaColorata(Colors.green), RigaColorata(Colors.red),
        RigacolorataCasuale(),
        Row(children: [
          Text("testo due"),
          SizedBox(height: 20),
          Text("testo2")
        ]) // secondo testo indentato in una riga
      ]))));
}

class RigaColorata extends StatelessWidget {
  //classe di widget custom
  final Color _color;

  //const RigaColorata({required this.color, super.key});
  const RigaColorata(this._color, {super.key});
  @override
  Widget build(BuildContext context) {
    debugPrint('Building $this');

    return Row(
      children: [
        const Text("testo due"),
        Container(width: 50, height: 20, color: _color),
        const Text("testo2"),
      ],
    );
  }
}

class RigacolorataCasuale extends StatelessWidget {
  //seconda classe custom

  final Color _color;

  RigacolorataCasuale({super.key})
      : _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  @override
  Widget build(BuildContext context) {
    debugPrint('Building $this');
    return Container(height: 50, color: _color);
  }
}
