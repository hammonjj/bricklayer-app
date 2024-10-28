import 'package:bricklayer/core/forms/password_validator.dart';
import 'package:bricklayer/core/forms/username_validator.dart';
import 'package:bricklayer/features/login/bloc/login_bloc.dart';
import 'package:bricklayer/services/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final appSettings = GetIt.instance.get<AppSettings>();

  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    //_loadRememberMe();
  }

  // Future<void> _loadRememberMe() async {
  //   if (appSettings.getRememberMe()) {
  //     _emailController.text = appSettings.getUsername() ?? '';
  //     _passwordController.text = appSettings.getPassword() ?? '';
  //   }

  //   setState(() {});
  // }

  // Future<void> _autoLogin() async {
  //   final username = appSettings.getUsername();
  //   final password = appSettings.getPassword();

  //   if (username != null && password != null) {
  //     final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  //     authNotifier.login(username, password);
  //   }
  // }

  void _onRememberMeChanged(bool? value) {
    setState(() {
      _rememberMe = value ?? false;
    });

    appSettings.setRememberMe(_rememberMe);
  }

  // Future<void> _login() async {
  //   if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Email and password cannot be empty')),
  //     );

  //     return;
  //   }

  //   final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  //   authNotifier.login(_emailController.text, _passwordController.text);

  //   if (_rememberMe) {
  //     await appSettings.setRememberMe(true);
  //     await appSettings.setUsername(_emailController.text);
  //     await appSettings.setPassword(_passwordController.text);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        } else if (state.status.isSuccess) {
          context.go('/home');
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildLoginForm()],
        ),
      ),
    ));
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(size: 150),
          const SizedBox(height: 24),
          _UsernameInput(),
          const SizedBox(height: 16),
          _PasswordInput(),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: _onRememberMeChanged,
              ),
              const Text('Remember me'),
            ],
          ),
          const SizedBox(height: 24),
          _LoginButton()
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final validator = context.select((LoginBloc bloc) => bloc.state.username);

    return TextField(
      key: const Key('usernameInput'),
      controller: controller,
      onChanged: (username) {
        context.read<LoginBloc>().add(LoginUsernameChanged(username));
      },
      decoration: InputDecoration(
        labelText: 'username',
        errorText: validator.isNotValid ? _getUsernameErrorText(validator.error) : null,
      ),
    );
  }

  String? _getUsernameErrorText(UsernameValidationError? error) {
    switch (error) {
      case UsernameValidationError.empty:
        return 'Username cannot be empty';
      default:
        return null;
    }
  }
}

class _PasswordInput extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final validator = context.select((LoginBloc bloc) => bloc.state.password);

    return TextField(
      key: const Key('passwordInput'),
      controller: controller,
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'password',
        errorText: validator.isNotValid ? _getPasswordErrorText(validator.error) : null,
      ),
    );
  }

  String? _getPasswordErrorText(PasswordValidationError? error) {
    switch (error) {
      case PasswordValidationError.empty:
        return 'Password cannot be empty';
      default:
        return null;
    }
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (LoginBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) {
      return const CircularProgressIndicator();
    }

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('loginButton'),
      onPressed: isValid ? () => context.read<LoginBloc>().add(const LoginSubmitted()) : null,
      child: const Text('Login'),
    );
  }
}
