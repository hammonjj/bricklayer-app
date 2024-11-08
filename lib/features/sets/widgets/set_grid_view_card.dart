import 'package:bricklayer/core/widgets/cacheable_network_image.dart';
import 'package:bricklayer/features/sets/bloc/sets_bloc.dart';
import 'package:bricklayer/repositories/dtos/user_set_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SetGridViewCard extends StatefulWidget {
  final UserSetDto legoSet;

  const SetGridViewCard(this.legoSet, {super.key});

  @override
  State<SetGridViewCard> createState() => _SetGridViewCardState();
}

class _SetGridViewCardState extends State<SetGridViewCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Card(
        elevation: _isHovered ? 25 : 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: _isHovered ? const Color.fromRGBO(51, 51, 51, 1.0) : const Color.fromRGBO(31, 31, 31, 1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            CacheableNetworkImage(
              imageUrl: widget.legoSet.imageUrl ?? '',
              height: 100,
            ),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.legoSet.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  Text(
                    widget.legoSet.brand ?? 'No brand',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.legoSet.pieces != null ? '${widget.legoSet.pieces} pieces' : 'No piece count',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const Gap(8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Chip(
                      label: Text(
                        widget.legoSet.currentlyBuilt ? 'Currently Built' : 'In Progress',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      backgroundColor: widget.legoSet.currentlyBuilt ? Colors.green : Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      context.read<SetsBloc>().add(SetsEvent.deleteUserSet(widget.legoSet.id));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
