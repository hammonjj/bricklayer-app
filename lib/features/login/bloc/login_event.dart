part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

final class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class LoginSubmitted extends LoginEvent {
  final bool rememberMe;

  const LoginSubmitted({required this.rememberMe});

  @override
  List<Object> get props => [rememberMe];
}

class RegistrationSubmitted extends LoginEvent {
  const RegistrationSubmitted();
}
