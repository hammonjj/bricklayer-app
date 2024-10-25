import 'package:bricklayer/repositories/dtos/user_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.failure({required String error}) = _Failure;
  const factory AuthState.success({required UserDto user}) = _Success;
}
