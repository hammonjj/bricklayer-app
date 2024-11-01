import 'package:bricklayer/repositories/models/user_part_model.dart';
import 'package:uuid/uuid.dart';

class UserPartDto {
  final UuidValue id;
  final String legoPartId;
  final String name;
  final int quantity;
  final int inUseCount;
  final String? imageUrl;
  final String? partUrl;

  UserPartDto({
    required this.id,
    required this.legoPartId,
    required this.name,
    required this.quantity,
    required this.inUseCount,
    this.imageUrl,
    this.partUrl,
  });

  factory UserPartDto.fromUserPartModel(UserPartModel model) {
    return UserPartDto(
      id: UuidValue.fromString(model.id),
      legoPartId: model.legoPartId,
      name: model.name,
      quantity: model.quantity,
      inUseCount: model.inUseCount,
      imageUrl: model.imageUrl,
      partUrl: model.partUrl,
    );
  }
}
