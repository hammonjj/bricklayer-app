import 'package:bricklayer/repositories/dtos/user_set_dto.dart';
import 'package:bricklayer/repositories/user_set_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserSetRepository _userSetRepository;

  HomeBloc({required UserSetRepository userSetRepository})
      : _userSetRepository = userSetRepository,
        super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      if (event is _FetchUserSets) {
        await _onFetchUserSets(emit);
      }
    });
  }

  Future<void> _onFetchUserSets(Emitter<HomeState> emit) async {
    emit(HomeState.loading()); // Emit loading state

    try {
      // Fetch the user sets
      final userSets = await _userSetRepository.getUserSets();

      // Emit the loaded state with fetched data
      emit(HomeState.loaded(userSets));
    } catch (e) {
      // Emit an error state in case of failure
      emit(HomeState.error('Failed to fetch user sets'));
    }
  }
}
