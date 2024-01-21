import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviequeue/models/media.dart';
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
      backgroundColor: color2,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: TextField(
              textAlign: TextAlign.center,
              cursorColor: color3,
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (String value) {
                _searchMovies(_searchController.text);
              },
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: color3),
                ),
                hintText: 'Inserisci il film da cercare',
                hintStyle: const TextStyle(color: color5),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.screen_search_desktop_outlined,
                    color: color5,
                    size: 30,
                  ),
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    _searchMovies(_searchController.text);
                  },
                ),
              ),
              style: TextStyle(color: color5, fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                List<Media> data = _searchResults
                    .map((series) => Media.fromJson(series))
                    .toList();
                final movie = _searchResults[index];
                return GestureDetector(
                  //riconoscere un input a schermo
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            media: data[index],
                            titolo: movie["title"],
                            release: movie["release_date"],
                          ), //passare al detail screen le informazioni riguardante il media corrispondente
                        ));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                  color4, BlendMode.modulate),
                              child: Image.network(
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                  '${Vars.imagePath}${movie["poster_path"]}'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: SizedBox(
                              height: 120,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: OverflowBox(
                                  maxHeight: double.infinity,
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    movie["title"],
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900,
                                      color: color5,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0,
                                          color: Colors.black,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
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
