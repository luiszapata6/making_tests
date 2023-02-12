import 'package:flutter/material.dart';
import '../../../../presentation.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  bool login = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: login ? size.height * 0.14 : size.height * 0.07,
                ),
                Visibility(
                  visible: login,
                  child: const TextPoppins(
                    text: 'TESTING APP',
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                    color: purple,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.055,
                ),
                TextPoppins(
                  text: login ? 'Ingresa a tu cuenta' : 'Regístrate',
                  fontSize: 22,
                  color: purple,
                ),
                SizedBox(
                  height: size.height * 0.055,
                ),
                Visibility(visible: login, child: const LoginView()),
                Visibility(visible: !login, child: const SignUpView()),
                const Align(
                  alignment: Alignment.center,
                  child: TextPoppins(
                    text: 'o',
                    fontSize: 22,
                    color: white,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                LargeButton(
                  text: login ? 'Regístrate' : 'Inicia sesión',
                  onPressed: () => setState(() => login = !login),
                  color: white,
                  textColor: purple,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
