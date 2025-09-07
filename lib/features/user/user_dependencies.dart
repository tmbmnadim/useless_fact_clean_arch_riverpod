import 'package:get/get.dart';
import 'package:mood_log_tests/features/user/data/repository/user_repository.dart';
import 'package:mood_log_tests/features/user/data/sources/user_source_local.dart';
import 'package:mood_log_tests/features/user/data/sources/user_source_network.dart';
import 'package:mood_log_tests/features/user/domain/repository/user_repository.dart';
import 'package:mood_log_tests/features/user/domain/usecase/initiate_user.dart';
import 'package:mood_log_tests/features/user/presentation/controller/user_controller.dart';

void initUserDependencies() {
  Get.lazyPut<UserSourceLocal>(() => UserSourceLocal());

  Get.lazyPut<UserSourceNetwork>(() => UserSourceNetwork());

  Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find(), Get.find()));

  Get.lazyPut<InitiateUser>(() => InitiateUser(Get.find()));

  Get.lazyPut<UserController>(() => UserController(Get.find()));
}
