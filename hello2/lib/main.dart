import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/homePage.dart';
import 'pages/loginPage.dart';
import 'providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
      home: Consumer(builder: (ctx, ref, _) {
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
    );
  }
}
