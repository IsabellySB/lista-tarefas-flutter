import 'package:flutter/material.dart';
import '../main.dart';
import '../repository.dart';
import 'task_list_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _displayedMonth =
      DateTime(DateTime.now().year, DateTime.now().month);
  DateTime _selectedDay = DateTime.now();

  void _changeMonth(int offset) {
    setState(() {
      _displayedMonth =
          DateTime(_displayedMonth.year, _displayedMonth.month + offset);
    });
  }

  List<DateTime?> _buildMonthDays() {
    final firstDay =
        DateTime(_displayedMonth.year, _displayedMonth.month, 1);
    final daysInMonth =
        DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0).day;
    final leadingEmpty = firstDay.weekday % 7;
    final List<DateTime?> days =
        List.filled(leadingEmpty, null, growable: true);
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(_displayedMonth.year, _displayedMonth.month, i));
    }
    return days;
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static const _weekDayLabels = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
  static const _monthNames = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];

  @override
  Widget build(BuildContext context) {
    final user = AppRepository.instance.loggedUser;
    final days = _buildMonthDays();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2D1040), AppColors.background],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Olá, ${user?.name ?? 'usuária'}! 🌸',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textLight,
                            ),
                          ),
                          if (user?.ra.isNotEmpty == true)
                            Text('RA: ${user!.ra}',
                                style:
                                    const TextStyle(color: Colors.white54)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.rose, AppColors.lilac],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.rose.withValues(alpha: 0.4),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.calendar_month,
                          color: Colors.white, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Cabeçalho do mês
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                        color: AppColors.rose.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => _changeMonth(-1),
                        icon: const Icon(Icons.chevron_left,
                            color: AppColors.rose),
                      ),
                      Text(
                        '${_monthNames[_displayedMonth.month - 1]} ${_displayedMonth.year}',
                        style: const TextStyle(
                          color: AppColors.textLight,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _changeMonth(1),
                        icon: const Icon(Icons.chevron_right,
                            color: AppColors.rose),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: _weekDayLabels
                      .map((d) => Expanded(
                            child: Center(
                              child: Text(d,
                                  style: const TextStyle(
                                    color: AppColors.lilac,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  )),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: GridView.builder(
                    itemCount: days.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      final day = days[index];
                      if (day == null) return const SizedBox.shrink();
                      final isSelected = _isSameDay(day, _selectedDay);
                      final isToday = _isSameDay(day, DateTime.now());
                      final hasTasks = AppRepository.instance
                          .tasksForDate(day)
                          .isNotEmpty;

                      return GestureDetector(
                        onTap: () => setState(() => _selectedDay = day),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    colors: [AppColors.rose, AppColors.lilac],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: isSelected
                                ? null
                                : (isToday
                                    ? AppColors.surface
                                    : Colors.transparent),
                            borderRadius: BorderRadius.circular(12),
                            border: isToday && !isSelected
                                ? Border.all(
                                    color: AppColors.rose, width: 1.4)
                                : null,
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.rose
                                          .withValues(alpha: 0.4),
                                      blurRadius: 8,
                                    )
                                  ]
                                : null,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                '${day.day}',
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textLight,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 13,
                                ),
                              ),
                              if (hasTasks && !isSelected)
                                const Positioned(
                                  bottom: 4,
                                  child: CircleAvatar(
                                    radius: 2.5,
                                    backgroundColor: AppColors.gold,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.rose, AppColors.lilac],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.rose.withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              TaskListScreen(date: _selectedDay),
                        ),
                      ).then((_) => setState(() {}));
                    },
                    icon: const Icon(Icons.list_alt_rounded,
                        color: Colors.white),
                    label: const Text(
                      'Ver tarefas do dia',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}