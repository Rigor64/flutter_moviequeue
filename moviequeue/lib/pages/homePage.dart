import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviequeue/pages/searchPage.dart';
import 'package:moviequeue/providers.dart';
import 'package:moviequeue/vars.dart';
import 'package:moviequeue/widgets/counterViewer.dart';
import 'package:moviequeue/widgets/greetingViewer.dart';
import 'package:moviequeue/widgets/navDrawer.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:moviequeue/widgets/todoItemPage.dart';
import 'package:moviequeue/widgets/todoItemViewer.dart';
import 'package:moviequeue/widgets/todoItemsCounterViewer.dart';

class MyHomePage extends ConsumerWidget {
  final String title;
  const MyHomePage({required this.title, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _bottomNavIndex = 0;
    debugPrint("Building $this");

    return Scaffold(
      drawer: const NavDrawer(), //navigation bar right to left
      backgroundColor: color1,
      appBar: AppBar(
        //barra in alto
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "Movie Queue",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        /*
        actions: [
          //primo bottone
        ],
        */
      ),
      body: const Padding(
          //lista di elementi
          padding: EdgeInsets.all(8),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TodoItemsCounterViewer(),
                  ],
                ),
                SizedBox(height: 8),
                Expanded(
                  child: _TodoList(),
                ),
              ])),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        //barra di navigazione sottostante
        icons: const [Icons.movie, Icons.tv],

        activeColor: color3,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => _bottomNavIndex = index,
        backgroundColor: color2,
      ),
      floatingActionButton: FloatingActionButton(
        //pulsante centrale
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchPage(),
            ),
          );
        },
        backgroundColor: color3,
        child: const Icon(Icons.search_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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