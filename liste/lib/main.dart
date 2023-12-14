import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liste/providers.dart';
import 'package:liste/widgets/counterViewer.dart';
import 'package:liste/widgets/greetingViewer.dart';
import 'package:liste/widgets/todoItemViwer.dart';

void main() {
  runApp(const ProviderScope(child: MyApp())); //creare un instanza del provider
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter List'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  final ScrollController scrollctrl1 = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this ");

    List<Widget> todoItemWidget = [];
    for (var todoItem in                 ) {
      todoItemWidget.add(TodoItemViewer(todoItem));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Peppe"),
        actions: [
          //ActionChip(label: Text("Pulsante")),

          //creo un bottone che sarà identificato da un icona e che svolge la stessa funzione del contatore
          IconButton(
              onPressed: () {
                debugPrint("Action clicked");
                //manca la cancellazione degli item
              },
              icon: const Icon(Icons.ac_unit))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GreetingViewer(),
                  CounterViewer(),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                //noi gli forniamo un metodo con cui costruire gli elementi cosi non dovrà costruirli sempre tutti
                //cosi i widget visibili sono quelli che sono stati caricati e vengono gestiti dinamicamente
                child: ListView.builder(
                    itemCount: ref.watch(todoItemsProvider).length,
                    itemBuilder: (context, index) {
                      final list = ref.watch(todoItemsProvider);
                      return ProviderScope(
                        overrides: [
                          currentTodoItemProvider.overrideWithValue(list[index])
                        ],
                        child: const TodoItemViewer(),);
                    },
                )

                /*child: SingleChildScrollView(
                //la colonna potrà essere scorsa dal dito
                child: Column(
                  children: todoItemWidget,
                ),
              ),*/
              ),
              Text("Ho ${ref.watch(todoItemsProvider).length} cose da fare"),
              ElevatedButton(
                onPressed: () {
                  int counter = ref.read(counterProvider);
                  debugPrint("Il contatore era a $counter");

                  ref.read(counterProvider.notifier).state += 1;
                },
                child: const Text("Contatore +1"),
              )
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .watch(todoItemsProvider.notifier)
              .addItem("Pippo", "La descrizione");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
