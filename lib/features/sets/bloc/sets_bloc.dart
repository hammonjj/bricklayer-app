import 'package:bricklayer/repositories/dtos/user_set_dto.dart';
import 'package:bricklayer/repositories/user_set_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'sets_event.dart';
part 'sets_state.dart';
part 'sets_bloc.freezed.dart';

class SetsBloc extends Bloc<SetsEvent, SetsState> {
  final UserSetRepository _userSetRepository;

  SetsBloc({required UserSetRepository userSetRepository})
      : _userSetRepository = userSetRepository,
        super(SetsState.initial()) {
    on<SetsEvent>((event, emit) async {
      if (event is _FetchUserSets) {
        await _onFetchUserSets(emit);
      } else if (event is _AddUserSet) {
        await _onAddUserSet(event, emit);
      } else if (event is _DeleteUserSet) {
        await deleteUserSet(event.id, emit);
      } else if (event is _FetchUserSetById) {
        await _onFetchUserSetById(event.id, emit);
      }
    });
  }

  Future<void> _onFetchUserSets(Emitter<SetsState> emit) async {
    emit(SetsState.loading());

    try {
      final userSets = await _userSetRepository.getUserSets();
      emit(SetsState.loadedSets(userSets));
    } catch (e) {
      emit(SetsState.error('Failed to fetch user sets'));
    }
  }

  Future<void> _onFetchUserSetById(UuidValue id, Emitter<SetsState> emit) async {
    emit(SetsState.loading());

    try {
      final userSet = await _userSetRepository.getUserSetById(id);
      emit(SetsState.loadedSet(userSet));
    } catch (e) {
      emit(SetsState.error('Failed to fetch user set'));
    }
  }

  Future<void> _onAddUserSet(_AddUserSet event, Emitter<SetsState> emit) async {
    try {
      await _userSetRepository.addUserSet(
        name: event.name,
        setId: event.setId,
        brand: event.brand,
        isCurrentlyBuilt: event.isCurrentlyBuilt,
      );

      add(const SetsEvent.fetchUserSets());
    } catch (e) {
      emit(SetsState.error('Failed to add user set'));
    }
  }

  Future<void> deleteUserSet(UuidValue id, Emitter<SetsState> emit) async {
    try {
      await _userSetRepository.deleteUserSet(id);
      add(const SetsEvent.fetchUserSets());
    } catch (e) {
      emit(SetsState.error('Failed to delete user set'));
    }
  }
}
