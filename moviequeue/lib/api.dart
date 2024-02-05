import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/vars.dart';

/*
'https://api.themoviedb.org/3/trending/all/day?api_key=${Vars.apiKey}'
'https://api.themoviedb.org/3/trending/movie/day?api_key=${Vars.apiKey}'
'https://api.themoviedb.org/3/trending/tv/day?api_key=${Vars.apiKey}'
*/

class Api {
  static const _trendingUrl =
      'https://api.themoviedb.org/3/trending/all/day?language=it-IT';

  static const _popularMovieUrl =
      'https://api.themoviedb.org/3/trending/movie/day?language=it-IT';

  static const _popularSeriesUrl =
      'https://api.themoviedb.org/3/trending/tv/day?language=it-IT';

  static const searchUrl = 'https://api.themoviedb.org/3/search/movie';

  static const _discoverMovieUrl =
      'https://api.themoviedb.org/3/discover/movie'; //non implementata

  static const _discoverTVUrl =
      'https://api.themoviedb.org/3/discover/tv?language=it-IT'; //non implementata

  Future<List<Media>> getTrendingMedia() async {
    //status code che identifica se la comunicazione sta avvenendo
    //funzione asincrona per far lavorare le varie parti non contemporaneamente
    final response =
        await http.get(Uri.parse(_trendingUrl), headers: Vars().headers);
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((media) => Media.fromJson(media)).toList();
    } else {
      throw Exception("Errore");
    }
  }

  Future<List<Media>> getPopularMovies() async {
    final response =
        await http.get(Uri.parse(_popularMovieUrl), headers: Vars().headers);
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movies) => Media.fromJson(movies)).toList();
    } else {
      throw Exception("Errore");
    }
  }

  Future<List<Media>> getPopularTvSeries() async {
    final response =
        await http.get(Uri.parse(_popularSeriesUrl), headers: Vars().headers);
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((series) => Media.fromJson(series)).toList();
    } else {
      throw Exception("Errore");
    }
  }

  Future<List<Media>> getDiscoverMovie() async {
    final response =
        await http.get(Uri.parse(_discoverMovieUrl), headers: Vars().headers);
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movies) => Media.fromJson(movies)).toList();
    } else {
      throw Exception("Errore");
    }
  }

  Future<List<Media>> getDiscoverTV() async {
    final response =
        await http.get(Uri.parse(_discoverTVUrl), headers: Vars().headers);
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((tv) => Media.fromJson(tv)).toList();
    } else {
      throw Exception("Errore");
    }
  }
}
