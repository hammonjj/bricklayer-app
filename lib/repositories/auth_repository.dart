import 'dart:async';

import 'package:bricklayer/core/enums.dart';
import 'package:bricklayer/core/utils/guid.dart';
import 'package:bricklayer/repositories/dtos/user_dto.dart';
import 'package:bricklayer/repositories/models/user_login_model.dart';
import 'package:bricklayer/repositories/user_repository.dart';
import 'package:bricklayer/services/app_settings.dart';

import '../services/api_client.dart';
import 'models/user_registration_model.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final UserRepository _userRepository;
  final AppSettings _appSettings;
  final _controller = StreamController<AuthenticationStatus>();

  AuthRepository(
      {required ApiClient apiClient, required UserRepository userRepository, required AppSettings appSettings})
      : _apiClient = apiClient,
        _userRepository = userRepository,
        _appSettings = appSettings;

  void dispose() => _controller.close();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      final response = await _apiClient.post(
        '/signup',
        false,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final user = UserRegistrationModel.fromJson(response.data);

        _setTokens(user.accessToken, user.refreshToken);
        _userRepository.setCurrentUser(UserDto(id: Guid.parse(user.userId), username: user.username));

        _controller.add(AuthenticationStatus.authenticated);
      } else {
        throw Exception(response.data['error'] ?? 'Signup failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final response = await _apiClient.post(
        '/login',
        false,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final user = UserLoginModel.fromJson(response.data);

        await _setTokens(user.accessToken, user.refreshToken);
        await _userRepository.setCurrentUser(UserDto(id: Guid.parse(user.userId), username: user.username));
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        throw Exception(response.data['error'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _setTokens(String token, String refreshToken) async {
    await _appSettings.setToken(token);
    await _appSettings.setRefreshToken(refreshToken);
  }
}
