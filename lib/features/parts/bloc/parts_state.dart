part of 'parts_bloc.dart';

class PartsState {
  final bool isLoading;
  final List<UserPartDto>? userParts;
  final String? errorMessage;

  const PartsState({
    this.isLoading = false,
    this.userParts,
    this.errorMessage,
  });

  factory PartsState.initial() => const PartsState();
  factory PartsState.loading() => const PartsState(isLoading: true);
  factory PartsState.loaded(List<UserPartDto> userParts) => PartsState(userParts: userParts);
  factory PartsState.error(String message) => PartsState(errorMessage: message);
}
