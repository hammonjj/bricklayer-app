part of 'auth_bloc.dart';

class AuthState {
  final UserDto? userDto;
  final AuthenticationStatus status;

  const AuthState._({
    this.userDto,
    this.status = AuthenticationStatus.unknown,
  });

  const AuthState.unknown() : this._();
  const AuthState.authenticated(UserDto userDto) : this._(userDto: userDto, status: AuthenticationStatus.authenticated);
  const AuthState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);
  const AuthState.authenticationFailed() : this._(status: AuthenticationStatus.authenticationFailed);
}
