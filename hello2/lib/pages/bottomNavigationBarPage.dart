import 'package:flutter/material.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int pageIndex = 0;

  Widget buildPage() {
    switch (pageIndex) {
      case 0:
        return Container(color: Colors.red);
      case 1:
        return Container(color: Colors.blue);
      case 2:
        return Container(color: Colors.green);
      default:
        return Container(color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bottom bar navigation"),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageIndex,
            onTap: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.abc), label: "Abc1"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.abc), label: "Abc2"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.abc), label: "Abc3"),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: buildPage(),
        ));
  }
}
