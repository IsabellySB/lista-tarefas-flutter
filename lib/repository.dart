import 'models/task.dart';

/// Classe simples de usuário, guardada apenas em memória (sem Firebase).
class AppUser {
  String name;
  String ra;
  String email;
  String password;

  AppUser({
    required this.name,
    required this.ra,
    required this.email,
    required this.password,
  });
}

/// Repositório central (singleton) que guarda usuários e tarefas
/// enquanto o app está aberto. Substitui o Firebase para fins didáticos.
class AppRepository {
  AppRepository._internal();
  static final AppRepository instance = AppRepository._internal();

  final List<AppUser> _users = [];
  final List<Task> _tasks = [];
  AppUser? loggedUser;

  // ---------------- USUÁRIOS ----------------
  bool registerUser(AppUser user) {
    final exists = _users.any((u) => u.email == user.email);
    if (exists) return false;
    _users.add(user);
    return true;
  }

  AppUser? login(String email, String password) {
    try {
      final user = _users.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      loggedUser = user;
      return user;
    } catch (e) {
      return null;
    }
  }

  // ---------------- TAREFAS ----------------
  String _dateKey(DateTime date) =>
      '${date.year}-${date.month}-${date.day}';

  List<Task> tasksForDate(DateTime date) {
    final key = _dateKey(date);
    final list = _tasks
        .where((t) => _dateKey(t.date) == key)
        .toList();

    // Pendentes primeiro (ordem alfabética), depois concluídas (ordem alfabética)
    final pending = list.where((t) => !t.completed).toList()
      ..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    final done = list.where((t) => t.completed).toList()
      ..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));

    return [...pending, ...done];
  }

  void addTask(Task task) {
    _tasks.add(task);
  }

  void removeTask(Task task) {
    _tasks.removeWhere((t) => t.id == task.id);
  }

  void toggleCompleted(Task task) {
    task.completed = !task.completed;
  }
}
