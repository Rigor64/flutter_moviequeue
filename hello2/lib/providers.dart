import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'models/photoItem.dart';
import 'models/todoItem.dart';
import 'models/todoList.dart';
import 'models/userProfile.dart';

final greetingProvider = Provider((ref) {
  debugPrint("Sto costruendo greetingProvider");
  return "Ciao mondo!";
});

final counterProvider = StateProvider((ref) {
  debugPrint("Sto costruendo counterProvider");
  return 123;
});

final todoItemsProvider =
    StateNotifierProvider<TodoList, List<TodoItem>>((ref) => TodoList([]));

final currentTodoItemProvider = Provider<TodoItem>(
  (ref) => throw UnimplementedError(),
);

final specificTodoItemProvider = Provider.family<TodoItem, String>(
  (ref, id) {
    debugPrint("Rebuilding specific provider for todo item $id");
    return ref
        .watch(todoItemsProvider)
        .where((element) => element.id == id)
        .single;
  },
);

final todoItemsCounterProvider =
    Provider((ref) => ref.watch(todoItemsProvider).length);

final userProfileProvider = StateNotifierProvider<UserProfile, UserData?>(
  (ref) => UserProfile(null),
);

final galleryProvider = FutureProvider((ref) async {
  final response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));

  if (response.statusCode != 200) {
    throw Exception("Something happened");
  }

  List<dynamic> rawPhotoList = jsonDecode(response.body);
  var photoList = rawPhotoList
      .cast<Map<String, dynamic>>()
      .map((e) => PhotoItem.fromJson(e))
      .toList();

  photoList.shuffle();

  return photoList;
});
