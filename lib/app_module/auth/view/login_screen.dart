import 'package:ai_chatbot/Utils/app_imports/app_imports.dart';
import 'package:ai_chatbot/app_module/auth/controller/auth_controller.dart';
import 'package:ai_chatbot/app_module/auth/view/signup_screen.dart';
import 'package:ai_chatbot/app_module/chatscreen/view/chat_screen.dart';
import 'package:ai_chatbot/utils/app_imports/app_imports.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  AuthController authController = Get.put(AuthController());

  String subTitle =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book";

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
                        text: 'Welcome Back to Login!',
                        size: AppDimensions.FONT_SIZE_26,
                        fontWeight: FontWeight.w600),
                    vSizedBox(),
                    AppText(
                        text:
                            'Login to your account. Get easier than search engines results',
                        size: AppDimensions.FONT_SIZE_16,
                        color: AppColors.GRAY),
                    vSizedBox(height: Get.height * 0.1),
                    AppText(
                        text: 'Email',
                        size: AppDimensions.FONT_SIZE_16,
                        color: AppColors.GRAY),
                    vSizedBox(),
                    AppTextField(
                      controller: authController.emailController,
                      borderRadius: AppDimensions.FONT_SIZE_10,
                      isPrefix: true,
                      hint: 'Joesamanta@gmail.com',
                      icon: Image.asset(
                        AppImages.emailIcon,
                        scale: 16,
                        color: AppColors.GRAY,
                      ),
                    ),
                    vSizedBox(),
                    AppText(
                        text: 'Password',
                        size: AppDimensions.FONT_SIZE_16,
                        color: AppColors.GRAY),
                    vSizedBox(),
                    Obx(() => AppTextField(
                        controller: authController.passwordController,
                        borderRadius: AppDimensions.FONT_SIZE_10,
                        isPrefix: true,
                        isSuffix: true,
                        hint: 'Password',
                        obscureText: authController.getShowPassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            authController.setShowPassword =
                                authController.getShowPassword == false
                                    ? true
                                    : false;
                          },
                          child: Icon(
                            authController.getShowPassword == false
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.PRIMARY_COLOR,
                          ),
                        ),
                        icon: Icon(
                          Icons.lock_outline,
                          color: AppColors.GRAY,
                          size: 28,
                        ))),
                    vSizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppText(
                            text: 'Rest password',
                            size: AppDimensions.FONT_SIZE_16,
                            color: AppColors.RED_COLOR),
                      ],
                    ),
                    vSizedBox(),
                    Obx(
                        // Use Obx to update the checkbox when the state changes
                        () => Row(
                              children: [
                                Checkbox(
                                  value: authController.getChecked,
                                  onChanged: (bool? value) {
                                    authController.setChecked = value;
                                  },
                                ),
                                hSizedBox(width: 10),
                                AppText(
                                  text: 'Remember Login Info',
                                  size: AppDimensions.FONT_SIZE_16,
                                  color: authController.getChecked
                                      ? AppColors.PRIMARY_COLOR
                                      : AppColors.GRAY,
                                ),
                              ],
                            )),
                    vSizedBox(),
                    Obx(() => authController.isLoading.isTrue
                        ? customLoader(AppColors.PRIMARY_COLOR)
                        : AppButton(
                            buttonName: "Login",
                            buttonWidth: Get.width,
                            buttonRadius: AppBorderRadius.BORDER_RADIUS_10,
                            buttonColor: AppColors.PRIMARY_COLOR,
                            textColor: AppColors.WHITE_COLOR,
                            onTap: () {
                              authController.signInWithEmailAndPassword();
                            })),
                    vSizedBox(),
                    GestureDetector(
                      onTap: () {
                        Get.to(SignupScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                              text: "Don't have an account?",
                              size: AppDimensions.FONT_SIZE_14,
                              color: AppColors.GRAY,
                              fontWeight: FontWeight.w600),
                          AppText(
                              text: "Create an account",
                              size: AppDimensions.FONT_SIZE_14,
                              color: AppColors.PRIMARY_COLOR,
                              fontWeight: FontWeight.w600),
                        ],
                      ),
                    )
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
