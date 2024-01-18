class Media {
  String type; //Movie o serie tv
  int id;
  String title; //per FILM
  String name; //per serieTV
  String backDropPath;
  String posterPath;
  String overview;
  String releaseDateFilm; //per FILM
  String releaseDateTVSeries; //per serieTV
  double voteAverage; //valutazione degli utenti
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
      voteAverage: json["vote_average"].toDouble() ?? '',
      isFavourite: false,
    );
  }
}
