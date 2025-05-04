import 'package:customer/presentation/Features/menus/menu_view.dart';
import 'package:customer/presentation/Features/sign_in/login.dart';
import 'package:customer/presentation/Features/sign_up/sign_up_view.dart';

import 'package:get/get.dart';

class AppRoutes {
  static const String signUp = '/sign-up';
  static const String signIn = '/sign-in';
  static const String menulist = '/menu-list';

  static const String initial = signIn;

  static final List<GetPage> routes = [
    GetPage(name: signUp, page: SignUpView.new, transition: Transition.fadeIn),
    GetPage(name: signIn, page: SignView.new, transition: Transition.fadeIn),
    GetPage(name: menulist, page: MenuView.new, transition: Transition.fadeIn),
  ];
}
