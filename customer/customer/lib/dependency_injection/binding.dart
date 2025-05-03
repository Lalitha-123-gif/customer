import 'package:customer/presentation/Features/menus/menu_view_model.dart';
import 'package:customer/presentation/Features/sign_up/sign_up_controller.dart';
import 'package:get/get.dart';

import '../presentation/Features/sign_in/login_controller.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    // Permanent controllers (throughout app lifecycle)
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
     Get.lazyPut(() => MenuViewController(), fenix: true);

    // // Lazy loaded controllers
    // Get.lazyPut(() => AuthController(), fenix: true);
  }
}
