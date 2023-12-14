import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviequeue/models/todoItem.dart';
import 'package:moviequeue/models/todoList.dart';
import 'package:moviequeue/models/userProfile.dart';

final userProfileProvider = StateNotifierProvider<UserProfile, UserData?>(
  (ref) => UserProfile(null),
);

final greetingProvider = Provider((ref) {
  debugPrint("Sto costruendo greetingProvider");
  return "Ciao mondo!";
});

final counterProvider = StateProvider((ref) {
  debugPrint("Sto costruendo counterProvider");
  return 0;
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
