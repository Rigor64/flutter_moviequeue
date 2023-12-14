import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Ciao!"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/login_background.jpg",
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.purple.shade700,
                          blurRadius: 12,
                          offset: Offset.fromDirection(120, 8)),
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Effettua l’accesso",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    TextField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.person), label: Text("Username")),
                        controller: _ctrlUsername),
                    const SizedBox(height: 16),
                    TextField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.key), label: Text("Password")),
                        controller: _ctrlPassword,
                        obscureText: true),
                    const SizedBox(height: 16),
                    Consumer(
                        builder: (ctx, ref, _) => ElevatedButton(
                            child: const Text("Login"),
                            onPressed: () {
                              if (!ref.read(userProfileProvider.notifier).login(
                                  _ctrlUsername!.text, _ctrlPassword!.text)) {
                                ScaffoldMessenger.of(context)
                                  ..clearSnackBars()
                                  ..showSnackBar(const SnackBar(
                                      content: Text(
                                          "Login o password non valida.")));
                              }
                            }))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
