import 'package:ai_chatbot/Utils/app_imports/app_imports.dart';
import 'package:ai_chatbot/app_module/auth/controller/auth_controller.dart';
import 'package:ai_chatbot/app_module/auth/view/login_screen.dart';
import 'package:ai_chatbot/app_module/chatscreen/controller/chat_controller.dart';
import 'package:ai_chatbot/app_module/chatscreen/controller/chat_request.dart';
import 'package:ai_chatbot/app_module/chatscreen/controller/chat_service.dart';
import 'package:ai_chatbot/app_module/chatscreen/view/custom_drawer.dart';
import 'package:ai_chatbot/utils/app_imports/app_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  bool isSkip;
  ChatPage({
    super.key,
    this.isSkip = false,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.put(AuthController());
  ChatController chatController = Get.put(ChatController());
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  final ChatService _chatService = ChatService();
  bool _isLoading = false;
  int _messageCount = 0;
  int? _loadingMessageIndex;

  // void _sendMessage() async {
  //   // if (widget.isSkip = true && _messageCount > 2) {
  //   //   customSnackBar(title: "Please Login to use more");
  //   //   return;
  //   // }
  //   if (_controller.text.isEmpty) return;
  //   setState(() {
  //     _messages.add(Message(role: "user", content: _controller.text));
  //     _isLoading = true;
  //     _messageCount++;
  //   });
  //   final response = await _chatService.request(_controller.text);
  //   setState(() {
  //     if (response != null) {
  //       _messages.add(Message(role: "system", content: response));
  //     }
  //     _isLoading = false;
  //   });
  //
  //   _controller.clear();
  // }
  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    final messageIndex = _messages.length;
    setState(() {
      _messages.add(Message(role: "user", content: _controller.text));
      _isLoading = true;
      _loadingMessageIndex = messageIndex;
    });

    final response = await _chatService.request(_controller.text);
    setState(() {
      if (response != null) {
        _messages.add(Message(role: "system", content: response));
      }
      _isLoading = false;
      _loadingMessageIndex = null;
    });

    _controller.clear();
  }

  @override
  void initState() {
    super.initState();
    // if(!widget.isSkip){
    authController.getUserData();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          PrimaryAppBar(
            titleText: 'Lenny',
            appbarColor: AppColors.backgroundColor,
            isPrefix: true,
            isSuffix: false,
            isActions: true,
            prefixIconImage: AppImages.menuIcon,
            actions: [
              widget.isSkip
                  ? AppButton(
                      buttonName: "Login",
                      buttonRadius: AppBorderRadius.BORDER_RADIUS_100,
                      buttonColor: AppColors.PRIMARY_COLOR,
                      buttonHeight: 35,
                      buttonWidth: 80,
                      textColor: AppColors.WHITE_COLOR,
                      onTap: () {
                        Get.offAll(LoginScreen());
                      })
                  : Obx(() => chatController.isLoading.isTrue
                      ? customLoader(AppColors.PRIMARY_COLOR)
                      : AppButton(
                          buttonName: "Save Chat",
                          buttonRadius: AppBorderRadius.BORDER_RADIUS_100,
                          buttonColor: AppColors.PRIMARY_COLOR,
                          buttonHeight: 35,
                          buttonWidth: 100,
                          textColor: AppColors.WHITE_COLOR,
                          onTap: () {
                            chatController.saveChat(messages: _messages);
                          },
                        ))
            ],
            prefixOnTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          Obx(() => authController.isLoading.isTrue
              ? customLoader(AppColors.RED_COLOR)
              : Expanded(
                  child: _messages.isEmpty
                      ? SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [
                                vSizedBox(),
                                const CircleAvatar(
                                  radius: 100,
                                  backgroundImage:
                                      AssetImage(AppImages.logoJpg),
                                ),
                                vSizedBox(),
                                AppText(
                                    text: "By qVault.ai",
                                    size: AppDimensions.FONT_SIZE_14),
                                vSizedBox(),
                                AppText(
                                    text:
                                        "Concise Answers for Medical Students. Simple & Straightforward.",
                                    textAlign: TextAlign.center,
                                    size: AppDimensions.FONT_SIZE_16),
                                vSizedBox(),
                                buttonRow(
                                    text1: "RA vs QA",
                                    text2: "Th1 vs Th2",
                                    onTap1: () {},
                                    onTap2: () {}),
                                vSizedBox(),
                                buttonRow(
                                    text1: "Why does alcohol cause polyuria",
                                    text2: "Hypersensitivity Types",
                                    onTap1: () {},
                                    onTap2: () {}),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _messages.length + (_isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (_isLoading && index == _messages.length) {
                              return ListTile(
                                title: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          AppColors.TRANSPARENT_COLOR,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            AppColors.TRANSPARENT_COLOR,
                                        radius: 14,
                                        backgroundImage: message.role == 'user'
                                            ? null
                                            : const AssetImage(
                                                AppImages.logoJpg),
                                      ),
                                      hSizedBox(width: 5),
                                      AppText(
                                          text: message.role == 'user'
                                              ? ""
                                              : "Lenny",
                                          color:
                                              AppColors.BLACK.withOpacity(0.7),
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
          _isLoading
              ? customLoader(AppColors.PRIMARY_COLOR)
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: AppBorderRadius.BORDER_RADIUS_100,
                        color: AppColors.backgroundColor),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _controller,
                            borderRadius: 100,
                            isPrefix: false,
                            hint: 'Ask Lenny',
                          ),
                        ),
                        hSizedBox(),
                        GestureDetector(
                          onTap: _sendMessage,
                          child: Container(
                            padding: AppPaddings.defaultPadding,
                            decoration: BoxDecoration(
                                borderRadius: AppBorderRadius.BORDER_RADIUS_100,
                                color: AppColors.PRIMARY_COLOR),
                            child: Image.asset(
                              AppImages.sendIcon,
                              color: AppColors.WHITE_COLOR,
                              scale: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
          _isLoading ? vSizedBox() : vSizedBox(height: 10)
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
