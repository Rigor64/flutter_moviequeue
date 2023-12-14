import 'package:flutter/material.dart';
import 'package:hello1/counter_display.dart';

class CounterTogglerDirect extends StatelessWidget {
  final int _counter;
  final void Function(int) _modifier;

  const CounterTogglerDirect(this._counter, this._modifier, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CounterDisplay(_counter),
        Row(
          children: [
            ElevatedButton(
                onPressed: () => _modifier(_counter - 1),
                child: const Text("Decrement")),
            ElevatedButton(
                onPressed: () {
                  // altre cose prima
                  _modifier(_counter + 1);
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
