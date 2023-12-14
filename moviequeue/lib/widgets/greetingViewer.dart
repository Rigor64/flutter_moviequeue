import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class GreetingViewer extends ConsumerWidget {
  const GreetingViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");

    return Text(ref.watch(greetingProvider));
  }
}
