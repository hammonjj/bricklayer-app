import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_set_model.freezed.dart';
part 'user_set_model.g.dart';

@freezed
class UserSetModel with _$UserSetModel {
  const factory UserSetModel(
      {required String id,
      required String name,
      required bool currentlyBuilt,
      String? setId,
      String? brand,
      String? setUrl,
      String? imageUrl,
      String? instructionsUrl}) = _UserSetModel;

  factory UserSetModel.fromJson(Map<String, dynamic> json) => _$UserSetModelFromJson(json);
}
