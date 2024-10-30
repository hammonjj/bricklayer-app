import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

extension GoRouteExtension on BuildContext {
  goPush<T>(String route) => kIsWeb ? GoRouter.of(this).go(route) : GoRouter.of(this).push(route);
}
