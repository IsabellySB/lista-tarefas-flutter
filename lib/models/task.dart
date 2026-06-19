class Task {
  String id;
  String title;
  DateTime date;
  bool completed;

  Task({
    required this.id,
    required this.title,
    required this.date,
    this.completed = false,
  });
}
