import 'package:flutter/material.dart';

class ConfigurationStateManager {
  final formKey = GlobalKey<FormState>();

  final tipoUsuarioController = TextEditingController();
  final correoController = TextEditingController();
  final usuarioController = TextEditingController();
  final celularController = TextEditingController();
  final contrasennaController = TextEditingController();
  final confirmacionController = TextEditingController();

  final celularFocus = FocusNode();
  final contrasennaFocus = FocusNode();
  final confirmacionFocus = FocusNode();

  bool mostrarContrasenna = false;
  bool mostrarConfirmacion = false;

  bool celularTocado = false;
  bool contrasennaTocado = false;
  bool confirmacionTocado = false;

  bool todosCamposTocados() =>
      celularTocado && contrasennaTocado && confirmacionTocado;

  void dispose() {
    tipoUsuarioController.dispose();
    correoController.dispose();
    usuarioController.dispose();
    celularController.dispose();
    contrasennaController.dispose();
    confirmacionController.dispose();

    celularFocus.dispose();
    contrasennaFocus.dispose();
    confirmacionFocus.dispose();
  }
}
