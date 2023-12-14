import 'package:flutter/material.dart';

//barra laterale di ricerca
class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Sto aprendo uil menu laterale");
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .stretch, //allineamento del contenuto della colonna
        children: [
          const DrawerHeader(
            decoration: FlutterLogoDecoration(),
            child: Text("Barra laterale"), //titolo della barra laterale
          ),
          Expanded(
              child: ListView(
            children: [
              ListTile(
                title: const Text("Homepage"),
                onTap: () {},
              ),
              /*
              
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
              */
            ],
          )),
        ],
      ),
    );
  }
}
