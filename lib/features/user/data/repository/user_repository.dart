import 'package:mood_log_tests/core/util/datastate.dart';
import 'package:mood_log_tests/core/util/repository_error_handler.dart';
import 'package:mood_log_tests/features/user/data/models/user_model.dart';
import 'package:mood_log_tests/features/user/data/sources/user_source_local.dart';
import 'package:mood_log_tests/features/user/data/sources/user_source_network.dart';
import 'package:mood_log_tests/features/user/domain/entity/user.dart';
import 'package:mood_log_tests/features/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserSourceLocal _local;
  final UserSourceNetwork _network;
  UserRepositoryImpl(this._local, this._network);
  @override
  Future<DataState<User>> getUser([int? userID]) async {
    return RepositoryErrorHandler.call<UserModel>(
      network: () {
        return _network.getUser(userID);
      },
      getFromLocal: _local.getUser,
      saveLocal: _local.setUser,
      proxyMessage: "Failed getting user",
    );
  }

  @override
  Future<DataState<User>> createUser(User user) async {
    return RepositoryErrorHandler.call<UserModel>(
      network: () {
        return _network.createUser(UserModel.fromEntity(user));
      },
      saveLocal: _local.setUser,
      proxyMessage: "Failed getting user",
    );
  }
}
