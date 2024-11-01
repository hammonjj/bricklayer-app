import 'package:bricklayer/repositories/dtos/user_part_dto.dart';
import 'package:bricklayer/repositories/user_part_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parts_event.dart';
part 'parts_state.dart';
part 'parts_bloc.freezed.dart';

class PartsBloc extends Bloc<PartsEvent, PartsState> {
  final UserPartRepository _userPartRepository;

  PartsBloc({required UserPartRepository userPartRepository})
      : _userPartRepository = userPartRepository,
        super(PartsState.initial()) {
    on<PartsEvent>((event, emit) async {
      if (event is _FetchUserParts) {
        await _onFetchUserParts(event, emit);
      }
    });
  }

  Future<void> _onFetchUserParts(_FetchUserParts event, Emitter<PartsState> emit) async {
    emit(PartsState.loading());

    try {
      final userParts = await _userPartRepository.getAllParts(forceApiRefresh: event.forceApiRefresh ?? false);
      emit(PartsState.loaded(userParts));
    } catch (e) {
      emit(PartsState.error('Failed to fetch user parts'));
    }
  }
}
