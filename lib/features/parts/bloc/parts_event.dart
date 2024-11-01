part of 'parts_bloc.dart';

@freezed
class PartsEvent with _$PartsEvent {
  const factory PartsEvent.started() = _Started;
  const factory PartsEvent.fetchUserParts({bool? forceApiRefresh}) = _FetchUserParts;
}
