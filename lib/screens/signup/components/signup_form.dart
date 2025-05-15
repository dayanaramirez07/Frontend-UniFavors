import 'package:flutter/material.dart';
import 'package:uni_favors/components/rounded_input_field.dart';
import 'package:uni_favors/components/rounded_password_field.dart';
import 'package:uni_favors/components/rounded_dropdown.dart';
import 'package:uni_favors/components/validators.dart';
import 'package:uni_favors/screens/signup/components/signup_state.dart';
import 'package:uni_favors/components/focus_listeners.dart';

class SignupForm extends StatefulWidget {
  final SignupFormStateManager state;
  final void Function(bool isValid)? onFormUpdated;

  const SignupForm({super.key, required this.state, this.onFormUpdated});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  SignupFormStateManager get state => widget.state;

  @override
  void initState() {
    super.initState();

    attachFocusListener(
      node: state.correoFocus,
      onFocusLost: () {
        setState(() => state.correoTocado = true);
        validarForm();
      },
    );

    attachFocusListener(
      node: state.usuarioFocus,
      onFocusLost: () {
        setState(() => state.usuarioTocado = true);
        validarForm();
      },
    );

    attachFocusListener(
      node: state.celularFocus,
      onFocusLost: () {
        setState(() => state.celularTocado = true);
        validarForm();
      },
    );

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
        state.correoController.text.isNotEmpty &&
        state.usuarioController.text.isNotEmpty &&
        state.celularController.text.isNotEmpty &&
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
          RoundedDropdown(
            hint: "Tipo de usuario",
            options: ['Vendedor', 'Cliente', 'Compa'],
            icon: Icons.person,
            onChanged: (value) {
              setState(() {
                state.tipoUsuarioSeleccionado = value;
              });
              validarForm();
            },
          ),
          RoundedInputField(
            hintText: "Correo institucional (@udea.edu.co)",
            icon: Icons.email,
            controller: state.correoController,
            focusNode: state.correoFocus,
            validator: (val) => !state.correoTocado ? null : validarCorreo(val),
          ),
          RoundedInputField(
            hintText: "Usuario",
            icon: Icons.person,
            controller: state.usuarioController,
            focusNode: state.usuarioFocus,
            validator: (val) => !state.usuarioTocado ? null : validarCampo(val),
          ),
          RoundedInputField(
            hintText: "Celular",
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            controller: state.celularController,
            focusNode: state.celularFocus,
            validator: (val) => !state.celularTocado ? null : validarCampo(val),
          ),
          RoundedPasswordField(
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
