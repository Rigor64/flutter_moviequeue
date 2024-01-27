import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moviequeue/pages/loginPage.dart';
import 'package:moviequeue/vars.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<StatefulWidget> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  TextEditingController? _ctrlUsername;
  TextEditingController? _ctrlPassword;

  @override
  void initState() {
    super.initState();

    _ctrlUsername = TextEditingController();
    _ctrlPassword = TextEditingController();
  }

  @override
  void dispose() {
    _ctrlUsername?.dispose();
    _ctrlPassword?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    const snackbar1 = SnackBar(
      content: Text(
        'Login o password non valida, si prega di riprovare',
        textAlign: TextAlign.center,
      ),
      backgroundColor: color3,
    );
    const snackbar2 = SnackBar(
      content: Text(
        'Utente aggiunto al database',
        textAlign: TextAlign.center,
      ),
      backgroundColor: color3,
    );

    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: Hive.box("account").listenable(),
          builder: (context, box, child) {
            return Stack(
              fit: StackFit.expand,
              children: [
                //ho applicato un filtro all'immagine di sfondo
                ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(color2, BlendMode.hardLight),
                  child: Image.asset(
                    "images/slashScreenLogin.png", //immagine di background
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                  child: Center(
                    child: Container(
                      //riquadro del login
                      width: 800,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: color3.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: color1.withOpacity(0.0),
                                blurRadius: 12,
                                offset: Offset.fromDirection(120, 8)),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Registra un nuovo account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                color: color5,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            //box per l'username
                            style: const TextStyle(color: color5, fontSize: 20),
                            cursorColor: color2,
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(color: color5),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: color5),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: color2),
                                ),
                                icon: Icon(
                                  Icons.person,
                                  color: color5,
                                ),
                                label: Text("Username",
                                    style: TextStyle(color: color5))),
                            controller: _ctrlUsername,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                              //box per la password
                              style:
                                  const TextStyle(color: color5, fontSize: 20),
                              cursorColor: color2,
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: color5),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: color2),
                                  ),
                                  icon: Icon(Icons.key, color: color5),
                                  label: Text("Password",
                                      style: TextStyle(color: color5))),
                              controller: _ctrlPassword,
                              obscureText: true),
                          const SizedBox(height: 16),
                          Consumer(
                              //box per il login
                              builder: (ctx, ref, _) => ElevatedButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return color3; //colore login alla pressione
                                        }
                                        if (states
                                            .contains(MaterialState.hovered)) {
                                          return color4; // colore login al passaggio del mouse
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  child: const Text("Registrati",
                                      style: TextStyle(
                                          color: color1,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800)),
                                  onPressed: () async {
                                    if (_ctrlUsername!.text != "") {
                                      if (_ctrlPassword!.text != "") {
                                        await box.put(1, _ctrlUsername!.text);
                                        await box.put(2, _ctrlPassword!.text);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar2);
                                        debugPrint(box.get(1));
                                        debugPrint(box.get(2));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar1);
                                      }
                                    }
                                  })),
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: const Text(
                                "Hai già un account ?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: color2,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
