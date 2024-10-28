import 'package:bricklayer/repositories/auth_repository.dart';
import 'package:bricklayer/repositories/dtos/auth_dto.dart';
import 'package:bricklayer/repositories/dtos/user_dto.dart';
import 'package:bricklayer/services/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'auth_state.dart';

class AuthNotifier extends ChangeNotifier {
  final AppSettings appSettings;
  final AuthRepository authRepository;

  AuthState _state = const AuthState.initial();
  AuthState get state => _state;

  AuthNotifier({required this.authRepository, required this.appSettings});

  Future<void> signUp(String email, String password) async {
    _state = const AuthState.loading();
    notifyListeners();

    try {
      final authUser =
          await authRepository.signUp(email: email, password: password);
      if (authUser != null) {
        await _storeUserCredentials(authUser);
        _state = AuthState.success(user: authUser);
      } else {
        _state = const AuthState.failure(error: 'Signup failed');
      }
    } catch (e) {
      _state = AuthState.failure(error: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _state = const AuthState.loading();
    notifyListeners();

    try {
      final user = await authRepository.login(email: email, password: password);
      if (user != null) {
        await _storeUserCredentials(user);
        _state = AuthState.success(user: user);
      } else {
        _state = const AuthState.failure(error: 'Login failed');
      }
    } catch (e) {
      _state = AuthState.failure(error: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> _storeUserCredentials(AuthDto user) async {
    await appSettings.setToken(user.accessToken);
    await appSettings.setRefreshToken(user.refreshToken);
  }
}
