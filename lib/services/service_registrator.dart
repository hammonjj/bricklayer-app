import 'package:bricklayer/env.dart';
import 'package:bricklayer/repositories/auth_repository.dart';
import 'package:bricklayer/repositories/user_part_repository.dart';
import 'package:bricklayer/repositories/user_repository.dart';
import 'package:bricklayer/repositories/user_set_repository.dart';
import 'package:get_it/get_it.dart';

import 'api_client.dart';
import 'app_settings.dart';

final GetIt getIt = GetIt.instance;

Future<void> registerServices() async {
  getIt.registerSingleton<AppSettings>(await AppSettings.getInstance());
  getIt.registerSingleton<ApiClient>(
      ApiClient(urlBase: Env.apiUrl, environment: Env.environment, appSettings: getIt.get<AppSettings>()));

  getIt.registerSingleton<UserRepository>(UserRepository(appSettings: getIt.get<AppSettings>()));
  getIt.registerSingleton<AuthRepository>(
      AuthRepository(
          apiClient: getIt.get<ApiClient>(),
          userRepository: getIt.get<UserRepository>(),
          appSettings: getIt.get<AppSettings>()),
      dispose: (repo) => repo.dispose());
  getIt.registerSingleton<UserSetRepository>(UserSetRepository(apiClient: getIt.get<ApiClient>()));
  getIt.registerSingleton<UserPartRepository>(UserPartRepository(apiClient: getIt.get<ApiClient>()));
}
