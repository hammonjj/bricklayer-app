import 'package:bricklayer/blocs/view_mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/parts_bloc.dart';
import '../widgets/add_part_dialog.dart';
import '../widgets/parts_list.dart';

class PartsScreen extends StatefulWidget {
  const PartsScreen({super.key});

  @override
  PartsScreenState createState() => PartsScreenState();
}

class PartsScreenState extends State<PartsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PartsBloc>().add(const PartsEvent.fetchUserParts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parts'),
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
            onPressed: () => context.read<PartsBloc>().add(const PartsEvent.fetchUserParts(forceApiRefresh: true)),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: BlocBuilder<PartsBloc, PartsState>(
              builder: (context, state) {
                if (state.errorMessage != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage!)),
                    );
                  });
                }

                return PartsList(state);
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
              value: context.read<PartsBloc>(),
              child: const AddPartDialog(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
