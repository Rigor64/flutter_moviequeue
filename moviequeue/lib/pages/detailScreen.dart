import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
      body: Stack(
        children: [
          ..._buildBackgorund(context, media),
          Positioned(
            bottom: 200,
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
                      fontSize: 30,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              media.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 50.0,
                              color: media.isFavourite ? color3 : color4,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            release,
                            style: const TextStyle(color: color5, fontSize: 18),
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
                          const SizedBox(height: 15),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    media.overview,
                    style: const TextStyle(color: color5, fontSize: 15),
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

/*
Container(
                            padding: EdgeInsets.all(8),
                            child: Expanded(
                              child: Text(
                                titolo,
                                maxLines: 3,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: color5,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
*/