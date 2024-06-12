import 'package:ai_chatbot/Utils/app_imports/app_imports.dart';
import 'package:ai_chatbot/app_module/auth/controller/auth_controller.dart';
import 'package:ai_chatbot/app_module/auth/view/login_screen.dart';
import 'package:ai_chatbot/app_module/chatscreen/controller/chat_controller.dart';
import 'package:ai_chatbot/app_module/chatscreen/controller/chat_request.dart';
import 'package:ai_chatbot/app_module/chatscreen/controller/chat_service.dart';
import 'package:ai_chatbot/app_module/chatscreen/view/custom_drawer.dart';
import 'package:ai_chatbot/utils/app_imports/app_imports.dart';

class SavedChatScreen extends StatefulWidget {
  String chatID;
  SavedChatScreen({
    super.key,
    required this.chatID,
  });

  @override
  _SavedChatScreenState createState() => _SavedChatScreenState();
}

class _SavedChatScreenState extends State<SavedChatScreen> {
  AuthController authController = Get.put(AuthController());
  ChatController chatController = Get.put(ChatController());
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  final ChatService _chatService = ChatService();
  bool _isLoading = false;
  int _messageCount = 0;
  int? _loadingMessageIndex;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchMessages();
    });
  }

  void fetchMessages() async {
    try {
      List<Message> messages =
          await chatController.getSavedChat(chatID: widget.chatID);
      setState(() {
        _messages.clear();
        _messages.addAll(messages);
      });
    } catch (e) {
      customSnackBar(title: "Failed to fetch chat: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          PrimaryAppBar(
            titleText: 'Saved Chat',
            appbarColor: AppColors.backgroundColor,
            isPrefix: true,
            isSuffix: false,
            prefixIconImage: AppImages.backIcon,
            prefixOnTap: () {
              Get.back();
            },
          ),
          Obx(() => chatController.isLoading.isTrue
              ? customLoader(AppColors.RED_COLOR)
              : Expanded(
                  child: ListView.builder(
                    itemCount: _messages.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (_isLoading && index == _messages.length) {
                        return ListTile(
                          title: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.TRANSPARENT_COLOR,
                                radius: 14,
                                backgroundImage:
                                    const AssetImage(AppImages.logoJpg),
                              ),
                              hSizedBox(width: 5),
                              AppText(
                                  text: "Lenny",
                                  color: AppColors.BLACK.withOpacity(0.7),
                                  fontWeight: FontWeight.w600),
                              hSizedBox(width: 5),
                              customLoader(AppColors.PRIMARY_COLOR)
                            ],
                          ),
                        );
                      }
                      final message = _messages[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.TRANSPARENT_COLOR,
                                  radius: 14,
                                  backgroundImage: message.role == 'user'
                                      ? null
                                      : const AssetImage(AppImages.logoJpg),
                                ),
                                hSizedBox(width: 5),
                                AppText(
                                    text: message.role == 'user' ? "" : "Lenny",
                                    color: AppColors.BLACK.withOpacity(0.7),
                                    fontWeight: FontWeight.w600),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: message.role == 'user'
                                      ? AppColors.lightColor
                                      : AppColors.lightColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: AppText(
                                  text: message.content,
                                  color: AppColors.BLACK.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )),
        ],
      ),
    );
  }

  buttonRow({
    String? text1,
    String? text2,
    VoidCallback? onTap1,
    VoidCallback? onTap2,
  }) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: AppBorderRadius.BORDER_RADIUS_10,
                border: Border.all(
                  color: AppColors.PRIMARY_COLOR.withOpacity(0.3),
                ),
              ),
              child: AppText(text: text1!, textAlign: TextAlign.center),
            ),
          ),
        ),
        hSizedBox(),
        Expanded(
          child: GestureDetector(
            onTap: onTap2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: AppBorderRadius.BORDER_RADIUS_10,
                border: Border.all(
                  color: AppColors.PRIMARY_COLOR.withOpacity(0.3),
                ),
              ),
              child: AppText(text: text2!, textAlign: TextAlign.center),
            ),
          ),
        )
      ],
    );
  }
}
