import 'package:flutter/material.dart';
import 'package:hello2/pages/galleryPage.dart';

import '../pages/bottomNavigationBarPage.dart';
import '../pages/tabsPage.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DrawerHeader(
            decoration: FlutterLogoDecoration(),
            child: Text("Navigazione"),
          ),
          Expanded(
              child: ListView(
            children: [
              ListTile(
                title: const Text("Homepage"),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Bottom bar nav"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const BottomNavigationBarPage(),
                  ));
                },
              ),
              ListTile(
                title: const Text("Tabs nav"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TabsPage(),
                  ));
                },
              ),
              ListTile(
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const GalleryPage(),
                  ));
                },
              ),
            ],
          )),
        ],
      ),
    );
  }
}
