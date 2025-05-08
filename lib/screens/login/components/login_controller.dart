import 'package:flutter/material.dart';
import 'package:uni_favors/services/usuario_service.dart';
import 'package:uni_favors/screens/dashboard_principal/dashboard_screen.dart';

class LoginController {
  final UsuarioService usuarioService = UsuarioService();

  Future<void> handleLogin({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController usuarioController,
    required TextEditingController contrasenaController,
  }) async {
    if (!formKey.currentState!.validate()) return;

    final usuario = usuarioController.text.trim();
    final contrasena = contrasenaController.text.trim();

    final success = await usuarioService.login(usuario, contrasena);

    if (!context.mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Credenciales incorrectas')));
    }
  }
}
