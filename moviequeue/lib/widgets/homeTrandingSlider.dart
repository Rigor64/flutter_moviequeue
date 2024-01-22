import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/pages/detailScreen.dart';
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
                    _routeDetailPage(snapshot.data[index], titolo,
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

  //animazione per la pagine di ricerca
  PageRouteBuilder _routeDetailPage(Media media, titolo, release) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(
        media: media,
        titolo: titolo,
        release: release,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.8); // Inizio animazione dal basso
        const end = Offset.zero;
        const curve = Curves.fastEaseInToSlowEaseOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
