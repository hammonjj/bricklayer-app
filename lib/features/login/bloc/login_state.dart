part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const UsernameValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.isValid = true,
  });

  final FormzSubmissionStatus status;
  final UsernameValidator username;
  final PasswordValidator password;
  final bool isValid;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    UsernameValidator? username,
    PasswordValidator? password,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
