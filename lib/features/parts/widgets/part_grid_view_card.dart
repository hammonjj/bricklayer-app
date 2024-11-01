import 'package:bricklayer/core/widgets/cached_network_image.dart';
import 'package:bricklayer/repositories/dtos/user_part_dto.dart';
import 'package:flutter/material.dart';

class PartGridViewCard extends StatelessWidget {
  final UserPartDto userPart;

  const PartGridViewCard(this.userPart, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: CachedNetworkImage(
              imageUrl: userPart.imageUrl!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userPart.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('${userPart.quantity} pieces'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
