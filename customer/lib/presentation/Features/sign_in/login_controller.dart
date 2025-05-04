import 'package:customer/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data source/login_data_source/login_service.dart';

class SignInController extends GetxController {
  final loginService = LoginServiceData();
  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Observable variables
  final password = ''.obs;
  final email = ''.obs;

  final isLoading = false.obs;

  // Text editing controllers
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void onInit() {
    super.onInit();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void onClose() {
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  // Validate user inputs
  bool validateInputs() {
    return formKey.currentState!.validate();
  }

  // Create user account
  customerLogin() async {
    if (validateInputs()) {
      try {
        isLoading.value = true;

        final object = await loginService.signInCustomer(
          password.value,
          email.value,
        );

        print('loginObject: $object');
        isLoading.value = false;

        if (object['statuscode'] == 200) {
          Get.toNamed(AppRoutes.menulist);
        } else {
          Get.snackbar(
            'Information',
            object['message'],
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }

        clearForm();
      } catch (e) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Failed to create user: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  readuser() async {
    loginService.read();
  }

  updateUser() async {
    loginService.updateuser({
      'name': 'Updated Name',
      'email': 'newemail@example.com',
      'mobile': '9876543210',
    });
  }

  // Clear form fields
  void clearForm() {
    passwordController.clear();
    emailController.clear();
    phoneController.clear();
  }
}
