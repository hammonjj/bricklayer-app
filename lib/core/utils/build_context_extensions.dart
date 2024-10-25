import 'package:flutter/material.dart';

// Usage:
// Navigator.pushNamed(
//   context,
//   '/userDetail',
//   arguments: User(id: 1, name: 'John Doe'),
// );

// Widget build(BuildContext context) {
//   final user = context.parseRouteArguments<User>();
//   return Text(user.name);
// }

extension RouteArgumentsExtension on BuildContext {
  T parseRouteArguments<T>() {
    final args = ModalRoute.of(this)?.settings.arguments;
    if (args is T) {
      return args;
    } else {
      throw ArgumentError('Expected arguments of type $T but found ${args.runtimeType}');
    }
  }
}
