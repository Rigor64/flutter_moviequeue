import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moviequeue/animations.dart';
import 'package:moviequeue/api.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/pages/bookmarkPage.dart';
import 'package:moviequeue/pages/moviePage.dart';
import 'package:moviequeue/pages/searchPage.dart';
import 'package:moviequeue/pages/seriesPage.dart';
import 'package:moviequeue/vars.dart';
import 'package:moviequeue/widgets/homeTrandingSlider.dart';
import 'package:moviequeue/widgets/movieSlider.dart';
import 'package:moviequeue/widgets/tvSeriesSlider.dart';

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
    final _pageController = PageController();
    debugPrint("Building $this");

    return Scaffold(
      //drawer: const NavDrawer(), //navigation bar right to left
      backgroundColor: color2,
      appBar: AppBar(
        //barra in alto
        toolbarHeight: 60,
        backgroundColor: color5,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: IconButton(
                onPressed: () => {
                      Navigator.push(context, animationAccountPage()),
                    },
                icon: const Icon(
                  Icons.account_box_rounded,
                  color: color3,
                  size: 40,
                )),
          ),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Media>("favorites").listenable(),
          builder: (context, box, child) {
            return PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              //primo carosello di film e serie tv
                              const SizedBox(height: 20),
                              SizedBox(
                                //prima di far apparire il carosello di oggetti, verifichiamo che ci sia connessione col server
                                child: FutureBuilder(
                                    future: trendingMedia,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        debugPrint(snapshot.error.toString());
                                        return Center(
                                          child:
                                              Text(snapshot.error.toString()),
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
                              //
                              const SizedBox(height: 20),
                              //
                              //secondo carosello
                              const Text(
                                "Film del momento",
                                style: TextStyle(
                                  color: color5,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 20),
                              //
                              SizedBox(
                                //prima di far apparire il carosello di oggetti, verifichiamo che ci sia connessione col server
                                child: FutureBuilder(
                                    future: popularMovies,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        debugPrint(snapshot.error.toString());
                                        return Center(
                                          child:
                                              Text(snapshot.error.toString()),
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
                              const SizedBox(height: 20),
                              //
                              //terzo carosello
                              const Text(
                                "Serie TV del momento",
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
                                          child:
                                              Text(snapshot.error.toString()),
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
                ),

                //altre pagine navigabili attraverso il bottom navigator
                const MoviePage(),
                const SeriesPage(),
                const SearchPage(),
                const BookmarkPage()
              ],
            );
          }),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: CurvedNavigationBar(
          index: 0,
          height: 60,
          backgroundColor: color2,
          animationDuration: const Duration(milliseconds: 300),
          buttonBackgroundColor: color3,
          onTap: (index) {
            setState(() {
              _pageController.jumpToPage(index);
            });
          },
          items: const [
            Icon(Icons.home_rounded, size: 30),
            Icon(Icons.movie, size: 30),
            Icon(Icons.tv, size: 30),
            Icon(Icons.search_outlined, size: 30),
            Icon(Icons.star_rounded, size: 30),
          ],
        ),
      ),
    );
  }
}
