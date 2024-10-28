import 'package:bricklayer/core/utils/guid.dart';

class UserDto {
  final Guid userId;
  final String username;

  UserDto({required this.userId, required this.username});
}
