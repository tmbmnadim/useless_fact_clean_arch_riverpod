import 'package:get/get.dart';
import 'package:mood_log_tests/features/user/data/repository/user_repository.dart';
import 'package:mood_log_tests/features/user/data/sources/user_source_local.dart';
import 'package:mood_log_tests/features/user/data/sources/user_source_network.dart';
import 'package:mood_log_tests/features/user/domain/repository/user_repository.dart';
import 'package:mood_log_tests/features/user/domain/usecase/initiate_user.dart';

initUserDependencies() {
  final userSourceLocal = Get.put(UserSourceLocal());

  final userSourceNetwork = Get.put(UserSourceNetwork());

  UserRepository userRepository = Get.put(
    UserRepositoryImpl(userSourceLocal, userSourceNetwork),
  );

  InitiateUser initiateUser = Get.put(InitiateUser(userRepository));
}
