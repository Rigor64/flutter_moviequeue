import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moviequeue/vars.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color3,
      body: ValueListenableBuilder(
          valueListenable: Hive.box("account")
              .listenable(), // preleviamo le informazioni contenute della box account
          builder: (context, box, child) {
            String username = box.get(1);
            String password = box.get(2);
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //immagine centrale
                    Container(
                      alignment: Alignment.center,
                      width: 150.0,
                      height: 150.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //nome
                    Text(
                      textAlign: TextAlign.center,
                      "Nome: $username",
                      softWrap: true,
                      style: const TextStyle(
                        color: color5,
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //password
                    Text(
                      textAlign: TextAlign.center,
                      "Password: $password",
                      softWrap: true,
                      style: const TextStyle(
                        color: color5,
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
      // Torna alla pagina precedente
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            tooltip: 'Torna indietro',
            backgroundColor: color3,
            foregroundColor: color5,
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ),
    );
  }
}
