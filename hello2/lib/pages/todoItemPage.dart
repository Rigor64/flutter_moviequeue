import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../widgets/todoItemViewer.dart';

class TodoItemPage extends ConsumerStatefulWidget {
  final String todoItemId;

  const TodoItemPage(this.todoItemId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoItemPageState();
}

class _TodoItemPageState extends ConsumerState<TodoItemPage> {
  TextEditingController? _ctrlTitle;
  TextEditingController? _ctrlDescription;

  @override
  void initState() {
    super.initState();

    final todoItem = ref.read(specificTodoItemProvider(widget.todoItemId));

    _ctrlTitle = TextEditingController(text: todoItem.title);
    _ctrlDescription = TextEditingController(text: todoItem.description ?? "");
  }

  @override
  void dispose() {
    _ctrlTitle?.dispose();
    _ctrlDescription?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");

    final item = ref.watch(specificTodoItemProvider(widget.todoItemId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(item.title),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ref.read(userProfileProvider.notifier).logout();
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("ID: ${item.id}"),
            TextField(
              controller: _ctrlTitle,
              decoration: const InputDecoration(label: Text("Title")),
              onChanged: (value) {
                ref
                    .read(todoItemsProvider.notifier)
                    .setTitle(widget.todoItemId, value);
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _ctrlDescription,
              decoration: const InputDecoration(label: Text("Description")),
              minLines: 5,
              maxLines: 5,
              onChanged: (value) {
                ref
                    .read(todoItemsProvider.notifier)
                    .setDescription(widget.todoItemId, value);
              },
            ),
            const SizedBox(height: 32),
            const Text(
                "Qui sotto mostriamo lo stesso oggetto TodoItem tramite un‘istanza di TodoItemViewer, lo stesso widget che usiamo nella lista principale di TodoItem nella schermata principale."),
            const SizedBox(height: 8),
            ProviderScope(overrides: [
              currentTodoItemProvider.overrideWithValue(item),
            ], child: const TodoItemViewer()),
          ],
        ),
      ),
    );
  }
}
