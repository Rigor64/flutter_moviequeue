import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/vars.dart';

final homePageProvider = Provider((_) => 'MoviePage');

class SeriesPage extends ConsumerStatefulWidget {
  //tipologia di cunsumer widget che può alterare il proprio stato
  const SeriesPage({super.key});

  @override
  ConsumerState<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends ConsumerState<SeriesPage> {
  late Future<List<Media>> popularMovies;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");

    return const Scaffold(
      backgroundColor: color1,
      body: SizedBox(),
    );
  }
}
