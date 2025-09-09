import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mood_log_tests/core/util/datastate.dart';
import 'package:mood_log_tests/features/user/domain/entity/user.dart';
import 'package:mood_log_tests/features/user/domain/usecase/initiate_user.dart';

class UserController extends GetxController {
  final InitiateUser _initiateUser;
  UserController(this._initiateUser) {
    initiateUser(User());
  }
  final Rx<User> _user = User().obs;
  final RxInt _otherUserID = 999.obs;

  User? get user => _user.value;
  int get otherUser => _otherUserID.value;
  set otherUser(int value) => _otherUserID.value = value;

  String? _message;

  String? get errorMessage => _message;

  Future<void> initiateUser(User user) async {
    try {
      DataState<User> userState = await _initiateUser(user);
      if (userState is DataSuccess) {
        _user.value = userState.getData() ?? User();
      } else {
        _message = userState.getMessage("Something went wrong!");
      }
    } catch (e, s) {
      debugPrint("UserController<initiateUser>: $e\n$s");
    }
  }
}
