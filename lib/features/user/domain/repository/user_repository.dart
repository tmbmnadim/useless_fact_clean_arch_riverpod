import 'package:mood_log_tests/core/util/datastate.dart';
import 'package:mood_log_tests/features/user/domain/entity/user.dart';

abstract class UserRepository {
  Future<DataState<User>> getUser(String userID);

  Future<DataState<User>> createUser(User user);
}
