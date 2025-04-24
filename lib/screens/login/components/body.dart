import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni_favors/components/already_have_un_account_check.dart';
import 'package:uni_favors/components/rounded_button.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/screens/login/components/background.dart';
import 'package:uni_favors/screens/login/components/login_form.dart';
import 'package:uni_favors/screens/signup/signup_screen.dart';
import 'package:uni_favors/screens/login/components/login_state.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final state = LoginFormStateManager();

  @override
  void dispose() {
    state.dispose();
    super.dispose();
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
          LoginForm(),
          SizedBox(height: size.height * 0.02),
          RoundedButton(
            text: "INGRESAR",
            press: () {
              // Lógica
            },
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
