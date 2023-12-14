import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviequeue/pages/searchPage.dart';
import 'package:moviequeue/vars.dart';
import 'package:moviequeue/widgets/navDrawer.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class MyHomePage extends ConsumerWidget {
  final String title;
  const MyHomePage({required this.title, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _bottomNavIndex = 0;
    debugPrint("Building $this");

    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        //barra in alto
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Movie Queue"),
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
      drawer: const NavDrawer(),
      body: const Padding(
        //parte centrale della schermata
        padding: EdgeInsets.all(8),
        child: Column(

            //componenti della colonna principale della schemata della homepage

            ),
      ),
    );
  }
}
