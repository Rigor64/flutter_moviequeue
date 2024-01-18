import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviequeue/pages/detailScreen.dart';
import 'package:moviequeue/vars.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  void _searchMovies(String query) async {
    const String apiKey = Vars.apiKey;
    const String baseUrl = 'https://api.themoviedb.org/3/search/movie';
    const String language = 'it-IT';

    final Uri uri = Uri.parse(
      '$baseUrl?api_key=$apiKey&language=$language&query=$query',
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _searchResults = data['results'];
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cerca'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Movies',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchMovies(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final movie = _searchResults[index];
                return GestureDetector(
                  //riconoscere un input a schermo
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            media: _searchResults[index],
                            titolo: movie["title"],
                            release: movie["release_date"],
                          ), //passare al detail screen le informazioni riguardante il media corrispondente
                        ));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                              color3, BlendMode.softLight),
                          child: Image.network(
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              '${Vars.imagePath}${movie["poster_path"]}'),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*
String titolo = _searchResults[index];
                String release = _searchResults[index].releaseDateFilm;

                final movie = _searchResults[index];
                return GestureDetector(
                  //riconoscere un input a schermo
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            media: _searchResults[index],
                            titolo: titolo,
                            release: release,
                          ), //passare al detail screen le informazioni riguardante il media corrispondente
                        ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 300,
                      width: 200,
                      child: Image.network(
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          '${Vars.imagePath}${_searchResults[index].posterPath}'),
                    ),
                  ),
                );
                */