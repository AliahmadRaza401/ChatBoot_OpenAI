import 'package:ai_chatbot/app_module/splash/view/splash_view.dart';

import 'package:get/get.dart';
import 'app_bindings.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initialRoute = Routes.initialRoute;

  // static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.initialRoute,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    // GetPage(
    //   name: _Paths.login,
    //   page: () => LoginView(),
    //   binding: AuthBinding(),
    // ),


  ];
}
