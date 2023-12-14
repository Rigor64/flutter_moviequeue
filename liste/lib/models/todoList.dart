import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liste/models/todoitem.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class TodoList extends StateNotifier<List<TodoItem>> {
  TodoList(super.state);

  void addItem(String title, String? description) {
    final newTodoItem = TodoItem(_uuid.v4(), title, false, description);
    debugPrint("Adding $newTodoItem ");

    //la lista adesso è all'interno di state

    //aggiungo ogni item alla view della homepage
    //con i ...spacchetto un array, in questo caso aggiungo il nuovo elemento alla fine dell'array
    state = [...state, newTodoItem];
  }

  void setDone(String id, bool done) {
    //creiamo una copia della lista precedente per alterare lo stato di una variabile immutabile
    state = [
      for (final todoItem in state)
        if (todoItem.id == id) todoItem.withDone(done) else todoItem
    ];
  }

  //metodo per la rimozione di un elemento
  //rimpiazziamo la lista con un latra lista senza l'id che passiamo
  void remove(String id) {
    state = state.where((element) => element.id != id).toList();
  }
}
