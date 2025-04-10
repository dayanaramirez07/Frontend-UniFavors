import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni_favors/components/already_have_un_account_check.dart';
import 'package:uni_favors/components/rounded_button.dart';
import 'package:uni_favors/components/rounded_dropdown.dart';
import 'package:uni_favors/components/rounded_input_field.dart';
import 'package:uni_favors/components/rounded_password_field.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/screens/login/login_screen.dart';
import 'package:uni_favors/screens/signup/components/background.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "REGISTRO",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: kPrimaryColor,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          SvgPicture.asset(
            "assets/icons/signup.svg",
            height: size.height * 0.3,
          ),
          SizedBox(height: size.height * 0.02),
          SizedBox(
            height: size.height * 0.3, // Por ejemplo, el 45% de la pantalla
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RoundedDropdown(
                    hint: "Tipo de usuario",
                    options: ['Vendedor', 'Cliente', 'Compa'],
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    hintText: "Correo institucional (@udea.edu.co)",
                    icon: Icons.email,
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    hintText: "Usuario",
                    icon: Icons.person,
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    hintText: "Celular",
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {},
                  ),
                  RoundedPasswordField(onChanged: (value) {}),
                  RoundedPasswordField(
                    onChanged: (value) {},
                    hintText: "Confirmar contraseña",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          RoundedButton(text: "CREAR CUENTA", press: () {}),
          SizedBox(height: size.height * 0.02),
          AlreadyHaveUnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
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
