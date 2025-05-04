import 'package:flutter/material.dart';

class CommonUtils {

  void closeKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
}
