class Media {
  String type; //Movie o serie tv
  int id;
  String title;
  String originalTitle;
  String backDropPath;
  String posterPath;
  String overview;
  String releaseDate;
  double voteAvarage; //valutazione degli utenti

  //creo un constractor
  Media({
    required this.type,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.backDropPath,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAvarage,
  });

  //factory constractor per la creazione di una funzione specifica
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      type: json["media_type"] ?? '',
      id: json["id"] ?? '',
      title: json["name"] ?? '',
      originalTitle: json["original_name"] ?? '',
      backDropPath: json["backdrop_path"] ?? '',
      posterPath: json["poster_path"] ?? '',
      overview: json["overview"] ?? '',
      releaseDate: json["first_air_date"] ?? '',
      voteAvarage: json["vote_average"].toDouble() ?? '',
    );
  }
}



/*
"adult": false,
"backdrop_path": "/u3ySnWqSjM3jedYgJZTR7RWRDDm.jpg",
"id": 122226,
"name": "Echo",
"original_language": "en",
"original_name": "Echo",
"overview": "Pursued by Wilson Fisk's criminal empire, Maya's journey brings her home and she must confront her own family and legacy.",
"poster_path": "/vFyJH630cF68LohVYjQW49074Sy.jpg",
"media_type": "tv",
"genre_ids": [
18,
80,
10759
],
"popularity": 445.357,
"first_air_date": "2024-01-09",
"vote_average": 6.7,
"vote_count": 83,
"origin_country": [
"US"
]
*/