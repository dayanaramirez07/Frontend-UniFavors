import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni_favors/components/already_have_un_account_check.dart';
import 'package:uni_favors/components/rounded_button.dart';
import 'package:uni_favors/components/rounded_input_field.dart';
import 'package:uni_favors/components/rounded_password_field.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/screens/login/components/background.dart';
import 'package:uni_favors/screens/login/login_screen.dart';
import 'package:uni_favors/screens/signup/signup_screen.dart';
import 'package:uni_favors/services/usuario_service.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String correo = '';
  String contrasena = '';
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });

    final success = await UsuarioService().login(correo, contrasena);
     // Cambia esto por la lógica de tu API
    setState(() {
      isLoading = false;
    });

    if (success) {
      // Mostrar un mensaje de error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Inicio de sesión exitoso')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen(); // Cambia esto por la pantalla de inicio
          },
        ),
      );
    } else {
      // Mostrar un mensaje de error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Credenciales incorrectas')));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "INICIO DE SESIÓN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: kPrimaryColor,
            ),
          ),
          SizedBox(height: size.height * 0.04),
          SvgPicture.asset(
            "assets/icons/login.svg",
            height: size.height * 0.35,
          ),
          SizedBox(height: size.height * 0.04),
          RoundedInputField(
            hintText: "Usuario o correo institucional",
            icon: Icons.person,
            onChanged: (value) {
              correo = value;
            },
          ),
          RoundedPasswordField(onChanged: (value) {
            contrasena = value;
          }),
          SizedBox(height: size.height * 0.02),
          isLoading
              ? CircularProgressIndicator()
              : RoundedButton(
                  text: "INGRESAR",
                  press: login,
                ),
          SizedBox(height: size.height * 0.04),
          AlreadyHaveUnAccountCheck(
            login: true,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignupScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
