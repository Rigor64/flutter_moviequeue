import 'package:flutter/material.dart';
import 'package:hello1/counter_display.dart';
import 'package:hello1/main.dart';

class CounterTogglerInherited extends StatelessWidget {
  const CounterTogglerInherited({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = InheritedCounter.of(context).counter;

    debugPrint("Building $this (counter of HomePage: $counter)");

    return Column(
      children: [
        CounterDisplay(counter),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  InheritedCounter.update(context, counter - 1);
                },
                child: const Text("Decrement")),
            ElevatedButton(
                onPressed: () {
                  InheritedCounter.update(context, counter + 1);
                },
                child: const Text("Increment"))
          ],
        )
      ],
    );
  }
}
