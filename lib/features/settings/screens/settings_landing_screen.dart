import 'package:flutter/material.dart';

class SettingsLandingScreen extends StatelessWidget {
  const SettingsLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const isDarkMode = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: SwitchListTile(
          title: const Text('Dark Mode'),
          value: isDarkMode,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
