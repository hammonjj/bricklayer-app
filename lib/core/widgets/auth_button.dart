import 'package:bricklayer/features/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AuthButton extends StatelessWidget {
  final bool isLoginMode;

  const AuthButton({super.key, required this.isLoginMode});

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
      key: const Key('authButton'),
      onPressed: isValid
          ? () {
              context.read<LoginBloc>().add(
                    isLoginMode ? const LoginSubmitted() : const RegistrationSubmitted(),
                  );
            }
          : null,
      child: Text(isLoginMode ? 'Login' : 'Register'),
    );
  }
}