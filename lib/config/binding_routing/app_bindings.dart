import 'package:ai_chatbot/app_module/splash/controller/splash_controller.dart';
import 'package:get/get.dart';


// class AuthBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<AuthController>(
//       () => AuthController(),
//     );
//   }
// }

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
          () => SplashController(),
    );


  }
}
