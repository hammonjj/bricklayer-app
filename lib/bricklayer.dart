import 'package:bricklayer/blocs/auth/auth_bloc.dart';
import 'package:bricklayer/core/enums.dart';
import 'package:bricklayer/features/home/bloc/home_bloc.dart';
import 'package:bricklayer/features/home/screens/home_screen.dart';
import 'package:bricklayer/features/login/auth_screen.dart';
import 'package:bricklayer/features/login/bloc/login_bloc.dart';
import 'package:bricklayer/features/settings/screens/settings_landing_screen.dart';
import 'package:bricklayer/features/splash/splash_screen.dart';
import 'package:bricklayer/repositories/auth_repository.dart';
import 'package:bricklayer/repositories/user_repository.dart';
import 'package:bricklayer/repositories/user_set_repository.dart';
import 'package:bricklayer/services/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

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
    _initializeRouter();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initializeRouter() {
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const BrickLayerView(),
        ),
        GoRoute(
          path: '/auth',
          builder: (context, state) {
            return BlocProvider(
              create: (_) => LoginBloc(
                authenticationRepository: GetIt.instance.get<AuthRepository>(),
              ),
              child: const AuthScreen(),
            );
          },
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return BlocProvider(
              create: (_) => HomeBloc(
                userSetRepository: GetIt.instance.get<UserSetRepository>(),
              ),
              child: const HomeScreen(),
            );
          },
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
    return RepositoryProvider.value(
      value: GetIt.instance.get<AuthRepository>(),
      child: BlocProvider(
        lazy: false,
        create: (_) => AuthBloc(
          authRepository: GetIt.instance.get<AuthRepository>(),
          userRepository: GetIt.instance.get<UserRepository>(),
        )..add(AuthSubscriptionRequested()),
        child: MaterialApp.router(
          routerConfig: _router,
          title: 'BrickLayer',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
        ),
      ),
    );
  }
}

class BrickLayerView extends StatefulWidget {
  const BrickLayerView({super.key});

  @override
  State<BrickLayerView> createState() => BrickLayerViewState();
}

class BrickLayerViewState extends State<BrickLayerView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SizedBox.shrink(),
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              context.go('/home');
            } else if (state.status == AuthenticationStatus.unauthenticated) {
              context.go('/auth');
            } else if (state.status == AuthenticationStatus.unknown) {
              context.go('/auth');
            } else if (state.status == AuthenticationStatus.authenticationFailed) {
              context.go('/auth');
            }
          },
          child: child!,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
