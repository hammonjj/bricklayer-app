part of 'home_bloc.dart';

class HomeState {
  final bool isLoading;
  final List<UserSetDto>? userSets;
  final String? errorMessage;

  const HomeState({
    this.isLoading = false,
    this.userSets,
    this.errorMessage,
  });

  factory HomeState.initial() => const HomeState();
  factory HomeState.loading() => const HomeState(isLoading: true);
  factory HomeState.loaded(List<UserSetDto> userSets) => HomeState(userSets: userSets);
  factory HomeState.error(String message) => HomeState(errorMessage: message);
}
