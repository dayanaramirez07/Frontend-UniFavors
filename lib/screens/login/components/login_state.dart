import 'package:flutter/material.dart';

class LoginFormStateManager {
  final formKey = GlobalKey<FormState>();

  final usuarioController = TextEditingController();
  final contrasennaController = TextEditingController();

  bool mostrarContrasenna = false;

  void dispose() {
    usuarioController.dispose();
    contrasennaController.dispose();
  }
}
