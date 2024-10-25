import 'package:bricklayer/features/auth/login_screen.dart';
import 'package:bricklayer/features/auth/registration_screen.dart';
import 'package:bricklayer/features/home/screens/home_screen.dart';
import 'package:bricklayer/features/settings/screens/settings_landing_screen.dart';
import 'package:bricklayer/providers/theme_provider.dart';
import 'package:bricklayer/services/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';

class Bricklayer extends StatefulWidget {
  const Bricklayer({super.key});

  @override
  BricklayerState createState() => BricklayerState();
}

class BricklayerState extends State<Bricklayer> {
  late GoRouter _router;
  final appSettings = GetIt.instance.get<AppSettings>();

  @override
  void initState() {
    super.initState();
    _initializeRouter();
  }

  void _initializeRouter() {
    final initialRoute = appSettings.getUsername() != null ? '/login' : '/registration';

    _router = GoRouter(
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/registration',
          builder: (context, state) => const RegistrationScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsLandingScreen(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      routerConfig: _router,
      title: 'BrickLayer',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
    );
  }
}
