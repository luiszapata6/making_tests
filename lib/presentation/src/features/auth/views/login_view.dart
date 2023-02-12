import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/domain.dart';
import '../../../../presentation.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                  controller: emailController,
                  validator: (email) =>
                      email != null && emailRegex.hasMatch(email)
                          ? null
                          : 'Ingresa un correo válido',
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
                  maxLines: 1,
                  controller: passwordController,
                  obscureText: hidden,
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidden
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () => setState(() => hidden = !hidden),
                  ),
                  validator: (password) =>
                      password != null && password.length < 6
                          ? 'Ingresa una contraseña válida'
                          : null,
                  autovalidateMode: AutovalidateMode.disabled,
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
