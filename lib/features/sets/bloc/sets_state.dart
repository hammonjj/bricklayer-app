part of 'sets_bloc.dart';

class SetsState {
  final bool isLoading;
  final UserSetDto? userSet;
  final List<UserSetDto>? userSets;
  final String? errorMessage;

  const SetsState({
    this.isLoading = false,
    this.userSet,
    this.userSets,
    this.errorMessage,
  });

  factory SetsState.initial() => const SetsState();
  factory SetsState.loading() => const SetsState(isLoading: true);
  factory SetsState.loadedSets(List<UserSetDto> userSets) => SetsState(userSets: userSets);
  factory SetsState.loadedSet(UserSetDto userSet) => SetsState(userSet: userSet);
  factory SetsState.error(String message) => SetsState(errorMessage: message);
}
