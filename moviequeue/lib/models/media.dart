import 'package:hive_flutter/hive_flutter.dart';

part 'media.g.dart';

@HiveType(typeId: 0)
class Media extends HiveObject {
  @HiveField(0)
  String type; //Movie o serie tv
  @HiveField(1)
  int id;
  @HiveField(2)
  String title; //per FILM
  @HiveField(3)
  String name; //per serieTV
  @HiveField(4)
  String backDropPath;
  @HiveField(5)
  String posterPath;
  @HiveField(6)
  String overview;
  @HiveField(7)
  String releaseDateFilm; //per FILM
  @HiveField(8)
  String releaseDateTVSeries; //per serieTV
  @HiveField(9)
  double voteAverage; //valutazione degli utenti
  @HiveField(10)
  bool isFavourite;

  //creo un constractor
  Media({
    required this.type,
    required this.id,
    required this.title,
    required this.name,
    required this.backDropPath,
    required this.posterPath,
    required this.overview,
    required this.releaseDateFilm,
    required this.releaseDateTVSeries,
    required this.voteAverage,
    required this.isFavourite,
  });

  //factory constractor per la creazione di una funzione specifica
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      type: json["media_type"] ?? '',
      id: json["id"] ?? '',
      title: json["title"] ?? '',
      name: json["name"] ?? '',
      backDropPath: json["backdrop_path"] ?? '',
      posterPath: json["poster_path"] ?? '',
      overview: json["overview"] ?? '',
      releaseDateFilm: json["release_date"] ?? '',
      releaseDateTVSeries: json["first_air_date"] ?? '',
      voteAverage: json["vote_average"] ?? '',
      isFavourite: false,
    );
  }
}
