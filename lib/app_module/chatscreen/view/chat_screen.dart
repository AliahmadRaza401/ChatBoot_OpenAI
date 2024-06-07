import 'package:ai_chatbot/Utils/app_imports/app_imports.dart';
import 'package:ai_chatbot/app_module/auth/controller/auth_controller.dart';
import 'package:ai_chatbot/app_module/auth/view/login_screen.dart';
import 'package:ai_chatbot/app_module/chatscreen/controller/chat_request.dart';
import 'package:ai_chatbot/app_module/chatscreen/controller/chat_service.dart';
import 'package:ai_chatbot/app_module/chatscreen/view/custom_drawer.dart';
import 'package:ai_chatbot/utils/app_imports/app_imports.dart';
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
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  final ChatService _chatService = ChatService();
  bool _isLoading = false;
  int _messageCount = 0;
  void _sendMessage() async {
    // if (widget.isSkip = true && _messageCount > 2) {
    //   customSnackBar(title: "Please Login to use more");
    //   return;
    // }
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.add(Message(role: "user", content: _controller.text));
      _isLoading = true;
      _messageCount++;
    });
    final response = await _chatService.request(_controller.text);
    setState(() {
      if (response != null) {
        _messages.add(Message(role: "system", content: response));
      }
      _isLoading = false;
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
            titleText: 'Ai Chat',
            appbarColor: AppColors.backgroundColor,
            isPrefix: true,
            isSuffix: false,
            isActions: widget.isSkip,
            prefixIconImage: AppImages.menuIcon,
            actions: [
              AppButton(
                  buttonName: "Login",
                  buttonRadius: AppBorderRadius.BORDER_RADIUS_100,
                  buttonColor: AppColors.PRIMARY_COLOR,
                  buttonHeight: 35,
                  buttonWidth: 80,
                  textColor: AppColors.WHITE_COLOR,
                  onTap: () {
                    Get.offAll(LoginScreen());
                  })
            ],
            prefixOnTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          Obx(() => authController.isLoading.isTrue
              ? customLoader(AppColors.RED_COLOR)
              : Expanded(
                  child: _messages.isEmpty
                      ? Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  vSizedBox(height: Get.height * 0.1),
                                  Image.asset(
                                    AppImages.logoJpg,
                                    scale: 3,
                                  ),
                                  AppText(
                                      text:
                                          "Hello, Boss!\n Am Ready For Help You",
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.PRIMARY_COLOR_DARK,
                                      size: AppDimensions.FONT_SIZE_30),
                                  vSizedBox(),
                                  AppText(
                                      text:
                                          "Ask me anything what's on your mind. Am here to Assist you!",
                                      textAlign: TextAlign.center,
                                      // fontWeight: FontWeight.w700,
                                      color: AppColors.GRAY,
                                      size: AppDimensions.FONT_SIZE_16)
                                ],
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
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
                                        backgroundColor: message.role == 'user'
                                            ? AppColors.PRIMARY_COLOR
                                                .withOpacity(0.5)
                                            : AppColors.GRAY.withOpacity(0.5),
                                        radius: 14,
                                        child: message.role == 'user'
                                            ? AppText(
                                                text: widget.isSkip == true
                                                    ? "U"
                                                    : authController
                                                        .user
                                                        .value!
                                                        .userName
                                                        .characters
                                                        .first)
                                            : Image.asset(
                                                AppImages.logoJpg,
                                                height: 18,
                                              ),
                                      ),
                                      hSizedBox(width: 05),
                                      AppText(
                                          text: message.role == 'user'
                                              ? widget.isSkip == true
                                                  ? "User"
                                                  : authController
                                                      .user.value!.userName
                                              : "Ai Chatbot",
                                          color:
                                              AppColors.BLACK.withOpacity(0.7),
                                          fontWeight: FontWeight.w600),
                                    ],
                                  ),
                                ),
                                ListTile(
                                  title: Align(
                                    alignment:
                                        // message.role == 'user'
                                        //     ? Alignment.centerRight
                                        //     :
                                        Alignment.centerLeft,
                                    child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: message.role == 'user'
                                              ? AppColors.PRIMARY_COLOR
                                                  .withOpacity(0.1)
                                              : AppColors.GRAY.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: AppText(
                                            text: message.content,
                                            color: AppColors.BLACK
                                                .withOpacity(0.7))),
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
                            hint: 'Type here...',
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
}

// import 'package:ai_chatbot/chatscreen/controller/chat_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   TextEditingController promptController = TextEditingController();
//   String? response;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Text(
//                       response ?? "",
//                       style: TextStyle(color: Colors.grey.shade800),
//                     ),
//                   ),
//                   // ElevatedButton(
//                   //     style: ButtonStyle(
//                   //         padding: MaterialStateProperty.all(
//                   //             const EdgeInsets.symmetric(
//                   //                 horizontal: 80, vertical: 20)),
//                   //         backgroundColor:
//                   //             MaterialStateProperty.all(Colors.deepPurple)),
//                   //     onPressed: () async {
//                   //       response =
//                   //           await ChatService().request(promptController.text);
//                   //       setState(() {});
//                   //     },
//                   //     child: const Text(
//                   //       "Submit",
//                   //       style: TextStyle(color: Colors.white),
//                   //     ))
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: 360,
//                     height: 80,
//                     child: TextFormField(
//                       controller: promptController,
//                       maxLines: 1,
//                       decoration: const InputDecoration(
//                         labelText: "Prompt",
//                         hintText: "Enter your prompt here",
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: ()async{
//                       response =
//                           await ChatService().request(promptController.text);
//                       setState(() {});
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 05, horizontal: 16),
//                       decoration:
//                           BoxDecoration(
//                             color:Colors.blue,
//                             borderRadius: BorderRadius.circular(100),
//
//                           ),
//                       child: const Icon(Icons.send),
//                     ),
//                   )
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }
