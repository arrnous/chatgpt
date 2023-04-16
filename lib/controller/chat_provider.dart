import 'package:chatapp/model/chat_model.dart';
import 'package:chatapp/services/api_service.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) async {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> getMessageAnswer(
      {required String msg, required String chosenModelID}) async {
    if (chosenModelID.toLowerCase().startsWith("gpt")) {
      chatList.addAll(await ApiServices.sendMessage(
        msg: msg,
        modelId: chosenModelID,
      ));
    } else {
      chatList.addAll(await ApiServices.sendMessage(
        msg: msg,
        modelId: chosenModelID,
      ));
    }
    notifyListeners();
  }
}
