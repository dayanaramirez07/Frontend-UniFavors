import 'package:flutter/material.dart';
import 'package:uni_favors/screens/dashboard_principal/dashboard_screen.dart';
import 'package:uni_favors/services/negocio_service.dart';
import 'package:uni_favors/models/negocio.dart';
import 'package:uni_favors/services/usuario_service.dart';

class BusinessController {
  final NegocioService negocioService = NegocioService();
  final UsuarioService usuarioService = UsuarioService();

  Future<void> handleCrearNegocio({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController nombreController,
    required TextEditingController representanteController,
    required TextEditingController logoController,
    required String? categoriaSeleccionada,
  }) async {
    final form = formKey.currentState;
    if (form == null) return;
    form.save();
    if (!form.validate()) return;

    final usuarioId = await usuarioService.obtenerIdUsuarioDesdeToken();
    if (usuarioId == null) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Necesitas iniciar sesión')));
      return;
    }

    final negocio = Negocio(
      nombre: nombreController.text.trim(),
      representante: representanteController.text.trim(),
      logo: logoController.text.trim(),
      categoria: Negocio.obtenerCategoria(categoriaSeleccionada),
      usuarioId: usuarioId,
    );

    await negocioService.crearNegocio(negocio);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }
}
