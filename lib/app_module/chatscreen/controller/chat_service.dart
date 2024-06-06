import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'chat_request.dart';
import 'chat_response.dart';

class ChatService {
  static String apiKey =
      'sk-proj-nW8cNXFdTsstU6svx23iT3BlbkFJalBFuVA9SPFizViTqKQO';
  static final Uri chatUri =
      Uri.parse('https://api.openai.com/v1/chat/completions');

  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  Future<String?> request(String prompt) async {
    try {
      ChatRequest request = ChatRequest(
          model: "gpt-3.5-turbo",
          maxTokens: 2550,
          messages: [Message(role: "system", content: prompt)]);
      if (prompt.isEmpty) {
        return null;
      }
      http.Response response = await http.post(
        chatUri,
        headers: headers,
        body: request.toJson(),
      );
      ChatResponse chatResponse = ChatResponse.fromResponse(response);
      debugPrint(chatResponse.choices?[0].message?.content);
      SnackBar(content: Text('Message ${chatResponse.choices?[0].message?.content}'),);
      return chatResponse.choices?[0].message?.content;

    } catch (e) {
      debugPrint("error $e");
    SnackBar(content: Text('Error $e'),);
    }
    return null;
  }
}
