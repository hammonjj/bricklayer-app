import 'package:bricklayer/core/widgets/auth_button.dart';
import 'package:bricklayer/core/widgets/password_input.dart';
import 'package:bricklayer/core/widgets/username_input.dart';
import 'package:bricklayer/features/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
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
              UsernameInput(),
              const SizedBox(height: 16),
              PasswordInput(),
              if (!_isLoginMode) ...[
                const SizedBox(height: 16),
                _ConfirmPasswordInput(),
              ],
              const SizedBox(height: 24),
              AuthButton(isLoginMode: _isLoginMode),
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
