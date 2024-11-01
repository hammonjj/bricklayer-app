import 'package:bricklayer/repositories/dtos/user_part_dto.dart';
import 'package:flutter/material.dart';

class PartListViewCard extends StatelessWidget {
  final UserPartDto userPart;

  const PartListViewCard(this.userPart, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(userPart.imageUrl ?? '', width: 50, height: 50, fit: BoxFit.cover),
        title: Text(userPart.name),
        subtitle: Text('${userPart.quantity} pieces'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () {
            // Handle deletion of part
          },
        ),
      ),
    );
  }
}
