class Todo {
  late final String id;
  final String title;
  final DateTime date;
  bool isChecked;
  Todo({
    required this.id,
    required this.title,
    required this.date,
    this.isChecked = false,
  });
}

List<Todo> todoList = [];
