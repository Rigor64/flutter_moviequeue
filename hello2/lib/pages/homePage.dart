import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../widgets/counterViewer.dart';
import '../widgets/greetingViewer.dart';
import '../widgets/navDrawer.dart';
import '../widgets/todoItemViewer.dart';
import '../widgets/todoItemsCounterViewer.dart';
import 'todoItemPage.dart';

class MyHomePage extends ConsumerWidget {
  final String title;

  const MyHomePage({required this.title, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("To-do"),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              ref.read(todoItemsProvider.notifier).clear();
            },
          ),
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ref.read(userProfileProvider.notifier).logout();
              })
        ],
      ),
      drawer: const NavDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProviderScope(overrides: [
                    greetingProvider
                        .overrideWithValue("Override di greetingProvider")
                  ], child: const GreetingViewer()),
                  const CounterViewer(),
                ],
              ),
              const SizedBox(height: 8),
              const Expanded(
                child: _TodoList(),
              ),
              // Qui sotto si mostra il conteggio dei TodoItem tramite il todoItemsCounterProvider
              // La prima volta tramite un widget stateless dedicato, la seconda con un Consumer
              const TodoItemsCounterViewer(),
              /*Consumer(
                builder: (ctx, ref, _) {
                  debugPrint("Building Consumer con builder");
                  return Text(
                      "Ho ${ref.watch(todoItemsCounterProvider)} cose da fare.");
                },
              ),*/
              //
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    int counter = ref.read(counterProvider);
                    debugPrint("Prima del click il contator era $counter");

                    ref.read(counterProvider.notifier).state = (counter + 1);
                  },
                  child: const Text("Contatore +1"),
                ),
              )
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(todoItemsProvider.notifier).generateNewItem();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}

class _TodoList extends ConsumerWidget {
  const _TodoList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");

    return ListView.builder(
      itemCount: ref.watch(todoItemsCounterProvider),
      itemBuilder: (context, index) {
        final list = ref.watch(todoItemsProvider);
        final item = list[index];

        return Dismissible(
          key: ValueKey(item.id),
          onDismissed: (direction) {
            debugPrint("Sto rimuovendo $item");

            ref.read(todoItemsProvider.notifier).remove(item.id);
          },
          child: GestureDetector(
            onTap: () async {
              // ref.read(stoFacendoCose.notifier).state = true;

              // Scarica un file

              // Calcola tutti i numeri primi

              // ref.read(stoFacendoCose.notifier).state = false;

              // Navigare
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TodoItemPage(item.id),
              ));
            },
            child: ProviderScope(
                overrides: [currentTodoItemProvider.overrideWithValue(item)],
                child: const TodoItemViewer()),
          ),
        );
      },
    );
  }
}
