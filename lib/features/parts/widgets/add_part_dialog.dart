import 'package:flutter/material.dart';

class AddPartDialog extends StatefulWidget {
  const AddPartDialog({super.key});

  @override
  AddPartDialogState createState() => AddPartDialogState();
}

class AddPartDialogState extends State<AddPartDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _legoPartIdController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Part'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _legoPartIdController,
              decoration: const InputDecoration(labelText: 'Lego Part ID'),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // context.read<PartsBloc>().add(
            //       PartsEvent.addUserPart(
            //         legoPartId: _legoPartIdController.text,
            //         name: _nameController.text,
            //         quantity: int.parse(_quantityController.text),
            //         inUseCount: 0,
            //       ),
            //     );
            // Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
