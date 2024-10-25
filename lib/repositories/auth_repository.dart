import 'package:bricklayer/repositories/dtos/user_dto.dart';
import 'package:bricklayer/repositories/models/user_login_model.dart';

import '../services/api_client.dart';
import 'models/user_registration_model.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository({required this.apiClient});

  Future<UserDto?> signUp({required String email, required String password}) async {
    try {
      final response = await apiClient.post(
        '/signup',
        false,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final user = UserRegistrationModel.fromJson(response.data);

        return UserDto(
          userId: user.userId,
          username: user.username,
          accessToken: user.accessToken,
          refreshToken: user.refreshToken,
        );
      } else {
        throw Exception(response.data['error'] ?? 'Signup failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserDto?> login({required String email, required String password}) async {
    try {
      final response = await apiClient.post(
        '/login',
        false,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final user = UserLoginModel.fromJson(response.data);

        return UserDto(
          userId: user.userId,
          username: email,
          accessToken: user.accessToken,
          refreshToken: user.refreshToken,
        );
      } else {
        throw Exception(response.data['error'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }
}
