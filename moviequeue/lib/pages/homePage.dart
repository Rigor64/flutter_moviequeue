import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviequeue/api/api.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/pages/searchPage.dart';
import 'package:moviequeue/providers.dart';
import 'package:moviequeue/vars.dart';
import 'package:moviequeue/widgets/homeTrandingSlider.dart';
import 'package:moviequeue/widgets/movieSlider.dart';
import 'package:moviequeue/widgets/navDrawer.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:moviequeue/widgets/tvSeriesSlider.dart';

final homePageProvider = Provider((_) => 'HomePage');

class MyHomePage extends ConsumerStatefulWidget {
  //tipologia di cunsumer widget che può alterare il proprio stato
  final String title;
  const MyHomePage({required this.title, super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends ConsumerState<MyHomePage> {
  late Future<List<Media>> trendingMedia;
  late Future<List<Media>> popularMovies;
  late Future<List<Media>> popularSeries;
  @override
  void initState() {
    super.initState();
    trendingMedia = Api().getTrendingMedia();
    popularMovies = Api().getPopularMovies();
    popularSeries = Api().getPopularTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    int _bottomNavIndex = 0;
    debugPrint("Building $this");

    return Scaffold(
      drawer: const NavDrawer(), //navigation bar right to left
      backgroundColor: color2,
      appBar: AppBar(
        //barra in alto
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "Movie Queue",
          style: TextStyle(fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          //primo bottone
          IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.star_rounded,
                color: color3,
                size: 35,
              )),
          IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.account_box_rounded,
                color: color3,
                size: 35,
              )),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  //primo carosello di film e serie tv
                  const Text(
                    "Trending Movies",
                    style: TextStyle(
                      color: color5,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    //prima di far apparire il carosello di oggetti, verifichiamo che ci sia connessione col server
                    child: FutureBuilder(
                        future: trendingMedia,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            debugPrint(snapshot.error.toString());
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return homeTrandingSlider(
                              snapshot: snapshot,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  //secondo carosello
                  const Text(
                    "Top rate movies",
                    style: TextStyle(
                      color: color5,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    //prima di far apparire il carosello di oggetti, verifichiamo che ci sia connessione col server
                    child: FutureBuilder(
                        future: popularMovies,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            debugPrint(snapshot.error.toString());
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return movieSlider(snapshot: snapshot);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                  //
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  //terzo carosello
                  const Text(
                    "Top rate Tv series",
                    style: TextStyle(
                      color: color5,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    //prima di far apparire il carosello di oggetti, verifichiamo che ci sia connessione col server
                    child: FutureBuilder(
                        future: popularSeries,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            debugPrint(snapshot.error.toString());
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return tvSeriesSlider(
                              snapshot: snapshot,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                ])),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        //barra di navigazione sottostante
        icons: const [Icons.movie, Icons.tv],
        height: 80,
        activeColor: color3,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => _bottomNavIndex = index,
        backgroundColor: color5,
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



/*
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
*/