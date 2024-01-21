import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/vars.dart';

final homePageProvider = Provider((_) => 'BookmarkPage');

class BookmarkPage extends ConsumerStatefulWidget {
  //tipologia di cunsumer widget che può alterare il proprio stato
  const BookmarkPage({super.key});

  @override
  ConsumerState<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends ConsumerState<BookmarkPage> {
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
