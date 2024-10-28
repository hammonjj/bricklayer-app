import 'package:bricklayer/core/enums.dart';
import 'package:bricklayer/repositories/auth_repository.dart';
import 'package:bricklayer/repositories/dtos/user_dto.dart';
import 'package:bricklayer/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthBloc({required AuthRepository authRepository, required userRepository})
      : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.unauthenticated()) {
    on<AuthSubscriptionRequested>(_onSubscriptionRequested);
  }

  Future<void> _onSubscriptionRequested(AuthSubscriptionRequested event, Emitter<AuthState> emit) {
    return emit.onEach(
      _authRepository.status,
      onData: (status) async {
        switch (status) {
          case AuthenticationStatus.unauthenticated:
            return emit(const AuthState.unauthenticated());
          case AuthenticationStatus.authenticated:
            return emit(AuthState.authenticated(_userRepository.getCurrentUser()!));
          case AuthenticationStatus.unknown:
            return emit(const AuthState.unknown());
          case AuthenticationStatus.authenticationFailed:
            return emit(const AuthState.authenticationFailed());
        }
      },
      onError: addError,
    );
  }
}
