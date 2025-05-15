import 'package:flutter/material.dart';

class ProductFormStateManager {
  final formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final descripcionController = TextEditingController();
  final cantidadController = TextEditingController();
  final precioController = TextEditingController();
  final imagenController = TextEditingController();

  final nombreFocus = FocusNode();
  final descripcionFocus = FocusNode();
  final cantidadFocus = FocusNode();
  final precioFocus = FocusNode();
  final imagenFocus = FocusNode();

  String? estadoSeleccionado;

  bool nombreTocado = false;
  bool descripcionTocado = false;
  bool cantidadTocado = false;
  bool precioTocado = false;
  bool imagenTocado = false;

  bool todosCamposTocados() =>
      nombreTocado &&
      descripcionTocado &&
      cantidadTocado &&
      precioTocado &&
      imagenTocado;

  void dispose() {
    nombreController.dispose();
    descripcionController.dispose();
    cantidadController.dispose();
    precioController.dispose();
    imagenController.dispose();

    nombreFocus.dispose();
    descripcionFocus.dispose();
    cantidadFocus.dispose();
    precioFocus.dispose();
    imagenFocus.dispose();
  }
}
