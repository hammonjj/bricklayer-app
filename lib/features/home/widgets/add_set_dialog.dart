import 'package:bricklayer/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSetDialog extends StatefulWidget {
  const AddSetDialog({super.key});

  @override
  AddSetDialogState createState() => AddSetDialogState();
}

class AddSetDialogState extends State<AddSetDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _setIdController = TextEditingController();

  String? _selectedBrand;
  bool _isCurrentlyBuilt = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Set'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _setIdController,
              decoration: const InputDecoration(labelText: 'Set ID (optional)'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String?>(
              value: _selectedBrand,
              items: const [
                DropdownMenuItem(value: null, child: Text('No brand')),
                DropdownMenuItem(value: 'Lego', child: Text('Lego')),
              ],
              onChanged: (value) => setState(() => _selectedBrand = value),
              decoration: const InputDecoration(labelText: 'Brand'),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Currently Built'),
              value: _isCurrentlyBuilt,
              onChanged: (value) => setState(() => _isCurrentlyBuilt = value),
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
            context.read<HomeBloc>().add(
                  HomeEvent.addUserSet(
                    name: _nameController.text,
                    setId: _setIdController.text.isNotEmpty ? _setIdController.text : null,
                    brand: _selectedBrand,
                    isCurrentlyBuilt: _isCurrentlyBuilt,
                  ),
                );
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
