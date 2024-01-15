import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/vars.dart';

class DetailScreen extends StatelessWidget {
  final Media media;
  const DetailScreen({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._buildBackgorund(context, media),
          Positioned(
            bottom: 220,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
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
                                '${Vars.imagePath}${media.backDropPath}'),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              media.title,
                              style: const TextStyle(
                                  color: color5,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            media.releaseDate,
                            style: const TextStyle(color: color5, fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          RatingBar.builder(
                            initialRating: 3.5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemSize: 20,
                            unratedColor: color4,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star,
                                color: color3,
                              );
                            },
                            onRatingUpdate: (rated) {
                              rated = media.voteAvarage;
                            },
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    media.overview,
                    style: const TextStyle(
                      color: color5,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildBackgorund(context, movie) {
    return [
      Container(
        height: double.infinity,
        color: color2,
      ),
      Image.network(
        height: MediaQuery.of(context).size.height * 0.5,
        width: double.infinity,
        fit: BoxFit.cover,
        '${Vars.imagePath}${media.posterPath}',
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
