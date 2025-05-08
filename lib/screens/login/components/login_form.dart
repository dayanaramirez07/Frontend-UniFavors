import 'package:flutter/material.dart';
import 'package:uni_favors/components/rounded_input_field.dart';
import 'package:uni_favors/components/rounded_password_field.dart';
import 'package:uni_favors/screens/login/components/login_state.dart';

class LoginForm extends StatefulWidget {
  final LoginFormStateManager state;
  const LoginForm({super.key, required this.state});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginFormStateManager get state => widget.state;

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
            hintText: "Usuario o correo institucional",
            icon: Icons.person,
            controller: state.usuarioController,
          ),
          RoundedPasswordField(
            controller: state.contrasennaController,
            showPassword: state.mostrarContrasenna,
            togglePasswordVisibility: () {
              setState(() {
                state.mostrarContrasenna = !state.mostrarContrasenna;
              });
            },
          ),
        ],
      ),
    );
  }
}
