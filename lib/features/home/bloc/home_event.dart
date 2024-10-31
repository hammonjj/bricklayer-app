part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = _Started;
  const factory HomeEvent.fetchUserSets({bool? forceApiRefresh}) = _FetchUserSets;
  const factory HomeEvent.addUserSet(
      {required String name, String? setId, String? brand, required bool isCurrentlyBuilt}) = _AddUserSet;
  const factory HomeEvent.deleteUserSet(UuidValue id) = _DeleteUserSet;
}
