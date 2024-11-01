import 'package:bricklayer/core/utils/responsive_utilities.dart';
import 'package:bricklayer/core/widgets/sidebar_menu.dart';
import 'package:flutter/material.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final deviceType = getDeviceType(context);

    return Scaffold(
      drawer: deviceType == DeviceType.mobile ? const SidebarMenu(isDrawer: true) : null,
      body: Row(
        children: [
          if (deviceType == DeviceType.desktop || deviceType == DeviceType.tablet) const SidebarMenu(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
