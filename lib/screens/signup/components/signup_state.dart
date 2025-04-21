import 'package:flutter/material.dart';

class SignupFormStateManager {
  final formKey = GlobalKey<FormState>();

  final correoController = TextEditingController();
  final usuarioController = TextEditingController();
  final celularController = TextEditingController();
  final contrasennaController = TextEditingController();
  final confirmacionController = TextEditingController();

  final correoFocus = FocusNode();
  final usuarioFocus = FocusNode();
  final celularFocus = FocusNode();
  final contrasennaFocus = FocusNode();
  final confirmacionFocus = FocusNode();

  String? tipoUsuarioSeleccionado;

  bool mostrarContrasenna = false;
  bool mostrarConfirmacion = false;

  bool correoTocado = false;
  bool usuarioTocado = false;
  bool celularTocado = false;
  bool contrasennaTocado = false;
  bool confirmacionTocado = false;

  bool todosCamposTocados() =>
      correoTocado &&
      usuarioTocado &&
      celularTocado &&
      contrasennaTocado &&
      confirmacionTocado;

  void dispose() {
    correoController.dispose();
    usuarioController.dispose();
    celularController.dispose();
    contrasennaController.dispose();
    confirmacionController.dispose();

    correoFocus.dispose();
    usuarioFocus.dispose();
    celularFocus.dispose();
    contrasennaFocus.dispose();
    confirmacionFocus.dispose();
  }
}
