import 'package:bricklayer/features/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameInput extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  UsernameInput({super.key});

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
        labelText: 'Username',
        errorText: validator.isNotValid ? 'Username cannot be empty' : null,
      ),
    );
  }
}
