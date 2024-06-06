import 'package:ai_chatbot/app_module/auth/view/auth_screen.dart';
import 'package:ai_chatbot/utils/app_imports/app_imports.dart';
import 'package:flutter_svg/svg.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  var loggedInData = storageBox.read(StorageConstants.loggedInData);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // print(screenHeight);
    return Drawer(
        child: Padding(
          padding: AppPaddings.horizontal,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox(height: Get.height * 0.1),
                Image.asset(
                  AppImages.logoJpg,
                  scale: 6,
                ),
                vSizedBox(height: Get.height * 0.03),
                SizedBox(
                  height: screenHeight < 700 ? Get.height * 0.6 : Get.height * 0.7,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        profileScreenTitleWidget(
                            icons: AppImages.logoJpg,
                            title: 'Update Profile',
                            onTap: () {
                              // Get.to(() => const UpdateUserProfile());
                              // Get.to(() => UpdateUserProfile());
                            }),
                         profileScreenTitleWidget(
                            icons: AppImages.logoutIcon,
                            title: 'Log Out',
                            onTap: () async {
                              Get.offAll(AuthScreen());
                              storageBox.erase();
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  profileScreenTitleWidget({
    String? icons,
    String? title,
    VoidCallback? onTap,
    double height = 18,
    double width = 18,
  }) {
    return GestureDetector(
      onTap: onTap!,
      child: Container(
        padding: AppPaddings.defaultPadding,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.BORDER_RADIUS_10,
        ),
        child: Row(
          children: [
            Image.asset(
              icons!,
              height: height,
              width: width,
            ),
            hSizedBox(),
            AppText(
                text: title!,
                color: AppColors.GRAY,
                fontWeight: FontWeight.w500)
          ],
        ),
      ),
    );
  }
}