part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthSubscriptionRequested extends AuthEvent {}

final class AuthLogoutPressed extends AuthEvent {}
