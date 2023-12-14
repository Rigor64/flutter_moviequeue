import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liste/providers.dart';

class GreetingViewer extends ConsumerWidget {
  const GreetingViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");

    return Text(ref.watch(greetingProvider));
  }
}
