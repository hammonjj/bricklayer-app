import 'package:uuid/uuid.dart';

class Guid {
  final String value;

  Guid._(this.value);

  factory Guid.newGuid() {
    return Guid._(const Uuid().v4());
  }

  factory Guid.parse(String guidString) {
    return Guid._(guidString);
  }

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Guid && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
