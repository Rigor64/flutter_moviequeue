import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class CounterViewer extends ConsumerWidget {
  const CounterViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");

    return Text(
      "Contatore ${ref.watch(counterProvider)}",
    );
  }
}
