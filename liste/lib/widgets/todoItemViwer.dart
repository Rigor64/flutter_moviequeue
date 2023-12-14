import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liste/models/todoitem.dart';
import 'package:liste/providers.dart';

class TodoItemViewer extends ConsumerWidget {
  final TodoItem item;

  const TodoItemViewer(this.item, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");

    final item = ref.watch(currentTodoItemProvider);

    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(50),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).shadowColor.withAlpha(10),
                  blurRadius: 10,
                  offset: Offset.fromDirection(120, 8))
            ]),
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(value: item.done, onChanged: (c) {}),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                    style: Theme.of(context).textTheme.headlineSmall),
                if (item.description != null)
                  Text(item
                      .description!), // dobbiamo dire a flutter che la descrizione può essere nulla
              ],
            )
          ],
        ));
  }
}
