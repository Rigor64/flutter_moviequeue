import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moviequeue/vars.dart';

class homeTrandingSlider extends StatelessWidget {
  const homeTrandingSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: CarouselSlider.builder(
            itemCount: 10,
            itemBuilder: (context, itemIndex, pageViewIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 300,
                  width: 200,
                  color: color3,
                ),
              );
            },
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
                )));
  }
}
