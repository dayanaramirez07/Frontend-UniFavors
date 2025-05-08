import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/components/rounded_button.dart';
import 'package:uni_favors/components/already_have_un_account_check.dart';
import 'package:uni_favors/screens/login/login_screen.dart';
import 'package:uni_favors/screens/signup/components/background.dart';
import 'package:uni_favors/screens/signup/components/signup_form.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isFormValido = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Background(
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
                      height: size.height * 0.3,
                      child: SingleChildScrollView(
                        child: SignupForm(
                          onFormUpdated: (valido) {
                            setState(() => isFormValido = valido);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    RoundedButton(
                      text: "CREAR CUENTA",
                      press: isFormValido ? () => print("Submit") : null,
                      color: isFormValido ? kPrimaryColor : Colors.grey,
                      border: isFormValido ? kPrimaryColor : Colors.grey,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: size.height * 0.02),
                    AlreadyHaveUnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
