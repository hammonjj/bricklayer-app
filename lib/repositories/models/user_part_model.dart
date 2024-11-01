import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_part_model.freezed.dart';
part 'user_part_model.g.dart';

@freezed
class UserPartModel with _$UserPartModel {
  const factory UserPartModel({
    required String id,
    required String legoPartId,
    required String name,
    required int quantity,
    required int inUseCount,
    String? imageUrl,
    String? partUrl,
  }) = _UserPartModel;

  factory UserPartModel.fromJson(Map<String, dynamic> json) => _$UserPartModelFromJson(json);
}
