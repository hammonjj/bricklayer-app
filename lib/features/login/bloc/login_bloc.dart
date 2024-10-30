import 'package:bricklayer/core/forms/password_validator.dart';
import 'package:bricklayer/core/forms/username_validator.dart';
import 'package:bricklayer/repositories/auth_repository.dart';
import 'package:bricklayer/services/app_settings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authenticationRepository,
    required AppSettings appSettings,
  })  : _authenticationRepository = authenticationRepository,
        _appSettings = appSettings,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegistrationSubmitted>(_onRegistrationSubmitted);
  }

  final AppSettings _appSettings;
  final AuthRepository _authenticationRepository;

  void _onUsernameChanged(LoginUsernameChanged event, Emitter<LoginState> emit) {
    final username = UsernameValidator.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([state.password, username]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = PasswordValidator.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.username]),
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isValid) {
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await _authenticationRepository.login(
        email: state.username.value,
        password: state.password.value,
      );

      if (event.rememberMe) {
        await _appSettings.setRememberMe(true);
        await _appSettings.setUsername(state.username.value);
        await _appSettings.setPassword(state.password.value);
      } else {
        await _appSettings.clearRememberMe();
      }

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> _onRegistrationSubmitted(
    RegistrationSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.signUp(
          email: state.username.value,
          password: state.password.value,
        );

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
