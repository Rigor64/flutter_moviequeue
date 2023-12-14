import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviequeue/pages/homepage.dart';
import 'package:moviequeue/pages/loginPage.dart';
import 'package:moviequeue/providers.dart';
import 'package:moviequeue/vars.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Queue',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(0, 236, 4, 4),
        ),
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: color1), //<-- SEE HERE
        ),
      ),

      home: Consumer(builder: (ctx, ref, _) {
        //la prima pagina visualizzata sarà quella del login
        var userData = ref.watch(userProfileProvider);
        if (userData == null) {
          return const LoginPage();
        } else {
          return Navigator(
              onGenerateInitialRoutes: (navigator, initialRoute) => [
                    MaterialPageRoute(
                        builder: (ctx) =>
                            MyHomePage(title: "Profilo ${userData.username}"))
                  ]);
        }
      }),
      //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/*

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

*/