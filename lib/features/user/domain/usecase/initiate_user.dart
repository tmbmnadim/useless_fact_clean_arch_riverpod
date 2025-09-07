import 'package:flutter/rendering.dart';
import 'package:mood_log_tests/core/util/datastate.dart';
import 'package:mood_log_tests/features/user/domain/entity/user.dart';
import 'package:mood_log_tests/features/user/domain/repository/user_repository.dart';

class InitiateUser {
  final UserRepository _repository;
  InitiateUser(this._repository);

  Future<DataState<User>> call(User user) async {
    try {
      final getState = await _repository.getUser();

      if (getState is DataSuccess) {
        return getState;
      } else if (user.id == null) {
        if (user.name != null) {
          return await _repository.createUser(user);
        } else {
          return DataFailed("Failed initializing user");
        }
      } else {
        debugPrint("GETTING USER ${user.id}");
        return await _repository.getUser(user.id!);
      }
    } catch (e) {
      rethrow;
    }
  }
}
