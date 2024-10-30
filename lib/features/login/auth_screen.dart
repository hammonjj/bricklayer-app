import 'package:bricklayer/core/widgets/auth_button.dart';
import 'package:bricklayer/core/widgets/password_input.dart';
import 'package:bricklayer/core/widgets/username_input.dart';
import 'package:bricklayer/features/login/bloc/login_bloc.dart';
import 'package:bricklayer/services/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;
  bool _rememberMe = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
  }

  Future<void> _loadSavedCredentials() async {
    final appSettings = GetIt.I<AppSettings>();

    if (appSettings.getRememberMe()) {
      _rememberMe = true;
      _usernameController.text = appSettings.getUsername() ?? '';
      _passwordController.text = appSettings.getPassword() ?? '';
      context.read<LoginBloc>().add(LoginUsernameChanged(_usernameController.text));
      context.read<LoginBloc>().add(LoginPasswordChanged(_passwordController.text));
      setState(() {});
    }
  }

  void _toggleRememberMe(bool? value) {
    setState(() {
      _rememberMe = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Login' : 'Register'),
        actions: [
          TextButton(
            onPressed: _toggleMode,
            child: Text(_isLoginMode ? 'Switch to Register' : 'Switch to Login'),
          ),
        ],
      ),
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
            children: [
              const FlutterLogo(size: 150),
              const SizedBox(height: 24),
              UsernameInput(controller: _usernameController),
              const SizedBox(height: 16),
              PasswordInput(controller: _passwordController),
              if (!_isLoginMode) ...[
                const SizedBox(height: 16),
                _ConfirmPasswordInput(),
              ],
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: _toggleRememberMe,
                  ),
                  const Text('Remember Me'),
                ],
              ),
              const SizedBox(height: 24),
              AuthButton(
                isLoginMode: _isLoginMode,
                rememberMe: _rememberMe,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('confirmPasswordInput'),
      controller: controller,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Confirm Password',
      ),
    );
  }
}
