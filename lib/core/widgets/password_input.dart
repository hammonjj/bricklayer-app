import 'package:bricklayer/features/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  PasswordInput({super.key});

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
        labelText: 'Password',
        errorText: validator.isNotValid ? 'Password cannot be empty' : null,
      ),
    );
  }
}
