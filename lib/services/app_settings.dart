import 'package:bricklayer/blocs/view_mode_cubit.dart';
import 'package:bricklayer/core/utils/guid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static const _serverUrlKey = 'serverUrl';

  static const _tokenKey = 'auth.token';
  static const _tokenRefreshKey = 'auth.refreshToken';
  static const _tokenExpirationKey = 'auth.tokenExpiration';

  static const _userIdKey = 'user.id';
  static const _usernameKey = 'user.username';
  static const _passwordKey = 'user.password';
  static const _rememberMeKey = 'user.rememberMe';

  static const _viewModeKey = 'viewMode';

  final SharedPreferencesWithCache _prefs;

  AppSettings._internal(this._prefs);

  static Future<AppSettings> getInstance() async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: null,
    ));

    final appSettings = AppSettings._internal(prefs);
    return appSettings;
  }

  Future<void> setUrlBase(String url) async {
    await _prefs.setString(_serverUrlKey, url);
  }

  String? getUrlBase() {
    return _prefs.getString(_serverUrlKey);
  }

  Future<void> setUsername(String? username) async {
    if (username == null) {
      await _prefs.remove(_usernameKey);
      return;
    }

    await _prefs.setString(_usernameKey, username);
  }

  Future<void> setUserId(Guid userId) async {
    await _prefs.setString(_userIdKey, userId.toString());
  }

  Guid getUserId() {
    return Guid.parse(_prefs.getString(_userIdKey)!);
  }

  String? getUsername() {
    return _prefs.getString(_usernameKey);
  }

  Future<void> setPassword(String password) async {
    await _prefs.setString(_passwordKey, password);
  }

  String? getPassword() {
    return _prefs.getString(_passwordKey);
  }

  Future<void> setToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<void> setRefreshToken(String token) async {
    await _prefs.setString(_tokenRefreshKey, token);
  }

  String? getRefreshToken() {
    return _prefs.getString(_tokenRefreshKey);
  }

  Future<void> setTokenExpiration(DateTime expiration) async {
    await _prefs.setInt(_tokenExpirationKey, expiration.millisecondsSinceEpoch);
  }

  DateTime? getTokenExpiration() {
    int? expiration = _prefs.getInt(_tokenExpirationKey);
    return expiration != null ? DateTime.fromMillisecondsSinceEpoch(expiration) : null;
  }

  Future<void> setRememberMe(bool value) async {
    await _prefs.setBool(_rememberMeKey, value);
  }

  bool getRememberMe() {
    return _prefs.getBool(_rememberMeKey) ?? false;
  }

  Future<void> clearRememberMe() async {
    await _prefs.remove(_rememberMeKey);
  }

  ViewMode getViewMode() {
    return _prefs.getString(_viewModeKey) == 'grid' ? ViewMode.grid : ViewMode.list;
  }

  Future<void> setViewMode(ViewMode mode) async {
    await _prefs.setString(_viewModeKey, mode == ViewMode.list ? 'list' : 'grid');
  }
}
