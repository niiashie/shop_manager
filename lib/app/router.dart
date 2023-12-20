import 'package:flutter/material.dart';
import 'package:shop_manager/constants/routes.dart';
import 'package:shop_manager/ui/dashboard/dashboard.view.dart';
import 'package:shop_manager/ui/login/login.view.dart';
import 'package:shop_manager/ui/registration/registration.view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case Routes.register:
        return MaterialPageRoute(
            builder: (context) => const RegistrationView());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (context) => const DashBoardView());
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
