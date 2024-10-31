import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

DeviceType getDeviceType(BuildContext context) {
  final double width = getScreenWidth(context);
  if (width > 1024) {
    return DeviceType.desktop;
  } else if (width > 600) {
    return DeviceType.tablet;
  } else {
    return DeviceType.mobile;
  }
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
