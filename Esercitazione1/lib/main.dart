import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hello1/counter_toggler_direct.dart';
import 'package:hello1/counter_toggler_indirect.dart';
import 'package:hello1/counter_toggler_inherited.dart';

void main() {
  runApp(const ColorizedApp());
}

class ColorizedApp extends StatefulWidget {
  const ColorizedApp({super.key});

  @override
  State<ColorizedApp> createState() => _ColorizedAppState();
}

class _ColorizedAppState extends State<ColorizedApp> {
  Color _themeColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    //tutta l'app vive qua dentro
    //dispone un tema, quando viene creata, lanciamo un Theme Data
    return MaterialApp(
      title: 'My first Flutter app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _themeColor),
        //versione del material design
        useMaterial3: true,
      ),
      home: HomePage("Ciao mondo!", () {
        setState(() {
          _themeColor =
              Colors.primaries[Random().nextInt(Colors.primaries.length)];
        });

        debugPrint("Hai notificato il metodo main()");
      }),
    );
  }
}

//stato dell'applicazione
class HomePage extends StatefulWidget {
  final String saluto;
  final void Function() chiamami;

  const HomePage(this.saluto, this.chiamami, {super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

//diversi stati che assume la homepage
class HomePageState extends State<HomePage> {
  int _counter = 0;
  Color _color = Colors.blue;

  int get counter => _counter;

  //ogni volta questo elemento verrà ricostruito
  void updateCounter(int newCounter) {
    if (newCounter < 0) {
      newCounter = 0;
    }

    // if (newCounter == _counter) return;

    //modifichiamo lo stato
    setState(() {
      _counter = newCounter;
    });
  }

  void randomizeColor() {
    setState(() {
      _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");

    return InheritedCounter(
      _counter,
      child: Material(
          child: Column(
        children: [
          Text(widget.saluto, style: Theme.of(context).textTheme.headlineLarge),
          Text("Contatore doppio ${_counter * 2}"),
          const SizedBox(height: 20),

          //questo container verrà visualizzato solo se il counter è pari
          //in genereale meglio non mettere questi tipi di costrutti qui, per evitare errori
          if (_counter % 2 == 0)
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1)),

                //le varuiabili e gli elementi const non vengono ricostruiti ad ogni invocazione di un cambiamento di stato
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                child: const Column(
                  children: [
                    Text("Colore fisso:"),
                    RigaColorata(Colors.green),
                  ],
                )),

          //
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1)),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Text("Colore del tema:"),
                  //la chiamata Theme.of è funzionante solo se solo collegati in modo adeguato i vari rami della gerarchia fino al material app
                  RigaColorata(Theme.of(context).primaryColor),
                ],
              )),

          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                const Text("Colore legato allo stato dell'app:"),
                GestureDetector(
                    onTap: () {
                      randomizeColor();
                    },
                    child: RigaColorata(_color, expanded: true)),
              ],
            ),
          ),
          const ColorSwitcher(),
          RigaColoreCasuale(),
          // CounterTogglerDirect(_counter, updateCounter),
          // CounterTogglerIndirect(),
          const CounterTogglerInherited(),
          ElevatedButton(
            onPressed: widget.chiamami,
            child: const Text("Cambia colore tema"),
          )
        ],
      )),
    );
  }
}

class InheritedCounter extends InheritedWidget {
  final int counter;

  const InheritedCounter(this.counter, {super.key, required super.child});

  static InheritedCounter of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedCounter>()!;
  }

  static void update(BuildContext context, int newCounter) {
    context.findAncestorStateOfType<HomePageState>()!.updateCounter(newCounter);
  }

  @override
  bool updateShouldNotify(covariant InheritedCounter oldWidget) {
    debugPrint("InheritedCounter $counter != ${oldWidget.counter}");
    return (counter != oldWidget.counter);
  }
}

class ColorSwitcher extends StatefulWidget {
  const ColorSwitcher({super.key});

  @override
  State<ColorSwitcher> createState() => _ColorSwitcherState();
}

class _ColorSwitcherState extends State<ColorSwitcher> {
  Color _color = Colors.orange;

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this (color: $_color)");

    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Text("Colore legato a stato interno:"),
          GestureDetector(
              onTap: () {
                setState(() {
                  _color = Colors
                      .primaries[Random().nextInt(Colors.primaries.length)];
                });
              },
              child: RigaColorata(_color)),
        ],
      ),
    );
  }
}

class RigaColorata extends StatelessWidget {
  final bool _expanded;
  final Color _color;

  const RigaColorata(this._color, {bool expanded = false, super.key})
      : _expanded = expanded;

  @override
  Widget build(BuildContext context) {
    debugPrint('Building $this');

    return Row(
      children: [
        const Text("Sinistra"),
        Container(width: 100, height: (_expanded) ? 60 : 20, color: _color),
        const Text("Destra"),
      ],
    );
  }
}

class RigaColoreCasuale extends StatelessWidget {
  final Color _color;

  RigaColoreCasuale({super.key})
      : _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Widget build(BuildContext context) {
    debugPrint('Building $this');

    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: Column(children: [
        const Text("Colore determinato casualmente in build()"),
        Container(height: 50, color: _color)
      ]),
    );
  }
}
