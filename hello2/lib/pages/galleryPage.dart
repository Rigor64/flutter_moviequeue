import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello2/providers.dart';

class GalleryPage extends ConsumerWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoList = ref.watch(galleryProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Gallery"),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.refresh),
            onPressed: () {
              ref.refresh(galleryProvider);
            }),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: photoList.when(
              skipLoadingOnRefresh: false,
              data: (list) {
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (ctx, index) {
                      return Text("Photo ${list[index].id}");
                    });
              },
              error: (err, _) {
                return Container(
                    color: Colors.red,
                    child: Center(child: Text("AAAARGH! $err")));
              },
              loading: () => const Center(child: CircularProgressIndicator())),
        ));
  }
}
