import 'package:bricklayer/bricklayer.dart';
import 'package:bricklayer/providers/auth/auth_notifier.dart';
import 'package:bricklayer/providers/theme_provider.dart';
import 'package:bricklayer/repositories/auth_repository.dart';
import 'package:bricklayer/services/app_settings.dart';
import 'package:bricklayer/services/service_registrator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerServices();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthNotifier(
                authRepository: GetIt.instance.get<AuthRepository>(), appSettings: GetIt.instance.get<AppSettings>())),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const Bricklayer(),
    ),
  );
}
