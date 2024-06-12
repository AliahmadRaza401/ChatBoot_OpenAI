import 'package:ai_chatbot/app_module/auth/view/login_screen.dart';
import 'package:ai_chatbot/app_module/auth/view/signup_screen.dart';
import 'package:ai_chatbot/app_module/chatscreen/view/chat_screen.dart';
import 'package:ai_chatbot/utils/app_imports/app_imports.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  String subTitle =
      "Meet Lenny, your AI-powered personal tutor. Lenny is always by your side, providing simple answers to your complex queries. With Lenny, you'll never feel alone in your learning journey";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: AppPaddings.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    vSizedBox(height: Get.height * 0.1),
                    Image.asset(AppImages.logoLennyByqVault),
                    vSizedBox(),

                    CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage(AppImages.logoJpg),),
                    vSizedBox(),
                    AppText(text: "By qVault.ai",size: AppDimensions.FONT_SIZE_14),
                    vSizedBox(height: Get.height* 0.08),
                    AppText(
                        text: 'Your Personal Tutor, Lenny',
                        size: AppDimensions.FONT_SIZE_20,
                        fontWeight: FontWeight.w600),
                    vSizedBox(),
                    SizedBox(
                      width: Get.width / 1.2,
                      child: AppText(
                        text: subTitle,
                        size: AppDimensions.FONT_SIZE_16,
                        color: AppColors.GRAY,
                      ),
                    ),
                    vSizedBox(),
                    GestureDetector(
                      onTap: () {
                        Get.to(ChatPage(
                          isSkip: true,
                        ));
                      },
                      child: CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.PRIMARY_COLOR,
                          child: Icon(
                            Icons.arrow_forward,
                            color: AppColors.WHITE_COLOR,
                            size: 30,
                          )),
                    ),

                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppButton(
                buttonName: "Sign up With Email",
                buttonWidth: Get.width,
                buttonRadius: AppBorderRadius.BORDER_RADIUS_10,
                isIcon: true,
                iconImage: AppImages.emailIcon,
                imageIconColor: AppColors.WHITE_COLOR,
                buttonColor: AppColors.PRIMARY_COLOR,
                textColor: AppColors.WHITE_COLOR,
                onTap: () {
                  Get.to(SignupScreen());
                }),
          ),
          vSizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppButton(
                buttonName: "Login To Existing Account",
                buttonWidth: Get.width,
                buttonRadius: AppBorderRadius.BORDER_RADIUS_10,
                borderColor: AppColors.PRIMARY_COLOR,
                buttonColor: AppColors.WHITE_COLOR,
                textColor: AppColors.PRIMARY_COLOR,
                onTap: () {
                  Get.to(LoginScreen());
                }),
          ),
          vSizedBox(height: Get.height *0.05),
        ],
      ),
    );
  }
}
