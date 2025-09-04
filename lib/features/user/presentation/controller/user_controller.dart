import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mood_log_tests/core/util/datastate.dart';
import 'package:mood_log_tests/core/util/provider_manager.dart';
import 'package:mood_log_tests/features/user/domain/entity/user.dart';
import 'package:mood_log_tests/features/user/domain/usecase/initiate_user.dart';

class UserController extends GetxController {
  final InitiateUser _initiateUser;
  UserController(this._initiateUser);
  User? _user;

  User? get user => _user;
  ControllerStateStatus _status = ControllerStateStatus.initial;
  String? _message;

  String? get errorMessage => _message;

  bool get isInitial => _status == ControllerStateStatus.initial;
  bool get isLoading => _status == ControllerStateStatus.loading;
  bool get isSuccess => _status == ControllerStateStatus.success;
  bool get isUpdated => _status == ControllerStateStatus.updated;
  bool get isCreated => _status == ControllerStateStatus.created;
  bool get isFailure => _status == ControllerStateStatus.failure;

  Future<void> initiateUser(User user) async {
    try {
      _status = ControllerStateStatus.loading;
      DataState<User> userState = await _initiateUser(user);

      if (userState is DataSuccess) {
        _user = userState.getData();
        _status = ControllerStateStatus.success;
      } else {
        _message = userState.getMessage("Something went wrong!");
        _status = ControllerStateStatus.failure;
      }
    } catch (e, s) {
      debugPrint("UserController<initiateUser>: $e\n$s");
    }
  }
}
