import 'package:flutter/material.dart';
import 'package:moviequeue/animations.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/pages/detailScreen.dart';
import 'package:moviequeue/vars.dart';

class movieSlider extends StatelessWidget {
  //widget per la visualizzazione del carosello dei film
  movieSlider({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          String titolo = snapshot.data![index].title;
          String release = snapshot.data![index].releaseDateFilm;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    animationDetailPage(snapshot.data[index], titolo, release));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 200,
                  width: 150,
                  child: Image.network(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      '${Vars.imagePath}${snapshot.data![index].posterPath}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
