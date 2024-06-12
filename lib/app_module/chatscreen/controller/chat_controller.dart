import 'package:ai_chatbot/Utils/app_imports/app_imports.dart';
import 'package:ai_chatbot/app_module/chatscreen/controller/chat_request.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;
  // RxList<Message> savedMessages = <Message>[].obs;
  Future<void> saveChat({List<Message>? messages}) async {
    try {
      isLoading(true);
      var randomID = HelperFunctions().getRandomString(15);
      final collection = FirebaseFirestore.instance
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection("allChats")
          .doc(randomID);
      await collection.set({
        'timestamp': FieldValue.serverTimestamp(),
        'id': randomID,
        'messages': messages!.map((msg) => msg.toJson()).toList(),
      });
      customSnackBar(title: "Chat saved successfully!");
    } catch (e) {
      customSnackBar(title: "Failed to save chat: $e");
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future<List<Message>> getSavedChat({required String chatID}) async {
    List<Message> savedMessages = [];

    try {
      isLoading(true);
      final snapshot = await FirebaseFirestore.instance
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection("allChats")
          .doc(chatID)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null && data.containsKey('messages')) {
          final List<dynamic> messageList = data['messages'];
          savedMessages.addAll(messageList.map((msg) => Message.fromJson(msg)));
          isLoading(false);
        }
        isLoading(false);
      } else {
        customSnackBar(title: "Chat not found");
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      customSnackBar(title: "Failed to fetch chat: $e");
    }

    return savedMessages;
  }
}
