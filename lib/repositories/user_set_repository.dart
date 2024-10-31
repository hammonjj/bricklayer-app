import 'dart:async';

import 'package:bricklayer/repositories/dtos/user_set_dto.dart';
import 'package:bricklayer/repositories/models/user_set_model.dart';
import 'package:uuid/uuid.dart';

import '../services/api_client.dart';

class UserSetRepository {
  final ApiClient _apiClient;

  List<UserSetDto>? _userSets;

  UserSetRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<UserSetDto>> getUserSets({bool forceApiRefresh = false}) async {
    if (_userSets != null && !forceApiRefresh) {
      return _userSets!;
    }

    try {
      final response = await _apiClient.get('/userSets', true);
      final data = response.data as List<dynamic>?;

      if (response.statusCode == 200 && data != null && data.isNotEmpty) {
        final userSetModels =
            data.cast<Map<String, dynamic>>().map<UserSetModel>((userSet) => UserSetModel.fromJson(userSet)).toList();

        _userSets = userSetModels.map<UserSetDto>((userSetModel) => UserSetDto.fromUserSetModel(userSetModel)).toList();
        return _userSets!;
      } else {
        _userSets = [];
        return _userSets!;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserSetDto> addUserSet({
    required String name,
    required String? setId,
    required String? brand,
    required bool isCurrentlyBuilt,
  }) async {
    try {
      final response = await _apiClient.post(
        '/userSets',
        true,
        data: {
          'name': name,
          'setId': setId,
          'brand': brand,
          'currentlyBuilt': isCurrentlyBuilt,
        },
      );

      if (response.statusCode == 200) {
        final setInfo = UserSetDto.fromUserSetModel(UserSetModel.fromJson(response.data['setInfo']));

        _userSets ??= [];
        _userSets?.add(setInfo);
        return setInfo;
      } else {
        throw Exception(response.data['error'] ?? 'Failed to add user set');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserSet(UuidValue id) async {
    try {
      final response = await _apiClient.delete('/userSets/${id.toString()}', true);

      if (response.statusCode == 200) {
        _userSets?.removeWhere((userSet) => userSet.id == id);
      } else {
        throw Exception(response.data['error'] ?? 'Failed to delete user set');
      }
    } catch (e) {
      rethrow;
    }
  }
}
