import 'package:bricklayer/core/utils/show_snack_bar_message.dart';
import 'package:bricklayer/core/widgets/cacheable_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

import '../bloc/sets_bloc.dart';

class SetDisplayScreen extends StatefulWidget {
  final UuidValue setId;

  const SetDisplayScreen({super.key, required this.setId});

  @override
  SetDisplayScreenState createState() => SetDisplayScreenState();
}

class SetDisplayScreenState extends State<SetDisplayScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SetsBloc>().add(SetsEvent.fetchUserSetById(widget.setId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Details'),
      ),
      body: BlocBuilder<SetsBloc, SetsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.errorMessage != null) {
            showSnackBarMessage(context, state.errorMessage!);
            return Center(child: Text(state.errorMessage!));
          } else if (state.userSet != null) {
            final userSet = state.userSet!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (userSet.imageUrl != null)
                    CacheableNetworkImage(
                      imageUrl: userSet.imageUrl ?? '',
                      height: 400,
                      width: 400,
                    ),
                  const Gap(10),
                  Text(
                    'Name: ${userSet.name}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Brand: ${userSet.brand ?? "N/A"}'),
                  Text('Pieces: ${userSet.pieces?.toString() ?? "N/A"}'),
                  Text('Currently Built: ${userSet.currentlyBuilt ? "Yes" : "No"}'),
                  const Gap(10),
                  if (userSet.instructionsUrl != null)
                    ElevatedButton(
                      onPressed: () {
                        // Implement navigation or opening of the URL
                      },
                      child: const Text('View Instructions'),
                    ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Set not found.'));
          }
        },
      ),
    );
  }
}
