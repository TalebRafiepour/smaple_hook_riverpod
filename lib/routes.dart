import 'package:flutter/material.dart';
import 'package:sample_hook_riverpod/home_page.dart';
import 'package:sample_hook_riverpod/verify_otp_page.dart';

import 'login_page.dart';

abstract class NavigationPaths {
  static const String home = '/home';
  static const String login = '/login';
  static const String verifyLogin = '/login/verify';
}

abstract class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationPaths.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case NavigationPaths.verifyLogin:
        return MaterialPageRoute(builder: (_) => VerifyOtpPage());

      case NavigationPaths.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }

  static NavigatorState get _state => navigatorKey.currentState!;

  static Future push<T extends Object>(String route, [T? arguments]) =>
      _state.pushNamed(route, arguments: arguments);

  static Future replaceWith<T extends Object>(String route, [T? arguments]) =>
      _state.pushReplacementNamed(route, arguments: arguments);

  static Future removeUntil<T extends Object>(String route, [T? arguments]) =>
      _state.pushNamedAndRemoveUntil(route, (route) => false,
          arguments: arguments);

  static void pop() => _state.pop();
}
