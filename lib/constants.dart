import 'dart:ui';

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled19/Authentication/Forgot_password/forgotpass.dart';
import 'package:untitled19/Authentication/Sign_in/my_login.dart';
import 'package:untitled19/authentification/signup.dart';
import 'package:untitled19/user/client_home_page.dart';

import 'Splash_screen/splashscreen.dart';
import 'admin/admin_home.dart';

class Constants {
  static List<GetPage> routes = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/login', page: () => MyLogin()),
    GetPage(
      name: '/reset_password',
      page: () => ForgotPassScreen(),
    ),
    GetPage(
      name: '/sign_up',
      page: () => SignUp(),
    ),
    GetPage(
      name: '/client_home',
      page: () => ClientHomePage(),
    ),
    GetPage(
      name: '/admin_home',
      page: () => AdminHomePage(),
    ),
  ];
  static var user = GetStorage().read("user");

  static String HomeText = "Bienvenue chez Municipalité";
  static var screenWidth = (window.physicalSize.shortestSide / window.devicePixelRatio);
  static var screenHeight = (window.physicalSize.longestSide / window.devicePixelRatio);
}
