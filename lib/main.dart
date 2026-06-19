import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

// Paleta feminina elegante: plum escuro + rosé + lilás + dourado
class AppColors {
  static const Color background = Color(0xFF1A1025); // roxo escuro profundo
  static const Color card = Color(0xFF2D1F3D);       // plum médio
  static const Color rose = Color(0xFFE8A0BF);       // rosé suave - destaque principal
  static const Color lilac = Color(0xFFC77DFF);      // lilás vibrante - destaque secundário
  static const Color gold = Color(0xFFFFD6A5);       // dourado suave - pendente
  static const Color textLight = Color(0xFFF8F0FF);  // branco levemente lilás
  static const Color surface = Color(0xFF3D2B52);    // superfície mais clara
}

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas Diárias',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.rose,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.textLight),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}