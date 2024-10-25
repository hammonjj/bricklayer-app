class UserDto {
  final String userId;
  final String username;
  final String accessToken;
  final String refreshToken;

  UserDto({
    required this.userId,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  });
}
