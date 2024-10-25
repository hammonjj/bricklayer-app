import 'package:bricklayer/providers/auth/auth_notifier.dart';
import 'package:bricklayer/services/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final appSettings = GetIt.instance.get<AppSettings>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    if (appSettings.getRememberMe()) {
      _emailController.text = appSettings.getUsername() ?? '';
      _passwordController.text = appSettings.getPassword() ?? '';
    }

    setState(() {});
  }

  Future<void> _autoLogin() async {
    final username = appSettings.getUsername();
    final password = appSettings.getPassword();

    if (username != null && password != null) {
      final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      authNotifier.login(username, password);
    }
  }

  void _onRememberMeChanged(bool? value) {
    setState(() {
      _rememberMe = value ?? false;
    });

    appSettings.setRememberMe(_rememberMe);
  }

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and password cannot be empty')),
      );

      return;
    }

    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    authNotifier.login(_emailController.text, _passwordController.text);

    if (_rememberMe) {
      await appSettings.setRememberMe(true);
      await appSettings.setUsername(_emailController.text);
      await appSettings.setPassword(_passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Consumer<AuthNotifier>(
        builder: (context, authNotifier, child) {
          return authNotifier.state.when(
            initial: () => _buildLoginForm(),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (user) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go('/');
              });

              return Container();
            },
            failure: (error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error)),
                );
              });
              return _buildLoginForm();
            },
          );
        },
      ),
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(size: 150),
          const SizedBox(height: 24),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
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
          ElevatedButton(
            onPressed: _login,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
