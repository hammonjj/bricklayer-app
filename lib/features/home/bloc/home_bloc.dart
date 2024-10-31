import 'package:bricklayer/repositories/dtos/user_set_dto.dart';
import 'package:bricklayer/repositories/user_set_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

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
      } else if (event is _AddUserSet) {
        await _onAddUserSet(event, emit);
      } else if (event is _DeleteUserSet) {
        await deleteUserSet(event.id, emit);
      }
    });
  }

  Future<void> _onFetchUserSets(Emitter<HomeState> emit) async {
    emit(HomeState.loading());

    try {
      final userSets = await _userSetRepository.getUserSets();
      emit(HomeState.loaded(userSets));
    } catch (e) {
      emit(HomeState.error('Failed to fetch user sets'));
    }
  }

  Future<void> _onAddUserSet(_AddUserSet event, Emitter<HomeState> emit) async {
    try {
      await _userSetRepository.addUserSet(
        name: event.name,
        setId: event.setId,
        brand: event.brand,
        isCurrentlyBuilt: event.isCurrentlyBuilt,
      );

      add(const HomeEvent.fetchUserSets());
    } catch (e) {
      emit(HomeState.error('Failed to add user set'));
    }
  }

  Future<void> deleteUserSet(UuidValue id, Emitter<HomeState> emit) async {
    try {
      await _userSetRepository.deleteUserSet(id);
      add(const HomeEvent.fetchUserSets());
    } catch (e) {
      emit(HomeState.error('Failed to delete user set'));
    }
  }
}
