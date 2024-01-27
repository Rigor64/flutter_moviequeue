import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/vars.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  //final Media media;

  //const DetailScreen( {super.key,required this.media,});

  @override
  Widget build(BuildContext context) {
    // leggo la mappa presente sul file
    //Map<String, dynamic> preferiti = BookMark().readFromFile() as Map<String, dynamic>;
    //
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Media>("account")
              .listenable(), // preleviamo le informazioni contenute della box account
          builder: (context, box, child) {
            return const Stack(children: [
              SizedBox(
                height: 10,
              ),
            ]);
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop(); // Torna alla pagina precedente
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
