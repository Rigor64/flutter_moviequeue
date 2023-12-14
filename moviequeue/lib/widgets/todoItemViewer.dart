import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviequeue/providers.dart';

class TodoItemViewer extends ConsumerWidget {
  const TodoItemViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");

    final item = ref.watch(currentTodoItemProvider);

    return Container(
      decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor.withAlpha(40),
                blurRadius: 10,
                offset: Offset.fromDirection(120, 4)),
          ]),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
              value: item.done,
              onChanged: (c) {
                debugPrint("Item $item check $c");

                ref.read(todoItemsProvider.notifier).setDone(item.id, c!);
              }),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(item.title,
                    style: Theme.of(context).textTheme.headlineSmall),
                if (item.description != null) Text(item.description!),
              ],
            ),
          )
        ],
      ),
    );
  }
}


/*
class TodoItemViewer extends StatelessWidget {
  final TodoItem item;

  const TodoItemViewer(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this with $item");

    return Container(
      decoration: BoxDecoration(color: Colors.purple.shade100, boxShadow: [
        BoxShadow(
            color: Theme.of(context).shadowColor.withAlpha(50),
            blurRadius: 10,
            offset: Offset.fromDirection(120, 8)),
      ]),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Checkbox(value: item.done, onChanged: (c) {}),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title,
                  style: Theme.of(context).textTheme.headlineSmall),
              if (item.description != null) Text(item.description!),
            ],
          )
        ],
      ),
    );
  }
}
*/
