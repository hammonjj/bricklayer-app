import 'package:bricklayer/bricklayer.dart';
import 'package:bricklayer/services/service_registrator.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerServices();

  runApp(const Bricklayer());
}
