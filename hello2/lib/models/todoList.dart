import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'todoItem.dart';

const _uuid = Uuid();

final List<String?> _descriptions = [
  "Una descrizione di esempio.",
  "Un’altra descrizione di esempio.",
  "Una breve descrizione del compito.",
  "Un compito molto arduo.",
  "Altre cose che non ho alcuna intenzione di fare, né ora né mai.",
  "Che belli i provider di Riverpod! 🤯",
  null,
  null,
  null,
  null,
];

final Random _rnd = Random();

class TodoList extends StateNotifier<List<TodoItem>> {
  int counter = 1;

  TodoList(super.state);

  void clear() {
    counter = 1;
    state = [];
  }

  void addItem(String title, String? description) {
    final newTodoItem = TodoItem(_uuid.v4(), title, false, description);
    debugPrint("Adding $newTodoItem");

    state = [...state, newTodoItem];
  }

  void generateNewItem() {
    addItem(
        "Item ${counter++}", _descriptions[_rnd.nextInt(_descriptions.length)]);
  }

  void setDone(String id, bool done) {
    state = [
      for (final todoItem in state)
        if (todoItem.id == id) todoItem.withDone(done) else todoItem
    ];
  }

  void setDescription(String id, String description) {
    state = [
      for (final todoItem in state)
        if (todoItem.id == id)
          todoItem.withDescription(description)
        else
          todoItem
    ];
  }

  void setTitle(String id, String title) {
    state = [
      for (final todoItem in state)
        if (todoItem.id == id) todoItem.withTitle(title) else todoItem
    ];
  }

  void remove(String id) {
    // final listaNuova = [...state];
    // listaNuova.removeAt(1);

    // In C#: LINQ
    state = state.where((element) => element.id != id).toList();
  }
}
