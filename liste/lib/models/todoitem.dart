//lavoriamo con dei dati che verranno presi da un database
//id univoco
class TodoItem {
  // id guid che verrà generato automaticamente, serve per definire uno specifico oggetto
  final String id;
  final String title;
  final bool done;
  final String? description;

  const TodoItem(this.id, this.title, this.done,
      [this.description]); //in questo modo la descrizione può anche e;ssere non utilizzata

  TodoItem withDone(bool setDone) {
    return TodoItem(id, title, done, description);
  }

  @override
  String toString() {
    return "$id: $title (${done ? "👌" : "❌"})";
  }
}
