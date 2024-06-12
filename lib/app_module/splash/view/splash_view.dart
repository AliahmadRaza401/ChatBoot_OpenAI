import 'package:ai_chatbot/app_module/auth/view/auth_screen.dart';
import 'package:ai_chatbot/app_module/chatscreen/view/chat_screen.dart';

import '../../../utils/app_imports/app_imports.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _scaleAnimation;
  DateTime? trialEndDate;
  bool? isTrialExpired;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller!);

    Future.delayed(const Duration(seconds: 3), () async {
      // var loggedInData = storageBox.read(StorageConstants.loggedInData);

      // debugPrint('loggedInData ; ${loggedInData.toString()}');

      // if (storageBox.read(StorageConstants.isOnboarding) == 'false' ||
      //     storageBox.read(StorageConstants.isOnboarding) == null) {
      //   storageBox.write(StorageConstants.isOnboarding, 'true');
      //   // Get.to(const OnBoardingScreen());
      // } else {
      //   if (storageBox.read(StorageConstants.isLogin) == 'true' &&
      //       storageBox.read(StorageConstants.userType) != null) {
      //     // Get.offAll(CustomBottomNavBar());
      //   } else {
      if (storageBox.read(StorageConstants.isLogin) == 'true' &&
          storageBox.read(StorageConstants.userType) != null) {
        Get.offAll(ChatPage());
      } else {
        Get.to(AuthScreen());
      }

      // }
      // }
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller!,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation!.value,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage(
                        AppImages.logoJpg,
                      ),
                    ),
                    vSizedBox(),
                    AppText(text: "By qVault.ai",size: AppDimensions.FONT_SIZE_14),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
