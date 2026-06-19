import 'package:flutter/material.dart';
import '../main.dart';
import '../repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _raController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  void _handleRegister() {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      setState(() => _errorMessage = 'Preencha todos os campos.');
      return;
    }
    final success = AppRepository.instance.registerUser(
      AppUser(
        name: _nameController.text.trim(),
        ra: _raController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado! Faça login.')),
      );
    } else {
      setState(() => _errorMessage = 'Este email já está cadastrado.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF2D1040), Color(0xFF1A1025)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: AppColors.rose),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Criar conta',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Comece a organizar suas tarefas',
                    style: TextStyle(color: Colors.white54),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(_nameController, 'Nome completo',
                      Icons.person_outline_rounded),
                  const SizedBox(height: 16),
                  _buildTextField(
                      _raController, 'RA (matrícula)', Icons.badge_outlined),
                  const SizedBox(height: 16),
                  _buildTextField(
                      _emailController, 'Email', Icons.mail_outline_rounded),
                  const SizedBox(height: 16),
                  _buildTextField(
                      _passwordController, 'Senha', Icons.lock_outline_rounded,
                      obscure: true),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 14),
                    Text(_errorMessage!,
                        style: const TextStyle(color: AppColors.rose)),
                  ],
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.lilac, AppColors.rose],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lilac.withValues(alpha: 0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: AppColors.textLight),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.lilac),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: AppColors.lilac.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.lilac, width: 1.5),
        ),
      ),
    );
  }
}