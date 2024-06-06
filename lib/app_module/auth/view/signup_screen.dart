import 'package:ai_chatbot/Utils/app_imports/app_imports.dart';
import 'package:ai_chatbot/app_module/auth/controller/auth_controller.dart';
import 'package:ai_chatbot/app_module/auth/view/login_screen.dart';
import 'package:ai_chatbot/app_module/chatscreen/view/chat_screen.dart';
import 'package:ai_chatbot/utils/app_imports/app_imports.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
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
                        text: 'Create an account',
                        size: AppDimensions.FONT_SIZE_26,
                        fontWeight: FontWeight.w600),
                    vSizedBox(),
                    AppText(
                        text:
                            'Signup for a free account. Get easier than search engines results.',
                        size: AppDimensions.FONT_SIZE_16,
                        color: AppColors.GRAY),
                    vSizedBox(height: Get.height * 0.1),
                    AppText(
                        text: 'Email',
                        size: AppDimensions.FONT_SIZE_16,
                        color: AppColors.GRAY),
                    vSizedBox(height: 10),
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
                    vSizedBox(height: 10),
                    Obx(() => AppTextField(
                        controller: authController.passwordController,
                        borderRadius: AppDimensions.FONT_SIZE_10,
                        isPrefix: true,
                        isSuffix: true,
                        hint: 'Create Strong Password',
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
                    AppText(
                        text: 'Confirm Password',
                        size: AppDimensions.FONT_SIZE_16,
                        color: AppColors.GRAY),
                    vSizedBox(height: 10),
                    Obx(() => AppTextField(
                        controller: authController.confirmController,
                        borderRadius: AppDimensions.FONT_SIZE_10,
                        isPrefix: true,
                        isSuffix: true,
                        hint: 'Confirm Password',
                        obscureText: authController.getShowConfirmPassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            authController.setShowConfirmPassword =
                                authController.getShowConfirmPassword == false
                                    ? true
                                    : false;
                          },
                          child: Icon(
                            authController.getShowConfirmPassword == false
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
                    Obx(
                        // Use Obx to update the checkbox when the state changes
                        () => Row(
                              children: [
                                Checkbox(
                                  value: authController.getSavedPassword,
                                  onChanged: (bool? value) {
                                    authController.setSavedPassword = value;
                                  },
                                ),
                                hSizedBox(width: 10),
                                AppText(
                                  text: 'Save Password',
                                  size: AppDimensions.FONT_SIZE_16,
                                  color: authController.getSavedPassword
                                      ? AppColors.PRIMARY_COLOR
                                      : AppColors.GRAY,
                                ),
                              ],
                            )),
                    vSizedBox(height: Get.height * 0.15),
                    Obx(() => authController.isLoading.isTrue
                        ? customLoader(AppColors.RED_COLOR)
                        : AppButton(
                            buttonName: "Create Account",
                            buttonWidth: Get.width,
                            buttonRadius: AppBorderRadius.BORDER_RADIUS_10,
                            buttonColor: AppColors.PRIMARY_COLOR,
                            textColor: AppColors.WHITE_COLOR,
                            onTap: () {
                              authController.signUp();
                            })),
                    vSizedBox(),
                    GestureDetector(
                      onTap: () {
                        Get.to(LoginScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                              text: "Already have an account?",
                              size: AppDimensions.FONT_SIZE_14,
                              color: AppColors.GRAY,
                              fontWeight: FontWeight.w600),
                          AppText(
                              text: "Login",
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
