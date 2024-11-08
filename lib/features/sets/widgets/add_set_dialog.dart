import 'package:bricklayer/features/sets/bloc/sets_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddSetDialog extends StatefulWidget {
  const AddSetDialog({super.key});

  @override
  AddSetDialogState createState() => AddSetDialogState();
}

class AddSetDialogState extends State<AddSetDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _setIdController = TextEditingController();

  String? _selectedBrand = 'Lego';
  bool _isCurrentlyBuilt = false;
  bool _showAdditionalFields = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Set'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String?>(
              value: _selectedBrand,
              items: const [
                DropdownMenuItem(value: null, child: Text('No brand')),
                DropdownMenuItem(value: 'Lego', child: Text('Lego')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedBrand = value;
                  _showAdditionalFields = value != 'Lego';
                });
              },
              decoration: const InputDecoration(labelText: 'Brand'),
            ),
            const Gap(16),
            TextField(
              controller: _setIdController,
              decoration: const InputDecoration(labelText: 'Set ID (optional)'),
            ),
            const Gap(8),
            SwitchListTile(
              title: const Text('Currently Built'),
              value: _isCurrentlyBuilt,
              onChanged: (value) => setState(() => _isCurrentlyBuilt = value),
            ),
            const Gap(8),
            if (_showAdditionalFields) ...[
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const Gap(16),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => GoRouter.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<SetsBloc>().add(
                  SetsEvent.addUserSet(
                    name: _nameController.text,
                    setId: _setIdController.text.isNotEmpty ? _setIdController.text : null,
                    brand: _selectedBrand,
                    isCurrentlyBuilt: _isCurrentlyBuilt,
                  ),
                );
            GoRouter.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
