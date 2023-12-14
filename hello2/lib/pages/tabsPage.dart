import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  TabController? _ctrl;

  @override
  void initState() {
    super.initState();

    _ctrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _ctrl?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tabs navigation"),
          bottom: TabBar(
            controller: _ctrl!,
            tabs: const [
              Tab(
                icon: Icon(Icons.abc),
                text: "Red",
              ),
              Tab(
                icon: Icon(Icons.abc),
                text: "Blue",
              ),
              Tab(
                icon: Icon(Icons.abc),
                text: "Green",
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: TabBarView(controller: _ctrl!, children: [
            Container(color: Colors.red),
            Container(color: Colors.blue),
            Container(color: Colors.green),
          ]),
        ));
  }
}
