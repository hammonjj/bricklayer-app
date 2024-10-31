import 'package:bricklayer/features/home/bloc/home_bloc.dart';
import 'package:bricklayer/features/home/widgets/set_card.dart';
import 'package:flutter/material.dart';

class SetsList extends StatelessWidget {
  final HomeState _state;
  const SetsList(HomeState state, {super.key}) : _state = state;

  @override
  Widget build(BuildContext context) {
    if (_state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_state.userSets != null && _state.userSets!.isNotEmpty) {
      return ListView.builder(
        //change to gridview.count
        // - manipulate whether it's one per row or multiple based on if we are on mobile or desktop
        padding: const EdgeInsets.all(8),
        itemCount: _state.userSets!.length,
        itemBuilder: (context, index) {
          final userSet = _state.userSets![index];
          return SetCard(userSet);
        },
      );
    } else {
      return const Center(child: Text('You have no sets yet. Try adding one by pressing the + button below.'));
    }
  }
}
