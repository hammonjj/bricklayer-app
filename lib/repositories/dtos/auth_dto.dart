import 'package:bricklayer/core/enums.dart';
import 'package:bricklayer/core/utils/guid.dart';

class AuthDto {
  final Guid? userId;
  final String? username;
  final String? accessToken;
  final String? refreshToken;
  final AuthenticationStatus status;

  AuthDto.unauthenticated()
      : userId = null,
        username = null,
        accessToken = null,
        refreshToken = null,
        status = AuthenticationStatus.unauthenticated;

  AuthDto({
    required this.userId,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.status,
  });
}
