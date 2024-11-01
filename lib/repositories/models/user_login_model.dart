import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login_model.freezed.dart';
part 'user_login_model.g.dart';

@freezed
class UserLoginModel with _$UserLoginModel {
  const factory UserLoginModel({
    required String accessToken,
    required String userId,
    required String username,
  }) = _UserLoginModel;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => _$UserLoginModelFromJson(json);
}
