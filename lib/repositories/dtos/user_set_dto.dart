import 'package:bricklayer/repositories/models/user_set_model.dart';
import 'package:uuid/uuid_value.dart';

class UserSetDto {
  final UuidValue id;

  final String? setId;
  final String? brand;
  final String name;
  final bool currentlyBuilt;
  final String? setUrl;
  final String? imageUrl;
  final String? instructionsUrl;

  UserSetDto(
      {required this.id,
      required this.name,
      required this.currentlyBuilt,
      this.setId,
      this.brand,
      this.setUrl,
      this.imageUrl,
      this.instructionsUrl});

  factory UserSetDto.fromUserSetModel(UserSetModel userSetModel) {
    return UserSetDto(
        id: UuidValue.fromString(userSetModel.id),
        name: userSetModel.name,
        currentlyBuilt: userSetModel.currentlyBuilt,
        setId: userSetModel.setId,
        brand: userSetModel.brand,
        setUrl: userSetModel.setUrl,
        imageUrl: userSetModel.imageUrl,
        instructionsUrl: userSetModel.instructionsUrl);
  }
}
