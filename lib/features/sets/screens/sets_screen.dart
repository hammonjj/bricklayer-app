import 'package:bricklayer/blocs/view_mode_cubit.dart';
import 'package:bricklayer/core/utils/show_snack_bar_message.dart';
import 'package:bricklayer/features/sets/widgets/sets_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sets_bloc.dart';
import '../widgets/add_set_dialog.dart';

class SetsScreen extends StatefulWidget {
  const SetsScreen({super.key});

  @override
  SetsScreenState createState() => SetsScreenState();
}

class SetsScreenState extends State<SetsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SetsBloc>().add(const SetsEvent.fetchUserSets());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sets'),
        actions: [
          BlocBuilder<ViewModeCubit, ViewMode>(
            builder: (context, viewMode) {
              return IconButton(
                icon: Icon(viewMode == ViewMode.list ? Icons.grid_view : Icons.view_list),
                onPressed: () => context.read<ViewModeCubit>().toggleViewMode(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<SetsBloc>().add(const SetsEvent.fetchUserSets(forceApiRefresh: true)),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: BlocBuilder<SetsBloc, SetsState>(
              builder: (context, state) {
                if (state.errorMessage != null) {
                  showSnackBarMessage(context, state.errorMessage!);
                }

                return SetsList(state);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => BlocProvider.value(
              value: context.read<SetsBloc>(),
              child: const AddSetDialog(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
