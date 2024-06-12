import 'package:ai_chatbot/app_module/auth/view/auth_screen.dart';
import 'package:ai_chatbot/app_module/chatscreen/controller/chat_request.dart';
import 'package:ai_chatbot/app_module/chatscreen/view/saved_chat_screen.dart';
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
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(AppImages.logoJpg),
            ),
            vSizedBox(height: Get.height * 0.03),
            SizedBox(
              height: screenHeight < 700 ? Get.height * 0.6 : Get.height * 0.7,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profileScreenTitleWidget(
                        icons: AppImages.logoJpg,
                        title: 'Update Profile',
                        onTap: () {
                          // Get.to(() => const UpdateUserProfile());
                          // Get.to(() => UpdateUserProfile());
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: AppText(text: 'Saved Chats'),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("chats")
                          .doc(
                              FirebaseAuth.instance.currentUser?.uid.toString())
                          .collection("allChats")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.size == 0) {
                          return Column(children: [
                            const SizedBox(height: 200),
                            nodDataFound(),
                          ]);
                        }
                        // Process the snapshot data to get the last message from each chat
                        List<Message> lastMessages =
                            snapshot.data!.docs.map((doc) {
                          Map<String, dynamic> data =
                              doc.data() as Map<String, dynamic>;
                          List<dynamic> messageList = data['messages'];
                          // Assuming messages are ordered by timestamp, get the last one
                          return Message.fromJson(messageList.last);
                        }).toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: lastMessages.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(SavedChatScreen(chatID:snapshot.data!.docs[index]['id'],));
                              },
                              child: Column(
                                children: [
                                  hSizedBox(),
                                  SizedBox(
                                    width: Get.width * 0.5,
                                    child: AppText(
                                        text: lastMessages[index].content,
                                        maxLines: 1),
                                  ),
                                  Divider(),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
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
            icons == ''
                ? const SizedBox()
                : CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage(icons!),
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
