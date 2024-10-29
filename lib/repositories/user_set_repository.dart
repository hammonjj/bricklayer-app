import 'dart:async';

import 'package:bricklayer/repositories/dtos/user_set_dto.dart';
import 'package:bricklayer/repositories/models/user_set_model.dart';

import '../services/api_client.dart';

class UserSetRepository {
  final ApiClient _apiClient;

  UserSetRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<UserSetDto>> getUserSets() async {
    try {
      final response = await _apiClient.get('/userSets', true);

      if (response.statusCode == 200) {
        final userSetModels = response.data.map((userSet) => UserSetModel.fromJson(userSet));
        return userSetModels.map((userSetModel) => UserSetDto.fromUserSetModel(userSetModel)).toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
