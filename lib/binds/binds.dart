
import 'package:get/instance_manager.dart';
import 'package:viacredi/controllers/userController.dart';

class UserBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}