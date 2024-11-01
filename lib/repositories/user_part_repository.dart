import 'package:bricklayer/repositories/dtos/user_part_dto.dart';
import 'package:bricklayer/repositories/models/user_part_model.dart';
import 'package:bricklayer/services/api_client.dart';
import 'package:uuid/uuid.dart';

class UserPartRepository {
  final ApiClient _apiClient;

  List<UserPartDto>? _userParts;

  UserPartRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<UserPartDto>> getAllParts({bool forceApiRefresh = false}) async {
    if (_userParts != null && !forceApiRefresh) {
      return _userParts!;
    }

    try {
      final response = await _apiClient.get('/userParts', true);
      final data = response.data as List<dynamic>?;

      if (response.statusCode == 200 && data != null && data.isNotEmpty) {
        final userPartModels =
            data.cast<Map<String, dynamic>>().map<UserPartModel>((part) => UserPartModel.fromJson(part)).toList();

        _userParts =
            userPartModels.map<UserPartDto>((userPartModel) => UserPartDto.fromUserPartModel(userPartModel)).toList();
        return _userParts!;
      } else {
        _userParts = [];
        return _userParts!;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserPartDto> getPartById(UuidValue partId) async {
    try {
      final response = await _apiClient.get('/userParts/$partId', true);

      if (response.statusCode == 200) {
        final userPartModel = UserPartModel.fromJson(response.data);
        return UserPartDto.fromUserPartModel(userPartModel);
      } else {
        throw Exception(response.data['error'] ?? 'Failed to fetch user part');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserPartDto> addUserPart({
    required String legoPartId,
    required String name,
    required int quantity,
    required int inUseCount,
    String? imageUrl,
    String? partUrl,
  }) async {
    try {
      final response = await _apiClient.post(
        '/userParts',
        true,
        data: {
          'legoPartId': legoPartId,
          'name': name,
          'quantity': quantity,
          'inUseCount': inUseCount,
          'imageUrl': imageUrl,
          'partUrl': partUrl,
        },
      );

      if (response.statusCode == 200) {
        final partInfo = UserPartDto.fromUserPartModel(UserPartModel.fromJson(response.data['partInfo']));
        _userParts ??= [];
        _userParts?.add(partInfo);
        return partInfo;
      } else {
        throw Exception(response.data['error'] ?? 'Failed to add user part');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserPart(UuidValue partId) async {
    try {
      final response = await _apiClient.delete('/userParts/${partId.toString()}', true);

      if (response.statusCode == 200) {
        _userParts?.removeWhere((userPart) => userPart.id == partId);
      } else {
        throw Exception(response.data['error'] ?? 'Failed to delete user part');
      }
    } catch (e) {
      rethrow;
    }
  }
}
