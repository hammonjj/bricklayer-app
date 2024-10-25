// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_registration_model.freezed.dart';
part 'user_registration_model.g.dart';

@freezed
class UserRegistrationModel with _$UserRegistrationModel {
  const factory UserRegistrationModel({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required String username,
  }) = _UserRegistrationModel;

  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) => _$UserRegistrationModelFromJson(json);
}
