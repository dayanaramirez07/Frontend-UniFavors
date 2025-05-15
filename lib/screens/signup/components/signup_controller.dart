import 'package:flutter/material.dart';
import 'package:uni_favors/services/usuario_service.dart';
import 'package:uni_favors/models/usuario.dart';
import 'package:uni_favors/screens/dashboard_principal/dashboard_screen.dart';

class SignupController {
  final UsuarioService usuarioService = UsuarioService();

  Future<void> handleCrearUsuario({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController correoController,
    required TextEditingController usuarioController,
    required TextEditingController celularController,
    required TextEditingController contrasenaController,
    required String? tipoUsuarioSeleccionado,
  }) async {
    formKey.currentState!.save();
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    final usuario = Usuario(
      correo: correoController.text.trim(),
      nombreUsuario: usuarioController.text.trim(),
      celular: celularController.text.trim(),
      contrasenna: contrasenaController.text.trim(),
      tipoUsuario: Usuario.obtenerTipoUsuario(tipoUsuarioSeleccionado),
    );

    await usuarioService.crearUsuario(usuario);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }
}
