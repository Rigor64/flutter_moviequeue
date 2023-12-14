import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class TodoItemsCounterViewer extends ConsumerWidget {
  const TodoItemsCounterViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");

    return Text("Ho ${ref.watch(todoItemsCounterProvider)} cose da fare.");
  }
}
