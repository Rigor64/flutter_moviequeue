class TodoItem {
  final String id;
  final String title;
  final bool done;
  final String? description;

  const TodoItem(this.id, this.title, this.done, [this.description]);

  TodoItem withDone(bool setDone) {
    return TodoItem(id, title, setDone, description);
  }

  TodoItem withDescription(String? newDescription) =>
      TodoItem(id, title, done, newDescription);

  TodoItem withTitle(String newTitle) =>
      TodoItem(id, newTitle, done, description);

  @override
  String toString() {
    return "$id: $title (${done ? "☑" : "❌"})";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is TodoItem) {
      return (id == other.id &&
          title == other.title &&
          done == other.done &&
          description == other.description);
    }

    return false;
  }
}
