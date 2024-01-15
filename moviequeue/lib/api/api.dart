import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/models/movies.dart';
import 'package:moviequeue/models/series.dart';
import 'package:moviequeue/vars.dart';

class Api {
  static const _trendingUrl =
      'https://api.themoviedb.org/3/trending/all/day?api_key=${Vars.apiKey}';

  static const _popularMovieUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=${Vars.apiKey}';

  static const _popularSeriesUrl =
      'https://api.themoviedb.org/3/tv/popular?api_key=${Vars.apiKey}';

  Future<List<Media>> getTrendingMedia() async {
    //status code che identifica se la comunicazione sta avvenendo
    //funzione asincrona per far lavorare le varie parti non contemporaneamente
    final response = await http.get(Uri.parse(_trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((media) => Media.fromJson(media)).toList();
    } else {
      throw Exception("Errore");
    }
  }

  Future<List<Movies>> getPopularMovies() async {
    //status code che identifica se la comunicazione sta avvenendo
    //funzione asincrona per far lavorare le varie parti non contemporaneamente
    final response = await http.get(Uri.parse(_popularMovieUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movies) => Movies.fromJson(movies)).toList();
    } else {
      throw Exception("Errore");
    }
  }

  Future<List<Series>> getPopularTvSeries() async {
    //status code che identifica se la comunicazione sta avvenendo
    //funzione asincrona per far lavorare le varie parti non contemporaneamente
    final response = await http.get(Uri.parse(_popularSeriesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((series) => Series.fromJson(series)).toList();
    } else {
      throw Exception("Errore");
    }
  }
}
