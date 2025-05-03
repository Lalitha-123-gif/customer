import 'package:customer/common_utils/common_utils.dart';
import 'package:customer/data/data%20source/login_data_source/sign_up_data_source/sign_up_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameContoller = TextEditingController();
  TextEditingController emailContoller = TextEditingController();
  TextEditingController mobileContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final singupService = SignUpService();
  final CommonUtils utils = CommonUtils();

  final formKey = GlobalKey<FormState>();

  RxString firstname = ''.obs;
  RxString lastname = ''.obs;
  RxString mobile = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    print('');
    super.onInit();
  }

  signUp() async {
    isLoading.value = true;
    final response = await singupService.customerSignUp({
      "first_name": firstname.value,
      "last_name": lastname.value,
      "mobile": mobile.value,
      "email": email.value,
      "password": password.value,
    });

    isLoading.value = false;

    if (response['success'] == true) {
      Get.snackbar(
        'Information',
        response['message'],
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      return true;
    } else {
      Get.snackbar(
        'Information',
        response['message'],
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    }
  }

  togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void dismissKeyboard() async {
    utils.closeKeyboard();
  }
}
