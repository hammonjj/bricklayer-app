import 'package:bricklayer/core/utils/build_context_extensions.dart';
import 'package:bricklayer/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger the fetchUserSets event when HomeScreen is built
    context.read<HomeBloc>().add(const HomeEvent.fetchUserSets());

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.goPush('/settings'),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.userSets != null) {
            return ListView.builder(
              itemCount: state.userSets!.length,
              itemBuilder: (context, index) {
                final userSet = state.userSets![index];
                return ListTile(
                  title: Text(userSet.name),
                  subtitle: Text(userSet.brand ?? 'No brand'),
                );
              },
            );
          } else if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          } else {
            return const Center(child: Text('Welcome!'));
          }
        },
      ),
    );
  }
}
