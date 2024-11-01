import 'package:bricklayer/blocs/view_mode_cubit.dart';
import 'package:bricklayer/core/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sets_bloc.dart';
import 'set_grid_view_card.dart';
import 'set_list_view_card.dart';

class SetsList extends StatelessWidget {
  final SetsState _state;
  const SetsList(SetsState state, {super.key}) : _state = state;

  @override
  Widget build(BuildContext context) {
    if (_state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_state.userSets != null && _state.userSets!.isNotEmpty) {
      return BlocBuilder<ViewModeCubit, ViewMode>(
        builder: (context, viewMode) {
          if (viewMode == ViewMode.list) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _state.userSets!.length,
              itemBuilder: (context, index) {
                final userSet = _state.userSets![index];
                return SetListViewCard(userSet);
              },
            );
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 900
                    ? 4
                    : MediaQuery.of(context).size.width > 600
                        ? 3
                        : 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: _state.userSets!.length,
              itemBuilder: (context, index) {
                final userSet = _state.userSets![index];
                return GestureDetector(
                  onTap: () {
                    context.goPush('/sets/set/${userSet.id}');
                  },
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                      maxHeight: 300,
                    ),
                    child: SetGridViewCard(userSet),
                  ),
                );
              },
            );
          }
        },
      );
    } else {
      return const Center(child: Text('You have no sets yet. Try adding one by pressing the + button below.'));
    }
  }
}
