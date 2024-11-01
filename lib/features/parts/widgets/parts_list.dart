import 'package:bricklayer/blocs/view_mode_cubit.dart';
import 'package:bricklayer/features/parts/bloc/parts_bloc.dart';
import 'package:bricklayer/features/parts/widgets/part_grid_view_card.dart';
import 'package:bricklayer/features/parts/widgets/part_list_view_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartsList extends StatelessWidget {
  final PartsState _state;
  const PartsList(this._state, {super.key});

  @override
  Widget build(BuildContext context) {
    if (_state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_state.userParts != null && _state.userParts!.isNotEmpty) {
      return BlocBuilder<ViewModeCubit, ViewMode>(
        builder: (context, viewMode) {
          if (viewMode == ViewMode.list) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _state.userParts!.length,
              itemBuilder: (context, index) {
                final userPart = _state.userParts![index];
                return PartListViewCard(userPart);
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
                childAspectRatio: 0.75,
              ),
              itemCount: _state.userParts!.length,
              itemBuilder: (context, index) {
                final userPart = _state.userParts![index];
                return PartGridViewCard(userPart);
              },
            );
          }
        },
      );
    } else {
      return const Center(child: Text('You have no parts yet. Try adding one by pressing the + button below.'));
    }
  }
}
