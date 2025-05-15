import 'package:flutter/material.dart';
import 'package:uni_favors/components/rounded_input_field.dart';
import 'package:uni_favors/components/validators.dart';
import 'package:uni_favors/screens/configuration/components/configuration_state.dart';
import 'package:uni_favors/components/focus_listeners.dart';
import 'package:uni_favors/services/usuario_service.dart';

class Information extends StatefulWidget {
  final void Function(bool isValid)? onFormUpdated;

  const Information({super.key, this.onFormUpdated});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final state = ConfigurationStateManager();

  @override
  void initState() {
    super.initState();

    attachFocusListener(
      node: state.celularFocus,
      onFocusLost: () {
        setState(() => state.celularTocado = true);
        validarForm();
      },
    );

    cargarUsuarioActual();
  }

  void validarForm() {
    final valido = state.formKey.currentState?.validate() ?? false;
    final todosCamposLlenos = state.celularController.text.isNotEmpty;

    widget.onFormUpdated?.call(valido && todosCamposLlenos);
  }

  Future<void> cargarUsuarioActual() async {
    final id = await UsuarioService().obtenerIdUsuarioDesdeToken();
    if (id == null) {
      return;
    }

    try {
      final usuario = await UsuarioService().consultarUsuarioPorId(id);

      state.tipoUsuarioController.text = usuario.tipoNombre;
      state.correoController.text = usuario.correo;
      state.usuarioController.text = usuario.nombreUsuario;
      state.celularController.text = usuario.celular;

      validarForm();

      setState(() {});
    } catch (e) {
      print('Error cargando usuario: $e');
    }
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Column(
        children: [
          RoundedInputField(
            hintText: "Tipo de usuario",
            icon: Icons.badge,
            controller: state.tipoUsuarioController,
            enabled: false,
          ),
          RoundedInputField(
            hintText: "Correo institucional (@udea.edu.co)",
            icon: Icons.email,
            controller: state.correoController,
            enabled: false,
          ),
          RoundedInputField(
            hintText: "Nombre",
            icon: Icons.person,
            controller: state.usuarioController,
            enabled: false,
          ),
          RoundedInputField(
            hintText: "Celular",
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            controller: state.celularController,
            focusNode: state.celularFocus,
            validator: (val) => !state.celularTocado ? null : validarCampo(val),
          ),
        ],
      ),
    );
  }
}
