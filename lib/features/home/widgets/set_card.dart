import 'package:bricklayer/features/home/bloc/home_bloc.dart';
import 'package:bricklayer/repositories/dtos/user_set_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SetCard extends StatefulWidget {
  final UserSetDto _legoSet;

  const SetCard(UserSetDto legoSet, {super.key}) : _legoSet = legoSet;

  @override
  SetCardState createState() => SetCardState();
}

class SetCardState extends State<SetCard> {
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
              Image.network(
                widget._legoSet.imageUrl ?? '',
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
                      context.read<HomeBloc>().add(HomeEvent.deleteUserSet(widget._legoSet.id));
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
