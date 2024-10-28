import 'dart:async';

import 'package:bricklayer/core/enums.dart';
import 'package:bricklayer/core/utils/guid.dart';
import 'package:bricklayer/repositories/dtos/auth_dto.dart';
import 'package:bricklayer/repositories/models/user_login_model.dart';

import '../services/api_client.dart';
import 'models/user_registration_model.dart';

class AuthRepository {
  final ApiClient apiClient;
  final _controller = StreamController<AuthDto?>();

  AuthRepository({required this.apiClient});

  void dispose() => _controller.close();

  Stream<AuthDto?> get status async* {
    yield null;
    yield* _controller.stream;
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      final response = await apiClient.post(
        '/signup',
        false,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final user = UserRegistrationModel.fromJson(response.data);

        final auth = AuthDto(
          userId: Guid.parse(user.userId),
          username: user.username,
          accessToken: user.accessToken,
          refreshToken: user.refreshToken,
        );

        _controller.add(auth);
      } else {
        throw Exception(response.data['error'] ?? 'Signup failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final response = await apiClient.post(
        '/login',
        false,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final user = UserLoginModel.fromJson(response.data);

        final auth = AuthDto(
          userId: Guid.parse(user.userId),
          username: email,
          accessToken: user.accessToken,
          refreshToken: user.refreshToken,
        );

        _controller.add(auth);
      } else {
        throw Exception(response.data['error'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }
}
