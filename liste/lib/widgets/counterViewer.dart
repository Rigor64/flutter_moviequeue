import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liste/providers.dart';

class CounterViewer extends ConsumerWidget {
  const CounterViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");

    return Text(ref.watch(counterProvider).toString());
  }
}
