import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mood_log_tests/core/util/datastate.dart';
import 'package:mood_log_tests/core/util/provider_manager.dart';
import 'package:mood_log_tests/features/user/domain/entity/user.dart';
import 'package:mood_log_tests/features/user/domain/usecase/initiate_user.dart';

class UserController extends GetxController {
  final InitiateUser _initiateUser;
  UserController(this._initiateUser) {
    initiateUser(User());
  }
  final Rx<User> _user = User().obs;

  User? get user => _user.value;
  final Rx<ControllerStateStatus> _status = ControllerStateStatus.initial.obs;
  String? _message;

  String? get errorMessage => _message;

  bool get isInitial => _status.value == ControllerStateStatus.initial;
  bool get isLoading => _status.value == ControllerStateStatus.loading;
  bool get isSuccess => _status.value == ControllerStateStatus.success;
  bool get isUpdated => _status.value == ControllerStateStatus.updated;
  bool get isCreated => _status.value == ControllerStateStatus.created;
  bool get isFailure => _status.value == ControllerStateStatus.failure;

  Future<void> initiateUser(User user) async {
    try {
      _status.value = ControllerStateStatus.loading;
      DataState<User> userState = await _initiateUser(user);
      if (userState is DataSuccess) {
        print("GOT USER");
        _user.value = userState.getData() ?? User();

        _status.value = ControllerStateStatus.success;
      } else {
        _message = userState.getMessage("Something went wrong!");
        _status.value = ControllerStateStatus.failure;
      }
    } catch (e, s) {
      debugPrint("UserController<initiateUser>: $e\n$s");
    }
  }
}
