import 'package:flutter/material.dart';
import 'package:uni_favors/components/rounded_password_field.dart';
import 'package:uni_favors/components/validators.dart';
import 'package:uni_favors/screens/configuration/components/configuration_state.dart';
import 'package:uni_favors/components/focus_listeners.dart';

class ConfigurationForm extends StatefulWidget {
  final void Function(bool isValid)? onFormUpdated;

  const ConfigurationForm({super.key, this.onFormUpdated});

  @override
  State<ConfigurationForm> createState() => _ConfigurationFormState();
}

class _ConfigurationFormState extends State<ConfigurationForm> {
  final state = ConfigurationStateManager();

  @override
  void initState() {
    super.initState();

    attachFocusListener(
      node: state.contrasennaFocus,
      onFocusLost: () {
        setState(() => state.contrasennaTocado = true);
        validarForm();
      },
    );

    attachFocusListener(
      node: state.confirmacionFocus,
      onFocusLost: () {
        setState(() => state.confirmacionTocado = true);
        validarForm();
      },
    );
  }

  void validarForm() {
    final valido = state.formKey.currentState?.validate() ?? false;
    final todosCamposLlenos =
        state.contrasennaController.text.isNotEmpty &&
        state.confirmacionController.text.isNotEmpty;

    widget.onFormUpdated?.call(valido && todosCamposLlenos);
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
          RoundedPasswordField(
            hintText: "Nueva contraseña",
            controller: state.contrasennaController,
            focusNode: state.contrasennaFocus,
            showPassword: state.mostrarContrasenna,
            togglePasswordVisibility:
                () => setState(
                  () => state.mostrarContrasenna = !state.mostrarContrasenna,
                ),
            validator:
                (val) =>
                    !state.contrasennaTocado ? null : validarContrasenna(val),
          ),
          RoundedPasswordField(
            hintText: "Confirmar contraseña",
            controller: state.confirmacionController,
            focusNode: state.confirmacionFocus,
            showPassword: state.mostrarConfirmacion,
            togglePasswordVisibility:
                () => setState(
                  () => state.mostrarConfirmacion = !state.mostrarConfirmacion,
                ),
            validator:
                (val) =>
                    !state.confirmacionTocado
                        ? null
                        : validarConfirmacion(
                          val,
                          state.contrasennaController.text,
                        ),
          ),
        ],
      ),
    );
  }
}
