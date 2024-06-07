import 'package:ai_chatbot/app_module/auth/view/login_screen.dart';
import 'package:ai_chatbot/app_module/auth/view/signup_screen.dart';
import 'package:ai_chatbot/app_module/chatscreen/view/chat_screen.dart';
import 'package:ai_chatbot/utils/app_imports/app_imports.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  String subTitle =
      "No login required for get started chat with our Ai powered chat bot.\nFeel free to ask what you want to know.";

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox(height: Get.height * 0.1),
                    AppText(
                        text: 'Start Free Conversation',
                        size: AppDimensions.FONT_SIZE_45,
                        fontWeight: FontWeight.w600),
                    AppText(
                        text: subTitle,
                        size: AppDimensions.FONT_SIZE_16,
                        color: AppColors.GRAY),
                    vSizedBox(height: Get.height * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                    vSizedBox(height: Get.height * 0.1),
                    AppButton(
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
                    vSizedBox(),
                    AppButton(
                        buttonName: "Login To Existing Account",
                        buttonWidth: Get.width,
                        buttonRadius: AppBorderRadius.BORDER_RADIUS_10,
                        borderColor: AppColors.PRIMARY_COLOR,
                        buttonColor: AppColors.WHITE_COLOR,
                        textColor: AppColors.PRIMARY_COLOR,
                        onTap: () {
                          Get.to(LoginScreen());
                        })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
