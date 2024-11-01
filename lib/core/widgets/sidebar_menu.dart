import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SidebarMenu extends StatelessWidget {
  final bool isDrawer;

  const SidebarMenu({super.key, this.isDrawer = false});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: isDrawer ? 16 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(isDrawer ? 16 : 0),
          bottomRight: Radius.circular(isDrawer ? 16 : 0),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Collection',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Sets'),
                  onTap: () => context.go('/sets'),
                ),
                ListTile(
                  title: const Text('Mocs'),
                  onTap: () => context.go('/mocs'),
                ),
                ListTile(
                  title: const Text('Parts'),
                  onTap: () => context.go('/parts'),
                ),
                ListTile(
                  title: const Text('Minifigs'),
                  onTap: () => context.go('/minifigs'),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Preferences'),
                  onTap: () => context.go('/settings'),
                ),
                ListTile(
                  title: const Text('Profile'),
                  onTap: () => context.go('/profile'),
                ),
                ListTile(
                  title: const Text('Log Out'),
                  onTap: () => context.go('/logout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
