part of 'sets_bloc.dart';

@freezed
class SetsEvent with _$SetsEvent {
  const factory SetsEvent.started() = _Started;
  const factory SetsEvent.fetchUserSets({bool? forceApiRefresh}) = _FetchUserSets;
  const factory SetsEvent.fetchUserSetById(UuidValue id) = _FetchUserSetById;
  const factory SetsEvent.addUserSet(
      {required String name, String? setId, String? brand, required bool isCurrentlyBuilt}) = _AddUserSet;
  const factory SetsEvent.deleteUserSet(UuidValue id) = _DeleteUserSet;
}
