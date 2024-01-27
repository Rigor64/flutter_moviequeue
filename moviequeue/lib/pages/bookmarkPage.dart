import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviequeue/animations.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/vars.dart';

class BookmarkPage extends StatefulWidget {
  //tipologia di cunsumer widget che può alterare il proprio stato
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  Future<List<Media>> _getData() async {
    var box = await Hive.openBox<Media>('favorites');
    List<Media> dataList = box.values.toList();

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");

    return Scaffold(
      backgroundColor: color2,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: color2,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            "Preferiti",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w800, color: color5, fontSize: 25),
          ),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Media>("favorites").listenable(),
          builder: (context, box, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder(
                future: _getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Media> dataList = snapshot.data as List<Media>;
                    return GridView.builder(
                      itemCount: dataList.length,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 350,
                              //crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        String titolo = "None";
                        String release = "None";
                        if (dataList[index].type == "movie") {
                          titolo = dataList[index].title;
                          release = dataList[index].releaseDateFilm;
                        } else {
                          titolo = dataList[index].name;
                          release = dataList[index].releaseDateTVSeries;
                        }

                        return GestureDetector(
                          //riconoscere un input a schermo
                          onTap: () {
                            Navigator.push(
                                context,
                                animationDetailPage(
                                    dataList[index], titolo, release));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              child: Image.network(
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                  '${Vars.imagePath}${dataList[index].posterPath}'),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            );
          }),
    );
  }
}
