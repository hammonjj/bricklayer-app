import 'package:bricklayer/blocs/auth/auth_bloc.dart';
import 'package:bricklayer/blocs/view_mode_cubit.dart';
import 'package:bricklayer/core/enums.dart';
import 'package:bricklayer/core/widgets/main_shell.dart';
import 'package:bricklayer/features/login/auth_screen.dart';
import 'package:bricklayer/features/login/bloc/login_bloc.dart';
import 'package:bricklayer/features/parts/bloc/parts_bloc.dart';
import 'package:bricklayer/features/parts/screens/parts_screen.dart';
import 'package:bricklayer/features/sets/bloc/sets_bloc.dart';
import 'package:bricklayer/features/sets/screens/set_display_screen.dart';
import 'package:bricklayer/features/sets/screens/sets_screen.dart';
import 'package:bricklayer/features/settings/screens/settings_landing_screen.dart';
import 'package:bricklayer/features/splash/splash_screen.dart';
import 'package:bricklayer/repositories/auth_repository.dart';
import 'package:bricklayer/repositories/user_part_repository.dart';
import 'package:bricklayer/repositories/user_repository.dart';
import 'package:bricklayer/repositories/user_set_repository.dart';
import 'package:bricklayer/services/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

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
                appSettings: appSettings,
              ),
              child: const AuthScreen(),
            );
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => SetsBloc(
                    userSetRepository: GetIt.instance.get<UserSetRepository>(),
                  ),
                ),
                BlocProvider(
                  create: (_) => ViewModeCubit(GetIt.instance.get<AppSettings>()),
                ),
              ],
              child: MainShell(child: child),
            );
          },
          routes: [
            GoRoute(
              path: '/sets',
              builder: (context, state) => const SetsScreen(),
              routes: [
                GoRoute(
                  path: 'set/:id',
                  builder: (context, state) {
                    return SetDisplayScreen(setId: UuidValue.fromString(state.pathParameters['id'] as String));
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/parts',
              builder: (context, state) {
                return BlocProvider(
                  create: (_) => PartsBloc(
                    userPartRepository: GetIt.instance.get<UserPartRepository>(),
                  ),
                  child: const PartsScreen(),
                );
              },
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsLandingScreen(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: GetIt.instance.get<AuthRepository>(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (_) => AuthBloc(
              authRepository: GetIt.instance.get<AuthRepository>(),
              userRepository: GetIt.instance.get<UserRepository>(),
            )..add(AuthSubscriptionRequested()),
          ),
          BlocProvider(
            create: (_) => ViewModeCubit(GetIt.instance.get<AppSettings>()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
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
              context.go('/sets');
            } else if (state.status == AuthenticationStatus.unauthenticated ||
                state.status == AuthenticationStatus.unknown ||
                state.status == AuthenticationStatus.authenticationFailed) {
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
