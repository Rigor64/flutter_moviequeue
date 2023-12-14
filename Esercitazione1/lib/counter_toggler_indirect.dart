import 'package:flutter/material.dart';
import 'package:hello1/counter_display.dart';
import 'package:hello1/main.dart';

class CounterTogglerIndirect extends StatelessWidget {
  // int counter;

  CounterTogglerIndirect({super.key});

  @override
  Widget build(BuildContext context) {
    // final hp = context.findAncestorWidgetOfExactType<HomePage>();
    final hpState = context.findAncestorStateOfType<HomePageState>();
    final counter = hpState!.counter;

    debugPrint("Building $this (counter of HomePage: $counter)");

    return Column(
      children: [
        CounterDisplay(counter),
        Row(
          children: [
            ElevatedButton(
                onPressed: () => hpState.updateCounter(counter - 1),
                child: const Text("Decrement")),
            ElevatedButton(
                onPressed: () {
                  // altre cose prima
                  hpState.updateCounter(counter + 1);
                  // altre cose dopo
                  // return;
                },
                child: const Text("Increment"))
          ],
        )
      ],
    );
  }
}
