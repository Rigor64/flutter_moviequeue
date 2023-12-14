import 'package:flutter/widgets.dart';

class CounterDisplay extends StatelessWidget {
  final int counter;

  const CounterDisplay(this.counter, {super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this (counter: $counter)");

    return Text("Hai cliccato $counter volte!");
  }
}
