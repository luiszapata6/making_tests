import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/domain.dart';
import '../../../../presentation.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Form(
          key: _loginFormKey,
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextPoppins(
                  text: 'Correo electrónico',
                  fontSize: 18,
                  color: white,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextFormFieldWidget(
                  key: const Key('emailTextField'),
                  controller: emailController,
                  validator: (email) =>
                      isValidEmail(email!) ? null : 'Ingresa un correo válido',
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                const TextPoppins(
                  text: 'Contraseña',
                  fontSize: 18,
                  color: white,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextFormFieldWidget(
                  key: const Key('passwordTextField'),
                  maxLines: 1,
                  controller: passwordController,
                  obscureText: hidden,
                  suffixIcon: IconButton(
                    key: const Key('hidePasswordButton'),
                    icon: Icon(
                      hidden
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () => setState(() => hidden = !hidden),
                  ),
                  validator: (password) => !isValidPassword(password!)
                      ? 'Ingresa una contraseña válida'
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.formStatus is SubmissionFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: TextPoppins(text: state.errorMessage),
                          backgroundColor: Colors.red));
                    }
                  },
                  builder: (context, state) {
                    if (state.formStatus is FormSubmitting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return LargeButton(
                        key: const Key('loginButton'),
                        text: 'Inicia sesión',
                        onPressed: () async {
                          if (!_loginFormKey.currentState!.validate()) return;
                          authBloc.add(Login(
                              emailController.text, passwordController.text));
                        },
                      );
                    }
                  },
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
