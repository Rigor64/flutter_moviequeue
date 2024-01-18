import 'package:flutter/material.dart';

//palette di colori utilizzata in tutta l'applicazione
const color1 = Color.fromARGB(255, 0, 0, 0);
const color2 = Color.fromARGB(255, 20, 33, 61);
const color3 = Color.fromARGB(255, 252, 163, 17);
const color4 = Color.fromARGB(255, 229, 229, 229);
const color5 = Color.fromARGB(255, 255, 255, 255);

class Vars {
  static const apiKey = '89e710f6bd1bb53b262612a8e4a2dafc'; //TMDB API
  var headers = {
    'accept': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OWU3MTBmNmJkMWJiNTNiMjYyNjEyYThlNGEyZGFmYyIsInN1YiI6IjY1YTExZDMyZGI0ZWQ2MDEzMjVmOTFkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VeYpxC5lcslngtEmcJEL0K6oA2OKvytwxudBKA-N1kM'
  };
  static const imagePath =
      'https://image.tmdb.org/t/p/w500'; //percorso per avere le locandine dei media
}
