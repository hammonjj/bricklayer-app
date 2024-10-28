import 'package:bricklayer/repositories/dtos/user_dto.dart';
import 'package:bricklayer/services/app_settings.dart';

class UserRepository {
  final AppSettings _appSettings;

  UserRepository({required AppSettings appSettings}) : _appSettings = appSettings;

  UserDto? getCurrentUser() {
    final username = _appSettings.getUsername();
    if (username == null) {
      return null;
    }

    final id = _appSettings.getUserId();

    return UserDto(id: id, username: username);
  }

  Future<void> setCurrentUser(UserDto? user) async {
    if (user == null) {
      await _appSettings.setUsername(null);
      return;
    }

    await _appSettings.setUsername(user.username);
    await _appSettings.setUserId(user.id);
  }
}
