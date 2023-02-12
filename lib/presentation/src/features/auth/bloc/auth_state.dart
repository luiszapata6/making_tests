part of 'auth_bloc.dart';

@immutable
class AuthState {
  const AuthState({
    this.email = '',
    this.password = '',
    this.logged = false,
    this.formStatus = const InitialFormStatus(),
  });

  final String email;
  final String password;
  final bool logged;
  final FormSubmissionStatus formStatus;

  AuthState copyWith({
    String? email,
    String? password,
    bool? logged,
    FormSubmissionStatus? formStatus,
  }) =>
      AuthState(
          email: email ?? this.email,
          password: password ?? this.password,
          logged: logged ?? this.logged,
          formStatus: formStatus ?? this.formStatus);

  AuthState initialState() => const AuthState(
        email: '',
        password: '',
        logged: false,
        formStatus: InitialFormStatus(),
      );
}
