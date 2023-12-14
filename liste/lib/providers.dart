//qui andrebbero inseriti tutti i provider di riverpod
//riverpod ha dei provider in cui noi ci registramo e i provider ci notificano dell'aggiornamento delle rebuild nell'interfaccia
//andiamo a definire i provider globali
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liste/models/todoList.dart';
import 'package:liste/models/todoitem.dart';

//provider che non hanno uno stato interno, non modificabile
final greetingProvider = Provider((ref) {
  debugPrint("STO COSTRUENDO IL PROVIDER");
  return "Testo definito dal provider";
});

//Provider modificabile che ha uno stato al suo interno
//stessa cosa nel main di: int count 123;
final counterProvider = StateProvider((ref) {
  debugPrint("STO COSTRUENDO IL PROVIDER");
  return 123;
});

//impacchettiamo la lista
final todoItemsProvider =
    StateNotifierProvider<TodoList, List<TodoItem>>((ref) => TodoList([]));

final currentTodoItemProvider =
    Provider<TodoItem>((ref) => throw UnimplementedError());
