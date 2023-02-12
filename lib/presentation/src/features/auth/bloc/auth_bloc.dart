import '../../../../../domain/domain.dart';
import '../../../../../dependencies_injection/locator.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    final loginUseCase = locator<LoginUseCase>();
    final signUpUseCase = locator<SignUpUseCase>();
    final logOutUseCase = locator<LogoutUseCase>();

    on<SignUp>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      final newUser = await signUpUseCase.call(event.email, event.password);
      newUser.fold(
        (error) => emit(
          state.copyWith(
            formStatus: SubmissionFailed(exception: Exception(error.message)),
          ),
        ),
        (user) => emit(
          state.copyWith(
            formStatus: SubmissionSuccess(),
          ),
        ),
      );
    });

    on<Login>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      final loggedUser = await loginUseCase.call(event.email, event.password);
      loggedUser.fold(
        (error) => emit(
          state.copyWith(
            formStatus: SubmissionFailed(exception: Exception(error.message)),
          ),
        ),
        (user) => emit(
          state.copyWith(
            formStatus: SubmissionSuccess(),
          ),
        ),
      );
    });

    on<Logout>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      final loggedOut = await logOutUseCase.call();
      loggedOut.fold(
        (error) => emit(
          state.copyWith(
            formStatus: SubmissionFailed(exception: Exception(error.message)),
          ),
        ),
        (user) => emit(
          state.copyWith(
            formStatus: SubmissionSuccess(),
          ),
        ),
      );
    });
  }
}
