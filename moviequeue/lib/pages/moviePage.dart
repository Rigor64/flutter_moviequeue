import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/vars.dart';

final homePageProvider = Provider((_) => 'MoviePage');

class MoviePage extends ConsumerStatefulWidget {
  //tipologia di cunsumer widget che può alterare il proprio stato
  const MoviePage({super.key});

  @override
  ConsumerState<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends ConsumerState<MoviePage> {
  late Future<List<Media>> popularMovies;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");

    return const Scaffold(
      backgroundColor: color2,
      body: SizedBox(),
    );
  }
}
