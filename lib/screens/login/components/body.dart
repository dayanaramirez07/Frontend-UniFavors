import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni_favors/components/already_have_un_account_check.dart';
import 'package:uni_favors/components/rounded_button.dart';
import 'package:uni_favors/components/rounded_input_field.dart';
import 'package:uni_favors/components/rounded_password_field.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/screens/login/components/background.dart';
import 'package:uni_favors/screens/signup/signup_screen.dart';

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
            onChanged: (value) {},
          ),
          RoundedPasswordField(onChanged: (value) {}),
          SizedBox(height: size.height * 0.02),
          RoundedButton(text: "INGRESAR", press: () {}),
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
