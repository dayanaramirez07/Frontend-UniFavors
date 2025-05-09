import 'package:flutter/material.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/screens/login/login_screen.dart';
import 'package:uni_favors/screens/signup/signup_screen.dart';
import 'package:uni_favors/screens/welcome/components/background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni_favors/components/rounded_button.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "BIENVENID@",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: size.height * 0.04),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.04),
            RoundedButton(
              text: "INICIAR SESIÓN",
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
            RoundedButton(
              text: "REGISTRARSE",
              color: kWhiteColor,
              textColor: kPrimaryColor,
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
      ),
    );
  }
}
