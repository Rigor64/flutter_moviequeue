import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/vars.dart';

class DetailScreen extends StatelessWidget {
  final Media media;
  final String titolo;
  final String release;

  const DetailScreen(
      {super.key,
      required this.media,
      required this.titolo,
      required this.release});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return ValueListenableBuilder(
              // leggo la mappa presente sul file
              //
              valueListenable: Hive.box<Media>("favorites").listenable(),
              builder: (context, box, child) {
                //cerchiamo se il titolo è stato aggiumto ai preferiti
                final isFavourite = box.get(media.id) != null;
                //
                return Stack(
                  children: [
                    ..._buildBackground(context, media),
                    Positioned(
                      top: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              titolo,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: 250,
                                      width: 180,
                                      child: Image.network(
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.cover,
                                        '${Vars.imagePath}${media.backDropPath}',
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      //icona del cuore per aggiungere ai preferiti
                                      onTap: () async {
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        if (isFavourite) {
                                          await box.delete(media.id);
                                          const snackbar = SnackBar(
                                            content: Text(
                                              'Preferito rimosso con successo',
                                              textAlign: TextAlign.center,
                                            ),
                                            backgroundColor: color3,
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                                        } else {
                                          await box.put(media.id, media);
                                          const snackbar = SnackBar(
                                            content: Text(
                                              'Preferito aggiunto con successo',
                                              textAlign: TextAlign.center,
                                            ),
                                            backgroundColor: color3,
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                                        }
                                      },
                                      child: Icon(
                                        isFavourite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 50.0,
                                        color: isFavourite ? color3 : color3,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      release,
                                      style: const TextStyle(
                                          color: color5, fontSize: 25),
                                    ),
                                    const SizedBox(height: 10),
                                    RatingBarIndicator(
                                      itemBuilder: (context, index) {
                                        return const Icon(
                                          Icons.star,
                                          color: color3,
                                        );
                                      },
                                      rating: media.voteAverage / 2,
                                      direction: Axis.horizontal,
                                      itemSize: 20,
                                      itemCount: 5,
                                      unratedColor: color4,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 400,
                              child: OverflowBox(
                                child: Text(
                                  media.overview,
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: color5, fontSize: 20),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20)
                          ],
                        ),
                      ),
                    )
                  ],
                );
              });
        } else {
          return ValueListenableBuilder(
              valueListenable: Hive.box<Media>("favorites").listenable(),
              builder: (context, box, child) {
                //cerchiamo se il titolo è stato aggiumto ai preferiti
                final isFavourite = box.get(media.id) != null;
                //
                return Stack(
                  children: [
                    ..._buildBackground(context, media),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  titolo,
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
                                  height: 16,
                                ),
                                SizedBox(
                                  width: 550,
                                  height: 320,
                                  child: OverflowBox(
                                    child: Text(
                                      media.overview,
                                      maxLines: 14,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: color5,
                                        fontSize: 20,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 5.0,
                                            color: Colors.black,
                                            offset: Offset(2.0, 2.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    //icona del cuore per aggiungere ai preferiti
                                    onTap: () async {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      if (isFavourite) {
                                        await box.delete(media.id);
                                        const snackbar = SnackBar(
                                          content: Text(
                                            'Preferito rimosso con successo',
                                            textAlign: TextAlign.center,
                                          ),
                                          backgroundColor: color3,
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      } else {
                                        await box.put(media.id, media);
                                        const snackbar = SnackBar(
                                          content: Text(
                                            'Preferito aggiunto con successo',
                                            textAlign: TextAlign.center,
                                          ),
                                          backgroundColor: color3,
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      }
                                    },
                                    child: Icon(
                                      isFavourite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 50.0,
                                      color: isFavourite ? color3 : color3,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SizedBox(
                                        height: 200,
                                        width: 150,
                                        child: Image.network(
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.cover,
                                          '${Vars.imagePath}${media.backDropPath}',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    release,
                                    style: const TextStyle(
                                        color: color5, fontSize: 25),
                                  ),
                                  const SizedBox(height: 10),
                                  RatingBarIndicator(
                                    itemBuilder: (context, index) {
                                      return const Icon(
                                        Icons.star,
                                        color: color3,
                                      );
                                    },
                                    rating: media.voteAverage / 2,
                                    direction: Axis.horizontal,
                                    itemSize: 20,
                                    itemCount: 5,
                                    unratedColor: color4,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              });
        }
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

  List<Widget> _buildBackground(context, movie) {
    return [
      Container(
        height: double.infinity,
        color: color2,
      ),
      ColorFiltered(
        colorFilter: const ColorFilter.mode(color4, BlendMode.modulate),
        child: Image.network(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          fit: BoxFit.cover,
          '${Vars.imagePath}${media.posterPath}',
        ),
      ),
      const Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.transparent, color2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.2, 0.5]),
          ),
        ),
      )
    ];
  }
}
