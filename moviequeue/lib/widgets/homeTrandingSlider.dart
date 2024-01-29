import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moviequeue/models/animations.dart';
import 'package:moviequeue/vars.dart';

class homeTrandingSlider extends StatelessWidget {
  const homeTrandingSlider({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: snapshot.data!.length,
          options: CarouselOptions(
              //animazione di autoplay per scorrere le varie locandine
              height: 300,
              autoPlay: true,
              viewportFraction: 0.55,
              enlargeCenterPage: true,
              pageSnapping: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration:
                  const Duration(seconds: 1) //durata dell'animazione
              ),
          itemBuilder: (context, index, pageViewIndex) {
            String titolo = "None";
            String release = "None";
            if (snapshot.data![index].type == "movie") {
              titolo = snapshot.data![index].title;
              release = snapshot.data![index].releaseDateFilm;
            } else {
              titolo = snapshot.data![index].name;
              release = snapshot.data![index].releaseDateTVSeries;
            }
            return GestureDetector(
              //riconoscere un input a schermo
              onTap: () {
                Navigator.push(
                    context,
                    animationDetailPage(snapshot.data[index], titolo,
                        release) //passare al detail screen le informazioni riguardante il media corrispondente
                    );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 300,
                  width: 200,
                  child: Image.network(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      '${Vars.imagePath}${snapshot.data![index].posterPath}'),
                ),
              ),
            );
          },
        ));
  }
}
