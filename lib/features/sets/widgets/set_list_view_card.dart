import 'package:bricklayer/core/widgets/cached_network_image.dart';
import 'package:bricklayer/features/sets/bloc/sets_bloc.dart';
import 'package:bricklayer/repositories/dtos/user_set_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SetListViewCard extends StatefulWidget {
  final UserSetDto _legoSet;

  const SetListViewCard(UserSetDto legoSet, {super.key}) : _legoSet = legoSet;

  @override
  SetListViewCardState createState() => SetListViewCardState();
}

class SetListViewCardState extends State<SetListViewCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Card(
        elevation: _isHovered ? 25 : 20,
        color: _isHovered ? const Color.fromRGBO(51, 51, 51, 1.0) : const Color.fromRGBO(31, 31, 31, 1.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget._legoSet.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget._legoSet.brand ?? 'No brand',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(widget._legoSet.pieces != null ? '${widget._legoSet.pieces} pieces' : 'No piece count'),
                  const Gap(16),
                  Chip(
                    label: const Text(
                      'Currently Built',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    backgroundColor: widget._legoSet.currentlyBuilt ? Colors.green : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CachedNetworkImage(
                imageUrl: widget._legoSet.imageUrl ?? '',
                width: 100,
              ),
              Column(
                children: [
                  const IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<SetsBloc>().add(SetsEvent.deleteUserSet(widget._legoSet.id));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
