import 'package:bricklayer/core/utils/guid.dart';

class AuthDto {
  final Guid userId;
  final String username;
  final String accessToken;
  final String refreshToken;

  AuthDto({
    required this.userId,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  });
}
