class AuthDto {
  final String userId;
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
