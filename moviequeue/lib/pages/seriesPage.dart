import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviequeue/api.dart';
import 'package:moviequeue/animations.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/vars.dart';

class SeriesPage extends ConsumerStatefulWidget {
  //tipologia di cunsumer widget che può alterare il proprio stato
  const SeriesPage({super.key});

  @override
  ConsumerState<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends ConsumerState<SeriesPage> {
  late Future<List<Media>> discoverSeries;
  final AppinioSwiperController controller = AppinioSwiperController();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      _shakeCard();
    });
    discoverSeries = Api().getPopularTvSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");

    return ValueListenableBuilder(
        valueListenable: Hive.box<Media>("favorites").listenable(),
        builder: (context, box, snapshot) {
          return OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return CupertinoPageScaffold(
                backgroundColor: color2,
                child: OverflowBox(
                  maxHeight: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Scorpi nuove serie TV",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: color5),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        "Scorri verso destra per aggiungere ai preferiti",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: color5),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 600,
                        width: 400,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 20,
                              bottom: 20,
                            ),
                            child: FutureBuilder(
                                future: discoverSeries,
                                builder: (context, snapshot) {
                                  var data = snapshot.data;
                                  if (data == null) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    var datalength = data.length;
                                    if (datalength == 0) {
                                      return const Center(
                                        child: Text('no data found'),
                                      );
                                    } else {
                                      return AppinioSwiper(
                                        backgroundCardCount: 0,
                                        swipeOptions: const SwipeOptions.all(),
                                        controller: controller,
                                        onSwipeEnd: (previousIndex, targetIndex,
                                            activity) {
                                          switch (activity) {
                                            case Swipe():
                                              {
                                                if (activity.direction ==
                                                    AxisDirection.right) {
                                                  ScaffoldMessenger.of(context)
                                                      .clearSnackBars();
                                                  const snackbar = SnackBar(
                                                    content: Text(
                                                      'Preferito aggiunto con successo',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    backgroundColor: color3,
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackbar);
                                                  box.put(
                                                      snapshot
                                                          .data![previousIndex]
                                                          .id,
                                                      snapshot.data![
                                                          previousIndex]);
                                                }

                                                break;
                                              }

                                            case Unswipe():
                                              //debugPrint('')
                                              break;
                                            case CancelSwipe():
                                              //debugPrint('A swipe was cancelled');
                                              break;
                                            case DrivenActivity():
                                              //debugPrint('Driven Activity');
                                              break;
                                          }
                                        },
                                        onEnd: _onEnd,
                                        cardCount: snapshot.data!.length,
                                        cardBuilder: (context, index) {
                                          if (snapshot.hasError) {
                                            debugPrint(
                                                snapshot.error.toString());
                                            return Center(
                                              child: Text(
                                                  snapshot.error.toString()),
                                            );
                                          } else if (snapshot.hasData) {
                                            return GestureDetector(
                                              //riconoscere un input a schermo
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    animationDetailPage(
                                                        //passare al detail screen le informazioni riguardante il media corrispondente
                                                        snapshot.data![index],
                                                        snapshot
                                                            .data![index].name,
                                                        snapshot.data![index]
                                                            .releaseDateTVSeries));
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: SizedBox(
                                                  height: 300,
                                                  width: 200,
                                                  child: Image.network(
                                                      filterQuality:
                                                          FilterQuality.high,
                                                      fit: BoxFit.cover,
                                                      '${Vars.imagePath}${snapshot.data![index].posterPath}'),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        },
                                      );
                                    }
                                  }
                                }),
                          ),
                        ),
                      ),
                      IconTheme.merge(
                        data: const IconThemeData(size: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            unswipeButton(controller),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return CupertinoPageScaffold(
                backgroundColor: color2,
                child: OverflowBox(
                  maxHeight: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Column(
                        children: [
                          Text(
                            "Scorpi nuovi film",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: color5),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Scorri verso destra per aggiungere ai preferiti",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: color5),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 300,
                        width: 220,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 20,
                              bottom: 20,
                            ),
                            child: FutureBuilder(
                                future: discoverSeries,
                                builder: (context, snapshot) {
                                  var data = snapshot.data;
                                  if (data == null) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    var datalength = data.length;
                                    if (datalength == 0) {
                                      return const Center(
                                        child: Text('no data found'),
                                      );
                                    } else {
                                      return AppinioSwiper(
                                        backgroundCardCount: 0,
                                        swipeOptions: const SwipeOptions.all(),
                                        controller: controller,
                                        onSwipeEnd: (previousIndex, targetIndex,
                                            activity) {
                                          switch (activity) {
                                            case Swipe():
                                              {
                                                if (activity.direction ==
                                                    AxisDirection.right) {
                                                  ScaffoldMessenger.of(context)
                                                      .clearSnackBars();
                                                  const snackbar = SnackBar(
                                                    content: Text(
                                                      'Preferito aggiunto con successo',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    backgroundColor: color3,
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackbar);
                                                  box.put(
                                                      snapshot
                                                          .data![previousIndex]
                                                          .id,
                                                      snapshot.data![
                                                          previousIndex]);
                                                }

                                                break;
                                              }

                                            case Unswipe():
                                              //debugPrint('')
                                              break;
                                            case CancelSwipe():
                                              //debugPrint('A swipe was cancelled');
                                              break;
                                            case DrivenActivity():
                                              //debugPrint('Driven Activity');
                                              break;
                                          }
                                        },
                                        onEnd: _onEnd,
                                        cardCount: snapshot.data!.length,
                                        cardBuilder: (context, index) {
                                          if (snapshot.hasError) {
                                            debugPrint(
                                                snapshot.error.toString());
                                            return Center(
                                              child: Text(
                                                  snapshot.error.toString()),
                                            );
                                          } else if (snapshot.hasData) {
                                            return GestureDetector(
                                              //riconoscere un input a schermo
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    animationDetailPage(
                                                        //passare al detail screen le informazioni riguardante il media corrispondente
                                                        snapshot.data![index],
                                                        snapshot
                                                            .data![index].name,
                                                        snapshot.data![index]
                                                            .releaseDateTVSeries));
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: SizedBox(
                                                  height: 300,
                                                  width: 200,
                                                  child: Image.network(
                                                      filterQuality:
                                                          FilterQuality.high,
                                                      fit: BoxFit.cover,
                                                      '${Vars.imagePath}${snapshot.data![index].posterPath}'),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        },
                                      );
                                    }
                                  }
                                }),
                          ),
                        ),
                      ),
                      IconTheme.merge(
                        data: const IconThemeData(size: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            unswipeButton(controller),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          });
        });
  }

  Widget unswipeButton(AppinioSwiperController controller) {
    return GestureDetector(
      onTap: () => controller.unswipe(),
      child: Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        child: const Icon(
          Icons.rotate_left_rounded,
          color: color4,
        ),
      ),
    );
  }

  void _onEnd() {
    debugPrint('end reached!');
  }

  // Animates the card back and forth to teach the user that it is swipable.
  Future<void> _shakeCard() async {
    const double distance = 30;
    // We can animate back and forth by chaining different animations.
    await controller.animateTo(
      const Offset(-distance, 0),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    await controller.animateTo(
      const Offset(distance, 0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    // We need to animate back to the center because `animateTo` does not center
    // the card for us.
    await controller.animateTo(
      const Offset(0, 0),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}
