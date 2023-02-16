import '../../../../../domain/domain.dart';
import '../../../../../dependencies_injection/injector.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    final loginUseCase = Injector.resolve<LoginUseCase>();
    final signUpUseCase = Injector.resolve<SignUpUseCase>();

    on<SignUp>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        await signUpUseCase.call(event.email, event.password);
        emit(
          state.copyWith(
            formStatus: SubmissionSuccess(),
          ),
        );
      } on InvalidData catch (invalidData) {
        emit(
          state.copyWith(
            formStatus:
                SubmissionFailed(exception: Exception(invalidData.message)),
            errorMessage: invalidData.message,
          ),
        );
      }
    });

    on<Login>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await loginUseCase.call(event.email, event.password);
        emit(
          state.copyWith(
            formStatus: SubmissionSuccess(),
          ),
        );
      } on InvalidData catch (invalidData) {
        emit(
          state.copyWith(
            formStatus:
                SubmissionFailed(exception: Exception(invalidData.message)),
            errorMessage: invalidData.message,
          ),
        );
      }
    });
  }
}
