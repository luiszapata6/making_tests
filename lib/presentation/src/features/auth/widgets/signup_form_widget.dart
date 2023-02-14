import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/domain.dart';
import '../../../../presentation.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _signFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Form(
          key: _signFormKey,
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
                  obscureText: true,
                  validator: (password) =>
                      password != null && password.length < 6
                          ? 'Ingresa una contraseña válida'
                          : null,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const TextPoppins(
                  text: 'Confirma tu contraseña',
                  fontSize: 18,
                  color: white,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextFormFieldWidget(
                  maxLines: 1,
                  controller: confirmPasswordController,
                  obscureText: true,
                  validator: (password) =>
                      password != null && password.length < 6
                          ? 'Ingresa una contraseña válida'
                          : password != passwordController.text
                              ? 'Ambas contraseñas deben coincidir'
                              : null,
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
                        text: 'Regístrate',
                        onPressed: () {
                          if (!_signFormKey.currentState!.validate()) return;
                          authBloc.add(SignUp(
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
    confirmPasswordController.dispose();
    super.dispose();
  }
}
