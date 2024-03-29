import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/pages/loginPage.dart';
import 'package:moviequeue/vars.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //apriamo il database
  await Hive.initFlutter();
  Hive.registerAdapter(MediaAdapter());

  await Hive.openBox<Media>("favorites");
  await Hive.openBox("account");

  runApp(const ProviderScope(child: MyApp()));

  //opzioni di visualizzazione del UI del telefono
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
      home: SafeArea(
        child: Consumer(builder: (ctx, ref, _) {
          return const LoginPage();
        }),
      ),
    );
  }
}
