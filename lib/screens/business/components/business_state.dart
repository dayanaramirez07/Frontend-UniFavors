import 'package:flutter/material.dart';

class BusinessFormStateManager {
  final formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final representanteController = TextEditingController();
  final logoController = TextEditingController();

  final nombreFocus = FocusNode();
  final representanteFocus = FocusNode();
  final logoFocus = FocusNode();

  String? categoriaSeleccionada;

  bool nombreTocado = false;
  bool representanteTocado = false;
  bool logoTocado = false;

  bool todosCamposTocados() =>
      nombreTocado && representanteTocado && logoTocado;

  void dispose() {
    nombreController.dispose();
    representanteController.dispose();
    logoController.dispose();

    nombreFocus.dispose();
    representanteFocus.dispose();
    logoFocus.dispose();
  }
}
