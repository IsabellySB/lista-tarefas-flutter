import 'package:flutter/material.dart';
import '../main.dart';
import '../models/task.dart';
import '../repository.dart';
import '../widgets/add_task_dialog.dart';

class TaskListScreen extends StatefulWidget {
  final DateTime date;
  const TaskListScreen({super.key, required this.date});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  static const _monthNames = [
    'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
    'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'
  ];

  void _addTask(String title) {
    setState(() {
      AppRepository.instance.addTask(Task(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title,
        date: widget.date,
      ));
    });
  }

  void _toggleTask(Task task) {
    setState(() => AppRepository.instance.toggleCompleted(task));
  }

  void _removeTask(Task task) {
    setState(() => AppRepository.instance.removeTask(task));
  }

  @override
  Widget build(BuildContext context) {
    final tasks = AppRepository.instance.tasksForDate(widget.date);
    final dateLabel =
        '${widget.date.day} de ${_monthNames[widget.date.month - 1]} de ${widget.date.year}';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.rose),
        title: Text(
          dateLabel,
          style: const TextStyle(
            color: AppColors.textLight,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.rose, AppColors.lilac],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.rose.withValues(alpha: 0.5),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AddTaskDialog(onAdd: _addTask),
            );
          },
          child: const Icon(Icons.add_rounded, color: Colors.white),
        ),
      ),
      body: tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_note_rounded,
                      size: 64,
                      color: AppColors.rose.withValues(alpha: 0.3)),
                  const SizedBox(height: 12),
                  const Text(
                    'Nenhuma tarefa ainda',
                    style: TextStyle(color: Colors.white54),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Toque no + para adicionar',
                    style:
                        TextStyle(color: Colors.white24, fontSize: 12),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Dismissible(
                  key: Key(task.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.lilac, AppColors.rose],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.delete_outline_rounded,
                        color: Colors.white),
                  ),
                  onDismissed: (_) => _removeTask(task),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: task.completed
                            ? AppColors.rose.withValues(alpha: 0.3)
                            : AppColors.gold.withValues(alpha: 0.4),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: GestureDetector(
                        onTap: () => _toggleTask(task),
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: task.completed
                                ? const LinearGradient(
                                    colors: [
                                      AppColors.rose,
                                      AppColors.lilac
                                    ],
                                  )
                                : null,
                            border: task.completed
                                ? null
                                : Border.all(
                                    color: AppColors.gold, width: 2),
                          ),
                          child: task.completed
                              ? const Icon(Icons.check_rounded,
                                  color: Colors.white, size: 16)
                              : null,
                        ),
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          color: task.completed
                              ? Colors.white38
                              : AppColors.textLight,
                          decoration: task.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close_rounded,
                            color: Colors.white24, size: 20),
                        onPressed: () => _removeTask(task),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}